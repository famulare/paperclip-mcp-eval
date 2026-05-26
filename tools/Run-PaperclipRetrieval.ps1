# Pass-3 Paperclip retrieval driver.
# Origin: Claude Opus 4.7 (1M context). 2026-05-22.
#
# For each case, runs a battery of Paperclip MCP commands and saves verbatim
# outputs to retrieval_packets/. Appends rows to retrieval_observations.csv.
# Records map -n honored / not honored bug observations.

param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path,
    [string[]]$Only = @()
)

$ErrorActionPreference = "Continue"
$packetsDir = Join-Path $RepoRoot "retrieval_packets"
$obsCsv = Join-Path $RepoRoot "retrieval_observations.csv"
$invoker = Join-Path $PSScriptRoot "Invoke-PaperclipMcp.ps1"

if (-not (Test-Path -LiteralPath $invoker)) {
    throw "Paperclip invoker not found at $invoker"
}

function Invoke-Paperclip {
    param([string]$Cmd)
    & $invoker -Command $Cmd 2>&1
}

function Save-Packet {
    param([string]$Name, [string]$Cmd, [string]$Output)
    $path = Join-Path $packetsDir "$Name.txt"
    $header = "# command: $Cmd`r`n# captured: $(Get-Date -Format o)`r`n`r`n"
    Set-Content -LiteralPath $path -Value ($header + $Output) -Encoding UTF8
    return $path
}

function Append-Obs {
    param(
        [string]$caseId, [string]$arm = "Paperclip MCP", [string]$attemptId,
        [string]$cmd, [string]$resolvedId, [string]$title, [string]$source, [string]$year,
        [string]$mainStatus, [string]$chars, [string]$lines, [string]$sections, [string]$figures, [string]$tables, [string]$supplements,
        [string]$elapsedSeconds, [string]$steps, [string]$falsePositives, [string]$mapNHonored, [string]$notes
    )
    # CSV-quote any field with commas or quotes.
    $fields = @($caseId, $arm, $attemptId, $cmd, $resolvedId, $title, $source, $year,
        $mainStatus, $chars, $lines, $sections, $figures, $tables, $supplements,
        $elapsedSeconds, $steps, $falsePositives, $mapNHonored, $notes)
    $quoted = $fields | ForEach-Object {
        $v = ($_ -as [string])
        if ($null -eq $v) { $v = "" }
        if ($v -match '[,"\r\n]') {
            $v = '"' + ($v -replace '"', '""') + '"'
        }
        $v
    }
    ($quoted -join ",") | Add-Content -LiteralPath $obsCsv -Encoding UTF8
}

# Pull observed line/char counts and content-organization signals out of
# `wc /papers/...` output.
function Parse-Wc {
    param([string]$wcOutput)
    $r = [pscustomobject]@{ lines = ""; words = ""; chars = "" }
    foreach ($line in $wcOutput -split "`r?`n") {
        if ($line -match "^\s*(\d+)\s+(\d+)\s+(\d+)\s+\S") {
            $r.lines = $Matches[1]; $r.words = $Matches[2]; $r.chars = $Matches[3]
            break
        }
    }
    return $r
}

