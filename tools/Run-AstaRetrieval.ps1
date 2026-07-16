# Asta (Ai2) retrieval driver — mirrors Run-PaperclipRetrieval.ps1 for the Asta arm.
# Origin: Claude Opus 4.8. 2026-07-15.
#
# For each case, runs a battery of Asta MCP calls (via Invoke-AstaMcp.ps1) and saves
# verbatim outputs to retrieval_packets/<case>__asta_<probe>.txt. Appends rows to
# asta_retrieval_observations.csv (a SEPARATE file — the frozen Paperclip
# retrieval_observations.csv is never mutated).
#
# Probes map to the 6 evaluation roles (methodology.md):
#   source resolver     -> get_paper by best identifier
#   document reader      -> snippet_search scoped to the paper (the paywalled-body-text crux)
#   version resolver     -> get_paper on preprint vs final ids (versioned cases)
#   supplement resolver  -> N/A (Asta has no supplement surface; snippets exclude captions/bib) — recorded as a structural gap
#   trial/paper bridge   -> get_paper on the trial's paper; Asta has no trial-registry surface (gap)
#   cross-source engine  -> snippet_search + search_papers_by_relevance on the 5 negative-control queries
#
# Pacing: the anonymous tier is rate-limited (S2 HTTP 429; Asta surfaces refused upstream /
# SSE-pings-only). Invoke-AstaMcp.ps1 does exponential backoff; this driver also sleeps
# -PaceSeconds between calls. Increase -PaceSeconds (or supply -ApiKey) if you see failures.

param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path,
    [string[]]$Only = @(),
    [switch]$NegativeControls,
    [string]$ApiKey = "",
    [int]$PaceSeconds = 5
)

$ErrorActionPreference = "Continue"
$packetsDir = Join-Path $RepoRoot "retrieval_packets"
$obsCsv = Join-Path $RepoRoot "asta_retrieval_observations.csv"
$invoker = Join-Path $PSScriptRoot "Invoke-AstaMcp.ps1"

if (-not (Test-Path -LiteralPath $invoker)) { throw "Asta invoker not found at $invoker" }

# Observation CSV header (parallels retrieval_observations.csv where sensible).
if (-not (Test-Path -LiteralPath $obsCsv)) {
    "case_id,source_arm,attempt_id,tool,arguments,resolved_id,title,venue,year,is_open_access,snippet_kind,snippet_section,result_status,notes" |
        Set-Content -LiteralPath $obsCsv -Encoding UTF8
}

$paperFields = "title,abstract,authors,year,venue,journal,publicationDate,isOpenAccess,externalIds,url,tldr"

function Invoke-Asta {
    param([string]$Tool, [string]$ArgsJson)
    $out = & $invoker -Tool $Tool -Arguments $ArgsJson -ApiKey $ApiKey 2>&1
    Start-Sleep -Seconds $PaceSeconds
    return ($out | Out-String)
}

function Save-Packet {
    param([string]$Name, [string]$Tool, [string]$ArgsJson, [string]$Output)
    $path = Join-Path $packetsDir "$Name.txt"
    $header = "# tool: $Tool`r`n# arguments: $ArgsJson`r`n# captured: $(Get-Date -Format o)`r`n`r`n"
    Set-Content -LiteralPath $path -Value ($header + $Output) -Encoding UTF8
    return $path
}

function Append-Obs {
    param(
        [string]$caseId, [string]$attemptId, [string]$tool, [string]$arguments,
        [string]$resolvedId, [string]$title, [string]$venue, [string]$year,
        [string]$isOA, [string]$snippetKind, [string]$snippetSection, [string]$status, [string]$notes
    )
    $fields = @($caseId, "Asta MCP", $attemptId, $tool, $arguments, $resolvedId, $title, $venue, $year,
        $isOA, $snippetKind, $snippetSection, $status, $notes)
    $quoted = $fields | ForEach-Object {
        $v = ($_ -as [string]); if ($null -eq $v) { $v = "" }
        if ($v -match '[,"\r\n]') { $v = '"' + ($v -replace '"', '""') + '"' }
        $v
    }
    ($quoted -join ",") | Add-Content -LiteralPath $obsCsv -Encoding UTF8
}

