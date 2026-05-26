# Pass-3 ground-truth builder.
# Origin: Claude Opus 4.7 (1M context). 2026-05-21.
#
# Pulls authoritative metadata from PubMed esummary/efetch, arXiv API, and
# ClinicalTrials.gov v2 API. Writes one ground_truth/<case>.md per case.
#
# Anonymous NCBI calls; uses 400ms inter-call delay to stay under the 3 req/sec
# anonymous rate limit. arXiv and ClinicalTrials.gov are not rate-limited at
# this volume.
#
# Output snippets: abstracts only (fair use). No full-text dumps.

param(
    [string]$OutputRoot = (Join-Path $PSScriptRoot ".." "ground_truth"),
    [string[]]$Only = @()
)

$ErrorActionPreference = "Stop"
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

$ncbiDelayMs = 400
$fence = '```'

function Invoke-NcbiSummary {
    param([string]$pmid)
    Start-Sleep -Milliseconds $ncbiDelayMs
    $url = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=pubmed&id=$pmid&retmode=json"
    return (Invoke-RestMethod -Uri $url -Method Get).result.$pmid
}

function Invoke-NcbiAbstract {
    param([string]$pmid)
    Start-Sleep -Milliseconds $ncbiDelayMs
    $url = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=pubmed&id=$pmid&rettype=abstract&retmode=text"
    return Invoke-RestMethod -Uri $url -Method Get
}

function Invoke-ArxivMeta {
    param([string]$arxivId, [int]$retries = 3)
    $url = "https://export.arxiv.org/api/query?id_list=$arxivId"
    $delays = @(0, 4, 10)
    for ($i = 0; $i -lt $retries; $i++) {
        if ($delays[$i] -gt 0) { Start-Sleep -Seconds $delays[$i] }
        try {
            $raw = Invoke-WebRequest -Uri $url -UseBasicParsing -UserAgent "paperclip-mcp-eval/1.0 (+https://github.com/famulare/paperclip-mcp-eval)"
            return $raw.Content
        } catch {
            if ($i -eq ($retries - 1)) { throw }
            Write-Host "  arXiv 429/error on $arxivId; retrying in $($delays[$i+1])s..."
        }
    }
}

function Invoke-CTGovStudy {
    param([string]$nct)
    $url = "https://clinicaltrials.gov/api/v2/studies/$nct"
    return Invoke-RestMethod -Uri $url -Method Get
}

function Format-AuthorList {
    param($authors, [int]$max = 6)
    if (-not $authors) { return "" }
    $names = $authors | Select-Object -First $max | ForEach-Object { $_.name }
    $joined = ($names -join "; ")
    if ($authors.Count -gt $max) { $joined += "; et al." }
    return $joined
}

function Get-NcbiArticleId {
    param($entry, [string]$idtype)
    if (-not $entry.articleids) { return "" }
    $hit = $entry.articleids | Where-Object { $_.idtype -eq $idtype } | Select-Object -First 1
    if ($hit) { return $hit.value }
    return ""
}

function Truncate-Abstract {
    param([string]$text, [int]$max = 4000)
    if (-not $text) { return "" }
    $work = $text.Trim()
    # Strip from "\nDOI: " onward using plain string IndexOf (regex was unpredictable here).
    foreach ($marker in @("`nDOI: ", "`r`nDOI: ", "`nPMID: ", "`r`nPMID: ")) {
        $idx = $work.IndexOf($marker)
        if ($idx -gt 0) {
            $work = $work.Substring(0, $idx)
        }
    }
    $work = $work.Trim()
    if ($work.Length -gt $max) {
        $work = $work.Substring(0, $max) + "... [truncated for snippet policy]"
    }
    return $work
}