# Case-specific retrieval plan. Each case has zero or more probes; each probe
# runs a Paperclip command and writes a packet.
$cases = [ordered]@{
    "famulare-2018-plosbio" = @{
        kind = "pubmed"
        doi = "10.1371/journal.pbio.2002468"
        pmid = "29702638"
        pmcid = "PMC5942853"
        title = "Assessing the stability of polio eradication after the withdrawal of oral polio vaccine"
        run_supplement_check = $true
    }
    "sfs-nejm-2020" = @{
        kind = "pubmed"
        doi = "10.1056/NEJMc2008646"
        pmid = "32356944"
        pmcid = "PMC7206929"
        title = "Early Detection of Covid-19 through a Citywide Pandemic Surveillance Platform"
        run_supplement_check = $true
    }
    "kew-2005-opv-review" = @{
        kind = "pubmed"
        doi = "10.1146/annurev.micro.58.030603.123625"
        pmid = "16153180"
        title = "Vaccine-derived polioviruses and the endgame strategy for global polio eradication"
        run_supplement_check = $false
    }
    "khoury-2021-natmed" = @{
        kind = "pubmed"
        doi = "10.1038/s41591-021-01377-8"
        pmid = "34002089"
        title = "Neutralizing antibody levels are highly predictive of immune protection from symptomatic SARS-CoV-2 infection"
        run_supplement_check = $false
    }
    "hornick-typhoid" = @{
        kind = "pubmed"
        pmid = "4916913"
        title = "Typhoid fever pathogenesis and immunologic control"
        run_supplement_check = $false
    }
    "thakkar-famulare-arxiv" = @{
        kind = "arxiv-multi"
        arxiv = @("2205.02150", "2311.16317")
        title = "transmission forest generating function"
        run_supplement_check = $false
    }
    "nigeria-2015-versioning" = @{
        kind = "arxiv"
        arxiv = "1504.02751"
        doi = "10.1371/journal.pone.0135765"
        pmid = "26317401"
        title = "Has wild poliovirus been eliminated from Nigeria?"
        run_supplement_check = $false
    }
    "cheslock-1960-ocr" = @{
        kind = "title-only"
        title = "Response of human beings to a low vitamin B6 diet"
        run_supplement_check = $false
    }
    "nct04232943-pmid36746739" = @{
        kind = "trial+pubmed"
        nct = "NCT04232943"
        pmid = "36746739"
        pmcid = "PMC9996288"
        title = "Safety tolerability immunogenicity inactivated poliovirus vaccine dmLT adjuvant"
        run_supplement_check = $true
        run_trial_map = $true
    }
    "heldout-tbe-vaccine" = @{
        kind = "pubmed"
        pmid = "23997980"
        title = "Tick-borne Encephalitis Vaccines"
    }
    "heldout-hepc-ns5a" = @{
        kind = "pubmed"
        pmid = "26904396"
        title = "Direct anti-HCV agents"
    }
    "heldout-tafamidis-attr" = @{
        kind = "pubmed"
        pmid = "30145929"
        title = "Tafamidis Treatment for Patients with Transthyretin Amyloid Cardiomyopathy"
    }
    "heldout-snakebite" = @{
        kind = "pubmed"
        pmid = "29363648"
        title = "Increased Efficacy of Antivenom Combined with Hyperbaric Oxygen on Deinagkistrodon acutus Envenomation"
    }
    "heldout-podoconiosis" = @{
        kind = "pubmed"
        pmid = "33558538"
        title = "Replication of HLA class II locus association with susceptibility to podoconiosis in three Ethiopian ethnic groups"
    }
}

if ($Only.Count -gt 0) {
    $filtered = [ordered]@{}
    foreach ($k in $Only) { if ($cases.Contains($k)) { $filtered[$k] = $cases[$k] } }
    $cases = $filtered
}

