# Pass-3 Paperclip index-scope probe.
# Origin: Claude Opus 4.7 (1M context). 2026-05-22.
#
# For each Paperclip miss class observed in pass 2 and pass 3, probe 3 NEW
# papers from the same class and record whether Paperclip's exact-ID lookup
# succeeds. Saves probes to retrieval_packets/index_probes_*.txt and writes
# rows to index_scope_probes.csv.

param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$ErrorActionPreference = "Continue"
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
$ncbiDelayMs = 400
$invoker = Join-Path $PSScriptRoot "Invoke-PaperclipMcp.ps1"
$packetsDir = Join-Path $RepoRoot "retrieval_packets"
$probesCsv = Join-Path $RepoRoot "index_scope_probes.csv"

function Invoke-NcbiSummary {
    param([string]$pmid)
    Start-Sleep -Milliseconds $ncbiDelayMs
    $url = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=pubmed&id=$pmid&retmode=json"
    return (Invoke-RestMethod -Uri $url).result.$pmid
}

function Get-NcbiArticleId {
    param($entry, [string]$idtype)
    if (-not $entry.articleids) { return "" }
    $hit = $entry.articleids | Where-Object { $_.idtype -eq $idtype } | Select-Object -First 1
    if ($hit) { return $hit.value }
    return ""
}

function Search-PubMed {
    param([string]$query, [int]$retmax = 5)
    Start-Sleep -Milliseconds $ncbiDelayMs
    $q = [uri]::EscapeDataString($query)
    $url = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&term=$q&sort=relevance&retmax=$retmax&retmode=json"
    return (Invoke-RestMethod -Uri $url).esearchresult.idlist
}

function Invoke-Paperclip {
    param([string]$Cmd)
    & $invoker -Command $Cmd 2>&1
}

# Define the probe queries; PubMed esearch picks 3 papers per class.
$probeQueries = [ordered]@{
    "annual-reviews"   = "Annual Review of Microbiology[journal] OR Annual Review of Immunology[journal] OR Annual Review of Virology[journal]"
    "nat-med-recent"   = "Nat Med[journal] 2021:2022[dp]"
    "pre1980-nejm"     = "N Engl J Med[journal] 1970:1979[dp]"
    "paywalled-non-pmc" = "Lancet[ta] AND randomized AND 2019[dp]"
}

# Helper to flush a CSV row.
function Append-Probe {
    param(
        [string]$probeId, [string]$missClass, [string]$pmid, [string]$title, [string]$source, [string]$year,
        [string]$paperclipCmd, [string]$paperclipResult, [string]$resolvedId, [string]$hitOrMiss, [string]$notes
    )
    $fields = @($probeId, $missClass, $pmid, $title, $source, $year, $paperclipCmd, $paperclipResult, $resolvedId, $hitOrMiss, $notes)
    $quoted = $fields | ForEach-Object {
        $v = ($_ -as [string]); if ($null -eq $v) { $v = "" }
        if ($v -match '[,"\r\n]') { $v = '"' + ($v -replace '"', '""') + '"' }
        $v
    }
    ($quoted -join ",") | Add-Content -LiteralPath $probesCsv -Encoding UTF8
}

$probeCounter = 1
foreach ($missClass in $probeQueries.Keys) {
    $q = $probeQueries[$missClass]
    Write-Host ""
    Write-Host "=== Miss class: $missClass ==="
    Write-Host "Query: $q"
    $ids = Search-PubMed -query $q -retmax 6
    $picked = 0
    foreach ($pmid in $ids) {
        if ($picked -ge 3) { break }
        $sm = Invoke-NcbiSummary -pmid $pmid
        if (-not $sm.title) { continue }
        $doi = Get-NcbiArticleId -entry $sm -idtype "doi"
        if (-not $doi) { Write-Host "  PMID $pmid no DOI; skipping"; continue }
        $pmcid = Get-NcbiArticleId -entry $sm -idtype "pmc"

        $probeId = "P{0:D2}-$missClass" -f $probeCounter
        $probeCounter++
        $picked++

        Write-Host "  ${probeId}: PMID $pmid - $($sm.title)"

        # Probe by DOI first; if miss, also try PMID.
        $cmdDoi = "lookup doi $doi"
        $outDoi = Invoke-Paperclip -Cmd $cmdDoi
        $packet = Join-Path $packetsDir "${probeId}__lookup_doi.txt"
        Set-Content -LiteralPath $packet -Value ("# command: $cmdDoi`r`n# captured: $(Get-Date -Format o)`r`n`r`n" + $outDoi) -Encoding UTF8
        $hitDoi = if ($outDoi -match "(PMC\d+|med_[a-z0-9]+|arx_\S+|tri_[a-z0-9]+|s2_[a-z0-9]+)") { "hit"; $resolvedDoi = $Matches[1] } else { "miss"; $resolvedDoi = "" }

        $cmdPmid = "lookup pmid $pmid"
        $outPmid = Invoke-Paperclip -Cmd $cmdPmid
        $packetPmid = Join-Path $packetsDir "${probeId}__lookup_pmid.txt"
        Set-Content -LiteralPath $packetPmid -Value ("# command: $cmdPmid`r`n# captured: $(Get-Date -Format o)`r`n`r`n" + $outPmid) -Encoding UTF8
        $hitPmid = if ($outPmid -match "(PMC\d+|med_[a-z0-9]+|arx_\S+|tri_[a-z0-9]+|s2_[a-z0-9]+)") { "hit"; $resolvedPmid = $Matches[1] } else { "miss"; $resolvedPmid = "" }

        $combinedHit = if ($hitDoi -eq "hit" -or $hitPmid -eq "hit") { "hit" } else { "miss" }
        $resolved = if ($resolvedDoi) { $resolvedDoi } elseif ($resolvedPmid) { $resolvedPmid } else { "" }

        Append-Probe -probeId $probeId -missClass $missClass -pmid $pmid -title $sm.title -source $sm.fulljournalname -year $sm.pubdate `
            -paperclipCmd "lookup doi/pmid" -paperclipResult "doi=$hitDoi; pmid=$hitPmid" -resolvedId $resolved -hitOrMiss $combinedHit `
            -notes "DOI=$doi; PMCID=$pmcid; packets=${probeId}__lookup_doi.txt;${probeId}__lookup_pmid.txt"
    }
}

Write-Host ""
Write-Host "Index-scope probes complete."