# Case configuration.
$cases = [ordered]@{
    "famulare-2018-plosbio" = @{
        kind = "pubmed"
        pmid = "29702638"
        also = @{ preprint = "bioRxiv 10.1101/084012 (2016)" }
        case_type = "supplement-heavy/versioned"
        case_family = "Famulare 2018 PLOS Biology plus bioRxiv lineage"
        diagnostic_anchors = @(
            "Mathematical model assessing risk of poliovirus reintroduction after OPV withdrawal.",
            "Setting-dependent stability of polio eradication: depends on immunity, transmission, and surveillance/response.",
            "Uses Sabin-strain reversion dynamics and transmission modeling."
        )
        wheelhouse = "yes"
    }
    "sfs-nejm-2020" = @{
        kind = "pubmed"
        pmid = "32356944"
        case_type = "consortium/supplement-heavy"
        case_family = "Seattle Flu Study NEJM/PMC consortium record"
        diagnostic_anchors = @(
            "Used a community-based surveillance platform (Seattle Flu Study) to detect early Covid-19 cases.",
            "Detected SARS-CoV-2 in residual specimens from late February/March 2020.",
            "Has a Supplementary Appendix with sampling/methods detail (NEJMc2008646)."
        )
        wheelhouse = "yes"
    }
    "kew-2005-opv-review" = @{
        kind = "pubmed"
        pmid = "16153180"
        case_type = "review"
        case_family = "Kew 2005 OPV review"
        diagnostic_anchors = @(
            "Reviews vaccine-derived poliovirus (VDPV) emergence and endgame strategy.",
            "Classifies VDPVs (cVDPV, iVDPV, aVDPV) by epidemiologic context.",
            "Published in Annual Review of Microbiology; review article, not primary data."
        )
        wheelhouse = "yes"
    }
    "khoury-2021-natmed" = @{
        kind = "pubmed"
        pmid = "34002089"
        also = @{ preprint = "medRxiv 10.1101/2021.03.09.21252641 (2021)" }
        case_type = "versioned correlate paper"
        case_family = "Khoury 2021 Nature Medicine + medRxiv preprint"
        diagnostic_anchors = @(
            "Models neutralizing antibody level as predictor of protection from symptomatic SARS-CoV-2.",
            "Fits a logistic/probit model relating neutralization titer to vaccine efficacy across trials.",
            "Final paper has different curves/parameters than the medRxiv preprint; version distinction matters."
        )
        wheelhouse = "yes"
    }
    "hornick-typhoid" = @{
        kind = "pubmed"
        pmid = "4916913"
        case_type = "old human challenge"
        case_family = "Hornick typhoid challenge"
        diagnostic_anchors = @(
            "Describes typhoid fever pathogenesis and immunologic control using human challenge experiments.",
            "Pre-1980; older typography; OCR-poor in many digital copies.",
            "Foundational reference for typhoid dose-response and challenge methodology."
        )
        wheelhouse = "yes"
    }
    "nct04232943-pmid36746739" = @{
        kind = "trial+pubmed"
        pmid = "36746739"
        nct = "NCT04232943"
        case_type = "trial/paper bridge"
        case_family = "IPV dmLT bOPV trial-paper pair"
        diagnostic_anchors = @(
            "Phase 1 randomized study of IPV with or without dmLT, with bOPV challenge in IPV-primed healthy adults.",
            "Actual enrollment 87; primary endpoints include safety/tolerability and post-challenge shedding.",
            "ClinicalTrials.gov has Study Protocol and Statistical Analysis Plan available."
        )
        wheelhouse = "yes"
    }
    "nigeria-2015-versioning" = @{
        kind = "arxiv+pubmed"
        arxiv = "1504.02751"
        pmid = "26317401"  # PLOS ONE publication PMID (confirmed via NCBI esearch by DOI)
        also = @{ doi = "10.1371/journal.pone.0135765" }
        case_type = "preprint/journal/postprint version lineage"
        case_family = "Nigeria 2015 arXiv -> PLOS ONE"
        diagnostic_anchors = @(
            "Models WPV elimination probability given surveillance sensitivity in Nigeria.",
            "arXiv v1 submitted 2015-04-10; v2 revised 2015-07-10 with updates including cVDPV2 forecast.",
            "Published in PLOS ONE 2015. Version label is the whole point of this case."
        )
        arxiv_meta = @{
            "1504.02751" = @{
                title = "Has wild poliovirus been eliminated from Nigeria?"
                authors = "Michael Famulare"
                versions = "v1 submitted 2015-04-10; v2 revised 2015-07-10"
                note = "v2 adds cVDPV2 forecast updates relative to v1; PLOS ONE final = 10.1371/journal.pone.0135765 (2015-08-28). Source: arXiv abs page, captured pass-2 validation_logs/source_metadata.md."
            }
        }
        wheelhouse = "yes"
    }
    "thakkar-famulare-arxiv" = @{
        kind = "arxiv-multi"
        arxiv = @("2205.02150", "2311.16317")
        case_type = "theory/math preprint"
        case_family = "Thakkar/Famulare arXiv papers"
        diagnostic_anchors = @(
            "Develops a transmission-forest formalism for epidemic dynamics.",
            "Uses generating functions to characterize forest-structured outbreaks.",
            "Mathematical; notation-aware reading required."
        )
        arxiv_meta = @{
            "2205.02150" = @{
                title = "COVID-19 epidemiology as emergent behavior on a dynamic transmission forest"
                authors = "Niket Thakkar; Mike Famulare"
                versions = "v1 submitted 2022-05-04"
                note = "Theory paper introducing transmission-forest formalism for epidemic dynamics."
            }
            "2311.16317" = @{
                title = "A generating function perspective on the transmission forest"
                authors = "Niket Thakkar; Mike Famulare"
                versions = "v1 submitted 2023-11-27"
                note = "Follow-up using generating functions to characterize forest-structured outbreaks."
            }
        }
        wheelhouse = "yes"
    }
    "cheslock-1960-ocr" = @{
        kind = "local-only"
        case_type = "OCR/scan stress"
        case_family = "Cheslock & McCully 1960 B6 diet"
        diagnostic_anchors = @(
            "Human metabolic ward study of low vitamin B6 diet.",
            "Reports xanthurenic acid excretion and tryptophan loading test results.",
            "1960 print; OCR layer quality is the benchmark issue."
        )
        wheelhouse = "yes"
    }
    "heldout-tbe-vaccine" = @{
        kind = "pubmed"
        pmid = "23997980"
        case_type = "concept-discovery outside wheelhouse"
        case_family = "Tick-borne encephalitis vaccine (Europe schedule)"
        diagnostic_anchors = @(
            "Reviews/synthesizes tick-borne encephalitis (TBE) vaccines and vaccination schedules.",
            "Covers European epidemiology, immunogenicity, and recommended schedules.",
            "Should not be confused with polio vaccine literature."
        )
        wheelhouse = "no"
        selection_rule = "first eligible PubMed result by relevance to query 'tick-borne encephalitis vaccine schedule Europe'"
    }
    "heldout-hepc-ns5a" = @{
        kind = "pubmed"
        pmid = "26904396"
        case_type = "concept-discovery outside wheelhouse"
        case_family = "Hepatitis C direct-acting antivirals / NS5A"
        diagnostic_anchors = @(
            "Reviews direct-acting antiviral (DAA) agents against hepatitis C virus.",
            "Covers NS5A, NS3/4A, NS5B inhibitor classes and resistance-associated substitutions.",
            "Hepatology / virology / pharmacology subject area."
        )
        wheelhouse = "no"
        selection_rule = "first eligible PubMed result by relevance to query 'hepatitis C NS5A resistance mutations DAA'"
    }
    "heldout-tafamidis-attr" = @{
        kind = "pubmed"
        pmid = "30145929"
        case_type = "concept-discovery outside wheelhouse"
        case_family = "Tafamidis ATTR-ACT pivotal NEJM trial"
        diagnostic_anchors = @(
            "Phase 3 randomized trial of tafamidis vs placebo for transthyretin amyloid cardiomyopathy (ATTR-CM).",
            "Multicenter, double-blind; reports all-cause mortality and cardiovascular hospitalization endpoints.",
            "Published in NEJM 2018."
        )
        wheelhouse = "no"
        selection_rule = "first eligible PubMed result by relevance to query 'tafamidis ATTR cardiac amyloidosis randomized trial'"
    }
    "heldout-snakebite" = @{
        kind = "pubmed"
        pmid = "29363648"
        case_type = "concept-discovery outside wheelhouse"
        case_family = "Snakebite antivenom efficacy (rat study)"
        diagnostic_anchors = @(
            "Animal (rat) study of antivenom efficacy combined with hyperbaric oxygen for Deinagkistrodon acutus envenomation.",
            "Preclinical/translational rather than human trial.",
            "Toxinology / envenomation subject area."
        )
        wheelhouse = "no"
        selection_rule = "first eligible PubMed result by relevance to query 'snakebite envenomation antivenom efficacy randomized'; note: chosen result is rat model"
    }
    "heldout-podoconiosis" = @{
        kind = "pubmed"
        pmid = "33558538"
        case_type = "concept-discovery outside wheelhouse"
        case_family = "Podoconiosis HLA genetic association"
        diagnostic_anchors = @(
            "Replicates HLA class II locus association with podoconiosis susceptibility across three Ethiopian ethnic groups.",
            "Genetic / NTD (neglected tropical disease) subject area.",
            "Tests Paperclip's coverage of African genetic epidemiology and NTD literature."
        )
        wheelhouse = "no"
        selection_rule = "first eligible PubMed result by relevance to query 'podoconiosis genetic susceptibility HLA'"
    }
}