# Per-case plan: best resolver id, a topical snippet query (retrieval query, not
# ground-truth content), version-alt ids, and flags.
$cases = [ordered]@{
    "famulare-2018-plosbio" = @{ id = "PMID:29702638"; q = "stability of polio eradication after withdrawal of oral polio vaccine local transmission rate"; alt = @("DOI:10.1101/084012") }
    "sfs-nejm-2020"          = @{ id = "PMID:32356944"; q = "citywide pandemic surveillance platform early detection of Covid-19 Seattle" }
    "kew-2005-opv-review"    = @{ id = "PMID:16153180"; q = "vaccine-derived polioviruses circulating VDPV endgame strategy eradication" }
    "khoury-2021-natmed"     = @{ id = "PMID:34002089"; q = "neutralizing antibody levels predictive of immune protection SARS-CoV-2"; alt = @("DOI:10.1101/2021.03.09.21252641") }
    "hornick-typhoid"        = @{ id = "PMID:4916913";  q = "typhoid fever pathogenesis immunologic control challenge dose" }
    "thakkar-famulare-arxiv" = @{ id = "ARXIV:2205.02150"; q = "transmission forest generating function branching process epidemic"; alt = @("ARXIV:2311.16317") }
    "nigeria-2015-versioning" = @{ id = "PMID:26317401"; q = "wild poliovirus elimination Nigeria surveillance sensitivity"; alt = @("ARXIV:1504.02751") }
    "cheslock-1960-ocr"      = @{ id = ""; title = "Response of human beings to a low vitamin B6 diet"; q = "human vitamin B6 deficiency diet xanthurenic acid tryptophan" }
    "nct04232943-pmid36746739" = @{ id = "PMID:36746739"; q = "inactivated poliovirus vaccine dmLT adjuvant phase 1 safety immunogenicity"; trial = $true }
    "heldout-tbe-vaccine"    = @{ id = "PMID:23997980"; q = "tick-borne encephalitis vaccine schedule immunogenicity" }
    "heldout-hepc-ns5a"      = @{ id = "PMID:26904396"; q = "direct-acting antiviral HCV NS5A inhibitor resistance" }
    "heldout-tafamidis-attr" = @{ id = "PMID:30145929"; q = "tafamidis transthyretin amyloid cardiomyopathy all-cause mortality hospitalization" }
    "heldout-snakebite"      = @{ id = "PMID:29363648"; q = "antivenom hyperbaric oxygen Deinagkistrodon acutus envenomation rats" }
    "heldout-podoconiosis"   = @{ id = "PMID:33558538"; q = "HLA class II locus podoconiosis susceptibility Ethiopian ethnic groups" }
}

if ($Only.Count -gt 0) {
    $filtered = [ordered]@{}
    foreach ($k in $Only) { if ($cases.Contains($k)) { $filtered[$k] = $cases[$k] } }
    $cases = $filtered
}

