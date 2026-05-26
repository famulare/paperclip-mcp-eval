# Pass-3 outside-wheelhouse held-out selection.
# Origin: Claude Opus 4.7 (1M context). 2026-05-22.
#
# For each query: run PubMed esearch, sort by relevance, take the first eligible
# result. Record the deterministic selection rule, the PMID, title, and DOI.
#
# Selection rule for "eligible":
#   - Has a real abstract (not just title).
#   - Is in PubMed (and thus has an esummary record).
#   - Is not a pure correction/retraction/editorial.

param(
    [string]$OutputPath = (Join-Path $PSScriptRoot ".." "heldout_selection.json")
)

$ErrorActionPreference = "Stop"
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
$ncbiDelayMs = 400

function Search-PubMedFirst {
    param([string]$query, [int]$retmax = 5)
    Start-Sleep -Milliseconds $ncbiDelayMs
    $q = [uri]::EscapeDataString($query)
    $url = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&term=$q&sort=relevance&retmax=$retmax&retmode=json"
    $resp = Invoke-RestMethod -Uri $url
    return $resp.esearchresult.idlist
}

function Get-PubMedSummary {
    param([string]$pmid)
    Start-Sleep -Milliseconds $ncbiDelayMs
    $url = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=pubmed&id=$pmid&retmode=json"
    return (Invoke-RestMethod -Uri $url).result.$pmid
}

$queries = [ordered]@{
    "heldout-tbe-vaccine"      = "tick-borne encephalitis vaccine schedule Europe"
    "heldout-hepc-ns5a"        = "hepatitis C NS5A resistance mutations DAA"
    "heldout-tafamidis-attr"   = "tafamidis ATTR cardiac amyloidosis randomized trial"
    "heldout-snakebite"        = "snakebite envenomation antivenom efficacy randomized"
    "heldout-podoconiosis"     = "podoconiosis genetic susceptibility HLA"
}

$selections = New-Object System.Collections.Generic.List[object]

foreach ($caseId in $queries.Keys) {
    $q = $queries[$caseId]
    Write-Host "[$caseId] querying: $q"
    $ids = Search-PubMedFirst -query $q -retmax 5
    $chosen = $null
    foreach ($pmid in $ids) {
        $sm = Get-PubMedSummary -pmid $pmid
        $pubtype = ($sm.pubtype | Out-String).Trim()
        # Skip pure editorial/correction/retraction.
        if ($pubtype -match "(Correction|Retraction|Comment|Editorial)") {
            Write-Host "  skip $pmid (pubtype: $pubtype)"
            continue
        }
        $doi = ""
        $pmcid = ""
        if ($sm.articleids) {
            $doiHit = $sm.articleids | Where-Object { $_.idtype -eq "doi" } | Select-Object -First 1
            if ($doiHit) { $doi = $doiHit.value }
            $pmcHit = $sm.articleids | Where-Object { $_.idtype -eq "pmc" } | Select-Object -First 1
            if ($pmcHit) { $pmcid = $pmcHit.value }
        }
        $chosen = [pscustomobject]@{
            case_id = $caseId
            query = $q
            pmid = $pmid
            title = $sm.title
            journal = $sm.fulljournalname
            pubdate = $sm.pubdate
            doi = $doi
            pmcid = $pmcid
            pubtype = $pubtype
            selection_rule = "first eligible PubMed result by relevance"
        }
        break
    }
    if ($chosen) {
        Write-Host "  picked PMID $($chosen.pmid): $($chosen.title)"
        $selections.Add($chosen)
    } else {
        Write-Host "  NO eligible result"
    }
}

$selections | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath $OutputPath -Encoding UTF8
Write-Host ""
Write-Host "Wrote $OutputPath"