if ($Only.Count -gt 0) {
    $filtered = [ordered]@{}
    foreach ($k in $Only) {
        if ($cases.Contains($k)) { $filtered[$k] = $cases[$k] }
    }
    $cases = $filtered
}

if (-not (Test-Path -LiteralPath $OutputRoot)) {
    throw "Output directory not found: $OutputRoot"
}

foreach ($caseId in $cases.Keys) {
    $c = $cases[$caseId]
    Write-Host "Processing $caseId ($($c.kind))..."

    $outFile = Join-Path $OutputRoot "$caseId.md"

    $sections = New-Object System.Collections.Generic.List[string]
    $sections.Add("# Ground Truth: $caseId")
    $sections.Add("")
    $sections.Add("**Origin:** Claude Opus 4.7 (1M context). Authoritative metadata from PubMed/PMC/arXiv/ClinicalTrials.gov.")
    $sections.Add("**Date built:** $(Get-Date -Format yyyy-MM-dd)")
    $sections.Add("**Case family:** $($c.case_family)")
    $sections.Add("**Case type:** $($c.case_type)")
    $sections.Add("**Wheelhouse:** $($c.wheelhouse)")
    $sections.Add("")

    if ($c.kind -eq "pubmed" -or $c.kind -eq "trial+pubmed" -or $c.kind -eq "arxiv+pubmed") {
        $meta = Invoke-NcbiSummary -pmid $c.pmid
        $abs = Invoke-NcbiAbstract -pmid $c.pmid
        $title = $meta.title
        $journal = $meta.fulljournalname
        $pubdate = $meta.pubdate
        $authors = Format-AuthorList -authors $meta.authors
        $pmcid = Get-NcbiArticleId -entry $meta -idtype "pmc"
        $doi = Get-NcbiArticleId -entry $meta -idtype "doi"

        $sections.Add("## PubMed source-of-record")
        $sections.Add("")
        $sections.Add("- **PMID:** $($c.pmid)")
        if ($pmcid) { $sections.Add("- **PMCID:** $pmcid") }
        if ($doi)   { $sections.Add("- **DOI:** $doi") }
        $sections.Add("- **Title:** $title")
        $sections.Add("- **Authors (top 6):** $authors")
        $sections.Add("- **Journal:** $journal")
        $sections.Add("- **Pub date:** $pubdate")
        if ($c.also) {
            foreach ($k in $c.also.Keys) {
                $sections.Add("- **Also:** $k = $($c.also.$k)")
            }
        }
        $sections.Add("")
        $sections.Add("## Abstract (fair-use snippet)")
        $sections.Add("")
        $sections.Add($fence)
        $sections.Add((Truncate-Abstract -text $abs))
        $sections.Add($fence)
        $sections.Add("")
    }

    if ($c.kind -eq "arxiv+pubmed" -or $c.kind -eq "arxiv-multi") {
        $sections.Add("## arXiv source-of-record")
        $sections.Add("")
        $arxivIds = if ($c.arxiv -is [array]) { $c.arxiv } else { @($c.arxiv) }
        foreach ($aid in $arxivIds) {
            $sections.Add("### arXiv:$aid")
            $sections.Add("")
            # Use inline documented metadata. arXiv API rate-limits aggressively; for
            # the pass-3 corpus the version evidence is already captured in pass-2
            # validation_logs/source_metadata.md. Scorers use the diagnostic anchors
            # plus the arXiv abs URL to validate.
            if ($c.arxiv_meta -and $c.arxiv_meta.ContainsKey($aid)) {
                $m = $c.arxiv_meta[$aid]
                $sections.Add("- **Title:** $($m.title)")
                $sections.Add("- **Authors:** $($m.authors)")
                $sections.Add("- **Versions:** $($m.versions)")
                $sections.Add("- **arXiv URL:** https://arxiv.org/abs/$aid")
                if ($m.note) { $sections.Add("- **Note:** $($m.note)") }
            } else {
                $sections.Add("- **arXiv URL:** https://arxiv.org/abs/$aid")
                $sections.Add("- **Note:** Metadata not inlined; verify version lineage via arXiv abs page.")
            }
            $sections.Add("")
        }
    }

    if ($c.kind -eq "trial+pubmed") {
        $sections.Add("## ClinicalTrials.gov source-of-record")
        $sections.Add("")
        try {
            $study = Invoke-CTGovStudy -nct $c.nct
            $proto = $study.protocolSection
            $sections.Add("- **NCT:** $($c.nct)")
            $sections.Add("- **Brief title:** $($proto.identificationModule.briefTitle)")
            $sections.Add("- **Official title:** $($proto.identificationModule.officialTitle)")
            $sections.Add("- **Status:** $($proto.statusModule.overallStatus)")
            $sections.Add("- **Phase:** $(($proto.designModule.phases) -join ', ')")
            $sections.Add("- **Enrollment:** $($proto.designModule.enrollmentInfo.count) ($($proto.designModule.enrollmentInfo.type))")
            $sections.Add("- **Condition(s):** $(($proto.conditionsModule.conditions) -join '; ')")
            $sections.Add("- **Interventions:**")
            foreach ($iv in $proto.armsInterventionsModule.interventions) {
                $sections.Add("  - $($iv.type): $($iv.name)")
            }
            $sections.Add("- **Has results:** $($study.hasResults)")
            if ($study.documentSection.largeDocumentModule.largeDocs) {
                $sections.Add("- **Large documents:**")
                foreach ($doc in $study.documentSection.largeDocumentModule.largeDocs) {
                    $sections.Add("  - $($doc.label) ($($doc.typeAbbrev))")
                }
            }
        } catch {
            $sections.Add("ERROR fetching ClinicalTrials.gov: $($_.Exception.Message)")
        }
        $sections.Add("")
    }

    if ($c.kind -eq "local-only") {
        $sections.Add("## Local-only case")
        $sections.Add("")
        $sections.Add("No web/API metadata applicable. Identity validated by local archive filename and pdftotext snippet (see local PDF extraction in Phase 5).")
        $sections.Add("")
    }

    $sections.Add("## Diagnostic claim anchors (scorer reference)")
    $sections.Add("")
    foreach ($anchor in $c.diagnostic_anchors) {
        $sections.Add("- $anchor")
    }
    $sections.Add("")
    $sections.Add("## Notes for scorers")
    $sections.Add("")
    $sections.Add("- This file is the answer key for scoring. Compare arm-isolated synthesis answers against the identity fields, abstract, and diagnostic claim anchors.")
    $sections.Add("- Do not infer beyond what is on this page.")
    $sections.Add("- If an arm output makes claims that go beyond this ground truth without arm-bundle evidence, that is unsupported-claim territory.")

    $sections -join "`n" | Set-Content -LiteralPath $outFile -Encoding UTF8
    Write-Host "  wrote $outFile"
}

Write-Host ""
Write-Host "Done."