if (-not $NegativeControls) {
    foreach ($caseId in $cases.Keys) {
        $c = $cases[$caseId]
        Write-Host "`n=== $caseId ==="

        # source resolver: get_paper (or title search for id-less cases like Cheslock 1960)
        if ($c.id) {
            $argsJson = (@{ paper_id = $c.id; fields = $paperFields } | ConvertTo-Json -Compress)
            $out = Invoke-Asta -Tool "get_paper" -ArgsJson $argsJson
            $p = Save-Packet -Name "${caseId}__asta_get_paper" -Tool "get_paper" -ArgsJson $argsJson -Output $out
            Append-Obs -caseId $caseId -attemptId "${caseId}-get_paper" -tool "get_paper" -arguments $c.id -status "see packet" -notes "packet=$($p | Split-Path -Leaf)"
        }
        elseif ($c.title) {
            $argsJson = (@{ title = $c.title; fields = $paperFields } | ConvertTo-Json -Compress)
            $out = Invoke-Asta -Tool "search_paper_by_title" -ArgsJson $argsJson
            $p = Save-Packet -Name "${caseId}__asta_title" -Tool "search_paper_by_title" -ArgsJson $argsJson -Output $out
            Append-Obs -caseId $caseId -attemptId "${caseId}-title" -tool "search_paper_by_title" -arguments $c.title -status "see packet" -notes "id-less case; packet=$($p | Split-Path -Leaf)"
        }

        # document reader: snippet_search scoped to the paper (the crux)
        if ($c.q) {
            $sid = if ($c.id) { $c.id } else { "" }
            $sArgs = @{ query = $c.q; limit = 3 }
            if ($sid) { $sArgs["paper_ids"] = $sid }
            $argsJson = ($sArgs | ConvertTo-Json -Compress)
            $out = Invoke-Asta -Tool "snippet_search" -ArgsJson $argsJson
            $p = Save-Packet -Name "${caseId}__asta_snippet" -Tool "snippet_search" -ArgsJson $argsJson -Output $out
            Append-Obs -caseId $caseId -attemptId "${caseId}-snippet" -tool "snippet_search" -arguments $c.q -status "see packet" -notes "scoped=$sid; packet=$($p | Split-Path -Leaf)"
        }

        # version resolver: get_paper on preprint/alt ids
        if ($c.alt) {
            foreach ($aid in $c.alt) {
                $argsJson = (@{ paper_id = $aid; fields = $paperFields } | ConvertTo-Json -Compress)
                $out = Invoke-Asta -Tool "get_paper" -ArgsJson $argsJson
                $safe = ($aid -replace '[^A-Za-z0-9]', '_')
                $p = Save-Packet -Name "${caseId}__asta_get_paper_alt_${safe}" -Tool "get_paper" -ArgsJson $argsJson -Output $out
                Append-Obs -caseId $caseId -attemptId "${caseId}-alt-${safe}" -tool "get_paper" -arguments $aid -status "see packet" -notes "version-alt probe; packet=$($p | Split-Path -Leaf)"
            }
        }
    }
}

# cross-source query engine: negative controls (strict refusal grading downstream)
if ($NegativeControls) {
    $controls = [ordered]@{
        "neg-kew-nearmiss"             = "Vaccine-derived polioviruses and the endgame strategy for global polio eradication"
        "neg-nct-nearmiss"             = "NCT04232943"
        "neg-sfs-dmlt"                 = "Seattle Flu Study randomized dmLT poliovirus vaccine trial"
        "neg-khoury-polio"             = "Khoury neutralizing antibody OPV challenge polio"
        "neg-famulare-covasim-hornick" = "Famulare Covasim typhoid challenge Hornick"
    }
    foreach ($ncId in $controls.Keys) {
        $q = $controls[$ncId]
        Write-Host "`n=== $ncId ==="
        $argsJson = (@{ query = $q; limit = 5 } | ConvertTo-Json -Compress)
        $out = Invoke-Asta -Tool "snippet_search" -ArgsJson $argsJson
        $p = Save-Packet -Name "${ncId}__asta_snippet" -Tool "snippet_search" -ArgsJson $argsJson -Output $out
        Append-Obs -caseId $ncId -attemptId "${ncId}-snippet" -tool "snippet_search" -arguments $q -status "see packet" -notes "negative control; packet=$($p | Split-Path -Leaf)"

        $argsJson = (@{ keyword = $q; limit = 5; fields = "title,year,venue" } | ConvertTo-Json -Compress)
        $out = Invoke-Asta -Tool "search_papers_by_relevance" -ArgsJson $argsJson
        $p = Save-Packet -Name "${ncId}__asta_relevance" -Tool "search_papers_by_relevance" -ArgsJson $argsJson -Output $out
        Append-Obs -caseId $ncId -attemptId "${ncId}-relevance" -tool "search_papers_by_relevance" -arguments $q -status "see packet" -notes "negative control; packet=$($p | Split-Path -Leaf)"
    }
}

Write-Host "`nAsta retrieval pass complete."