foreach ($caseId in $cases.Keys) {
    $c = $cases[$caseId]
    Write-Host ""
    Write-Host "=== $caseId ==="

    $resolvedFromLookup = ""
    $resolvedFromSearch = ""

    # 1. Exact ID lookups.
    if ($c.doi) {
        $cmd = "lookup doi $($c.doi)"
        $out = Invoke-Paperclip -Cmd $cmd
        $p = Save-Packet -Name "${caseId}__lookup_doi" -Cmd $cmd -Output $out
        $status = if ($out -match "PMC\d+|med_|arx_|tri_|s2_") { "resolved" } else { "not resolved" }
        if ($status -eq "resolved" -and $out -match "(PMC\d+|med_[a-z0-9]+|arx_\S+|tri_[a-z0-9]+|s2_[a-z0-9]+)") { $resolvedFromLookup = $Matches[1] }
        Append-Obs -caseId $caseId -attemptId "${caseId}-lookup-doi" -cmd $cmd -resolvedId $resolvedFromLookup -mainStatus $status -notes "DOI lookup; packet=$($p | Split-Path -Leaf)"
    }
    if ($c.pmid) {
        $cmd = "lookup pmid $($c.pmid)"
        $out = Invoke-Paperclip -Cmd $cmd
        $p = Save-Packet -Name "${caseId}__lookup_pmid" -Cmd $cmd -Output $out
        $status = if ($out -match "PMC\d+|med_|arx_|tri_|s2_") { "resolved" } else { "not resolved" }
        if (-not $resolvedFromLookup -and $out -match "(PMC\d+|med_[a-z0-9]+|arx_\S+|tri_[a-z0-9]+|s2_[a-z0-9]+)") { $resolvedFromLookup = $Matches[1] }
        Append-Obs -caseId $caseId -attemptId "${caseId}-lookup-pmid" -cmd $cmd -resolvedId $resolvedFromLookup -mainStatus $status -notes "PMID lookup; packet=$($p | Split-Path -Leaf)"
    }
    if ($c.arxiv) {
        $ids = if ($c.arxiv -is [array]) { $c.arxiv } else { @($c.arxiv) }
        foreach ($aid in $ids) {
            $cmd = "lookup arxiv $aid"
            $out = Invoke-Paperclip -Cmd $cmd
            $p = Save-Packet -Name "${caseId}__lookup_arxiv_$($aid -replace '\.','_')" -Cmd $cmd -Output $out
            $status = if ($out -match "arx_\S+|PMC\d+") { "resolved" } else { "not resolved" }
            if (-not $resolvedFromLookup -and $out -match "(arx_\S+)") { $resolvedFromLookup = $Matches[1] }
            Append-Obs -caseId $caseId -attemptId "${caseId}-lookup-arxiv-$aid" -cmd $cmd -resolvedId $resolvedFromLookup -mainStatus $status -notes "arXiv lookup; packet=$($p | Split-Path -Leaf)"
        }
    }
    if ($c.nct) {
        $cmd = "search -s trials/us `"$($c.nct)`" -n 5"
        $out = Invoke-Paperclip -Cmd $cmd
        $p = Save-Packet -Name "${caseId}__search_nct" -Cmd $cmd -Output $out
        $triCount = ([regex]::Matches($out, "tri_[a-z0-9]+")).Count
        Append-Obs -caseId $caseId -attemptId "${caseId}-search-nct" -cmd $cmd -mainStatus "search-returned-$triCount-trial-ids" -falsePositives "verify in notes" -notes "NCT search; packet=$($p | Split-Path -Leaf)"
    }

    # 2. Title search.
    if ($c.title) {
        $cmd = "search -t --all `"$($c.title)`" -n 5"
        $out = Invoke-Paperclip -Cmd $cmd
        $p = Save-Packet -Name "${caseId}__search_title" -Cmd $cmd -Output $out
        if ($out -match "(PMC\d+|med_[a-z0-9]+|arx_\S+|tri_[a-z0-9]+|s2_[a-z0-9]+)") { $resolvedFromSearch = $Matches[1] }
        $hits = ([regex]::Matches($out, "^\s*\d+\.\s", "Multiline")).Count
        Append-Obs -caseId $caseId -attemptId "${caseId}-search-title" -cmd $cmd -resolvedId $resolvedFromSearch -mainStatus "title-search-returned-${hits}-results" -notes "Title search; packet=$($p | Split-Path -Leaf)"
    }

    # 3. Inspect the resolved record (prefer lookup result; fall back to search).
    $resolved = if ($resolvedFromLookup) { $resolvedFromLookup } elseif ($resolvedFromSearch) { $resolvedFromSearch } else { "" }
    if ($resolved) {
        # Build the paper path. trials use /trials/, papers use /papers/.
        $pathRoot = if ($resolved -like "tri_*") { "/trials/$resolved" } else { "/papers/$resolved" }
        $cmd = "ls $pathRoot/"
        $out = Invoke-Paperclip -Cmd $cmd
        $p = Save-Packet -Name "${caseId}__ls" -Cmd $cmd -Output $out
        Append-Obs -caseId $caseId -attemptId "${caseId}-ls" -cmd $cmd -resolvedId $resolved -notes "ls; packet=$($p | Split-Path -Leaf)"

        $cmd = "wc $pathRoot/content.lines"
        $out = Invoke-Paperclip -Cmd $cmd
        $p = Save-Packet -Name "${caseId}__wc" -Cmd $cmd -Output $out
        $wc = Parse-Wc -wcOutput $out
        Append-Obs -caseId $caseId -attemptId "${caseId}-wc" -cmd $cmd -resolvedId $resolved -chars $wc.chars -lines $wc.lines -notes "wc; packet=$($p | Split-Path -Leaf)"

        if ($c.run_supplement_check) {
            $cmd = "ls $pathRoot/supplements/"
            $out = Invoke-Paperclip -Cmd $cmd
            $p = Save-Packet -Name "${caseId}__ls_supplements" -Cmd $cmd -Output $out
            Append-Obs -caseId $caseId -attemptId "${caseId}-ls-supplements" -cmd $cmd -resolvedId $resolved -notes "supplement ls; packet=$($p | Split-Path -Leaf)"

            $cmd = "grep -n -i -m 5 `"supplement|appendix`" $pathRoot/content.lines"
            $out = Invoke-Paperclip -Cmd $cmd
            $p = Save-Packet -Name "${caseId}__grep_supplement" -Cmd $cmd -Output $out
            $hasMerged = ($out -match "Supplement|Appendix")
            Append-Obs -caseId $caseId -attemptId "${caseId}-grep-supplement" -cmd $cmd -resolvedId $resolved -notes "supplement grep; merged-content-flag=$hasMerged; packet=$($p | Split-Path -Leaf)"
        }
    }

    # 4. Trial map (test the -n bug on trials).
    if ($c.run_trial_map) {
        # Re-run search to capture search ID.
        $searchCmd = "search -s trials/us `"$($c.nct)`" -n 3"
        $searchOut = Invoke-Paperclip -Cmd $searchCmd
        if ($searchOut -match "s_([a-z0-9]+)") {
            $sid = "s_" + $Matches[1]
            $mapCmd = "map --from $sid -n 1 `"Summarize the registered arms, enrollment, and primary endpoints.`""
            $mapOut = Invoke-Paperclip -Cmd $mapCmd
            $p = Save-Packet -Name "${caseId}__trial_map" -Cmd $mapCmd -Output $mapOut
            $mapStatus = if ($mapOut -match "invalid input syntax|error") { "failed" } else { "ran" }
            Append-Obs -caseId $caseId -attemptId "${caseId}-trial-map" -cmd $mapCmd -resolvedId $sid -mainStatus "trial-map-$mapStatus" -mapNHonored "test" -notes "trial map; packet=$($p | Split-Path -Leaf)"
        }
    }

    # 5. Map -n bug probe on paper search (if we have a search ID from title search).
    if ($c.title -and ($c.kind -ne "local-only") -and ($c.kind -ne "title-only")) {
        $searchCmd = "search -t --all `"$($c.title)`" -n 5"
        $searchOut = Invoke-Paperclip -Cmd $searchCmd
        if ($searchOut -match "s_([a-z0-9]+)") {
            $sid = "s_" + $Matches[1]
            $mapCmd = "map --from $sid -n 1 `"What is the central mechanistic or empirical claim of THIS paper only?`""
            $mapOut = Invoke-Paperclip -Cmd $mapCmd
            $p = Save-Packet -Name "${caseId}__map_n_probe" -Cmd $mapCmd -Output $mapOut
            $taskMatch = [regex]::Match($mapOut, "Map complete:\s+(\d+)/(\d+)\s+tasks")
            $tasksDone = if ($taskMatch.Success) { $taskMatch.Groups[1].Value } else { "?" }
            $tasksTotal = if ($taskMatch.Success) { $taskMatch.Groups[2].Value } else { "?" }
            $honored = if ($tasksDone -eq "1" -and $tasksTotal -eq "1") { "yes" } else { "no" }
            Append-Obs -caseId $caseId -attemptId "${caseId}-map-n-probe" -cmd $mapCmd -resolvedId $sid -mainStatus "tasks=$tasksDone/$tasksTotal" -mapNHonored $honored -notes "map -n 1 probe; honored=$honored; packet=$($p | Split-Path -Leaf)"
        }
    }
}

Write-Host ""
Write-Host "Paperclip retrieval pass complete."
