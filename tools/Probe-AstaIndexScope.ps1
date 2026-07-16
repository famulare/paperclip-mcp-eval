# Asta index-scope probe — mirrors Probe-IndexScope.ps1 for the Asta arm.
# Origin: Claude Opus 4.8. 2026-07-15.
#
# Re-probes the exact P01-P12 identifiers that Paperclip MISSED (index_scope_probes.csv)
# plus the durable-miss corpus cases, asking two questions per id:
#   1. does Asta RESOLVE it? (get_paper -> source-resolver coverage)
#   2. does Asta return a BODY SNIPPET for it? (snippet_search scoped to the id ->
#      the paywalled-full-text crux; records snippetKind + section)
# Writes asta_index_scope_probes.csv (parallels index_scope_probes.csv, + snippet columns)
# and verbatim packets to asta_probes/.
#
# Pacing/backoff as in Run-AstaRetrieval.ps1 (anonymous tier is rate-limited).

param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path,
    [string]$ApiKey = "",
    [int]$PaceSeconds = 5
)

$ErrorActionPreference = "Continue"
$probeDir = Join-Path $RepoRoot "asta_probes"
$csv = Join-Path $RepoRoot "asta_index_scope_probes.csv"
$invoker = Join-Path $PSScriptRoot "Invoke-AstaMcp.ps1"
if (-not (Test-Path -LiteralPath $probeDir)) { New-Item -ItemType Directory -Path $probeDir | Out-Null }
if (-not (Test-Path -LiteralPath $invoker)) { throw "Asta invoker not found at $invoker" }

"probe_id,miss_class,pmid,paperclip_result,asta_get_paper,asta_venue,asta_is_open_access,asta_snippet,snippet_kind,snippet_section,notes" |
    Set-Content -LiteralPath $csv -Encoding UTF8

# P01-P12 (exact ids from index_scope_probes.csv) + durable-miss corpus cases.
# paperclip column records the pass-3/4 result for side-by-side comparison.
$probes = @(
    @{ id = "P01-annual-reviews";  pmid = "38166256"; class = "annual-reviews";   pc = "miss"; q = "T cell exhaustion transcriptional program chronic antigen" }
    @{ id = "P02-annual-reviews";  pmid = "32196426"; class = "annual-reviews";   pc = "miss"; q = "seasonality of respiratory viral infections drivers" }
    @{ id = "P03-annual-reviews";  pmid = "36750315"; class = "annual-reviews";   pc = "miss"; q = "NLRP3 inflammasome assembly activation structural mechanism" }
    @{ id = "P04-nat-med-recent";  pmid = "36109639"; class = "nat-med-recent";   pc = "miss"; q = "anti-CD19 CAR T cell therapy refractory systemic lupus erythematosus" }
    @{ id = "P05-nat-med-recent";  pmid = "36216945"; class = "nat-med-recent";   pc = "hit-pmid"; q = "semaglutide STEP 5 two-year weight overweight obesity" }
    @{ id = "P06-nat-med-recent";  pmid = "36008722"; class = "nat-med-recent";   pc = "hit-pmid"; q = "cemiplimab plus chemotherapy non-small cell lung cancer phase 3" }
    @{ id = "P07-pre1980-nejm";    pmid = "226885";   class = "pre1980-nejm";     pc = "miss"; q = "hormone receptors breast cancer estrogen" }
    @{ id = "P08-pre1980-nejm";    pmid = "111125";   class = "pre1980-nejm";     pc = "miss"; q = "transplantation immunosuppression rejection" }
    @{ id = "P09-pre1980-nejm";    pmid = "460310";   class = "pre1980-nejm";     pc = "miss"; q = "hypouricemia uric acid renal" }
    @{ id = "P10-paywalled-non-pmc"; pmid = "30982686"; class = "paywalled-non-pmc"; pc = "miss"; q = "FLOT4 perioperative chemotherapy gastric adenocarcinoma fluorouracil docetaxel" }
    @{ id = "P11-paywalled-non-pmc"; pmid = "31590988"; class = "paywalled-non-pmc"; pc = "miss"; q = "CASPIAN durvalumab platinum-etoposide small-cell lung cancer" }
    @{ id = "P12-paywalled-non-pmc"; pmid = "31679945"; class = "paywalled-non-pmc"; pc = "miss"; q = "KEYNOTE-048 pembrolizumab head and neck squamous cell carcinoma" }
)

function Invoke-Asta {
    param([string]$Tool, [string]$ArgsJson)
    $out = & $invoker -Tool $Tool -Arguments $ArgsJson -ApiKey $ApiKey 2>&1
    Start-Sleep -Seconds $PaceSeconds
    return ($out | Out-String)
}
function Save-Packet {
    param([string]$Name, [string]$Tool, [string]$ArgsJson, [string]$Output)
    $path = Join-Path $probeDir "$Name.txt"
    $header = "# tool: $Tool`r`n# arguments: $ArgsJson`r`n# captured: $(Get-Date -Format o)`r`n`r`n"
    Set-Content -LiteralPath $path -Value ($header + $Output) -Encoding UTF8
}
function Q($v) { if ($v -match '[,"\r\n]') { '"' + ($v -replace '"', '""') + '"' } else { $v } }

foreach ($p in $probes) {
    $pid = "PMID:$($p.pmid)"
    Write-Host "`n=== $($p.id)  $pid ==="

    $gArgs = (@{ paper_id = $pid; fields = "title,venue,year,isOpenAccess" } | ConvertTo-Json -Compress)
    $gOut = Invoke-Asta -Tool "get_paper" -ArgsJson $gArgs
    Save-Packet -Name "$($p.id)__get_paper" -Tool "get_paper" -ArgsJson $gArgs -Output $gOut
    $resolved = if ($gOut -match '"paperId"\s*:\s*"([0-9a-f]{40})"') { "hit" } else { "miss" }
    $venue = if ($gOut -match '"venue"\s*:\s*"([^"]*)"') { $Matches[1] } else { "" }
    $isOA = if ($gOut -match '"isOpenAccess"\s*:\s*(true|false)') { $Matches[1] } else { "" }

    $sArgs = (@{ query = $p.q; paper_ids = $pid; limit = 2 } | ConvertTo-Json -Compress)
    $sOut = Invoke-Asta -Tool "snippet_search" -ArgsJson $sArgs
    Save-Packet -Name "$($p.id)__snippet" -Tool "snippet_search" -ArgsJson $sArgs -Output $sOut
    $snip = if ($sOut -match '"text"\s*:\s*"') { "hit" } elseif ($sOut -match 'FAILED|no data payload|ConnectionRefused|429') { "error" } else { "miss" }
    $kind = if ($sOut -match '"snippetKind"\s*:\s*"([^"]*)"') { $Matches[1] } else { "" }
    $section = if ($sOut -match '"section"\s*:\s*"([^"]*)"') { $Matches[1] } else { "" }

    $row = @($p.id, $p.class, $p.pmid, $p.pc, $resolved, $venue, $isOA, $snip, $kind, $section, "") |
        ForEach-Object { Q($_ -as [string]) }
    ($row -join ",") | Add-Content -LiteralPath $csv -Encoding UTF8
}

Write-Host "`nAsta index-scope probe complete -> $csv"
