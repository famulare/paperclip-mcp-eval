# Pass-3 score compiler + adjudicator.
# Origin: Claude Opus 4.7 (1M context). 2026-05-22.
#
# Parses scorerA_all.md and scorerB_all.md summary tables, computes
# disagreements >=2 on any dimension, and writes synthesis_scores.csv.
# Main-agent adjudication policy: for disagreements >=2 on a single dimension,
# take the more conservative (lower) score and log the divergence in notes.
# For disagreements <2, take the rounded mean.

param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$ErrorActionPreference = "Stop"
$scoresCsv = Join-Path $RepoRoot "synthesis_scores.csv"

function Parse-Table {
    param([string]$path, [string]$scorerId)
    $rows = New-Object System.Collections.Generic.List[object]
    $content = Get-Content -LiteralPath $path -Raw
    $lines = $content -split "`r?`n"
    $inTable = $false
    foreach ($line in $lines) {
        if ($line -match "^\|\s*case_id\s*\|") { $inTable = $true; continue }
        if ($inTable -and $line -match "^\|\s*---") { continue }
        if ($inTable -and $line -match "^\|") {
            # Split on |, drop first/last empties.
            $parts = $line.Split("|")
            $cells = $parts[1..($parts.Length - 2)] | ForEach-Object { $_.Trim() }
            if ($cells.Length -lt 13) { continue }
            $rows.Add([pscustomobject]@{
                case_id  = $cells[0]
                arm      = $cells[1]
                EF       = $cells[2]
                MD       = $cells[3]
                UC       = $cells[4]
                VP       = $cells[5]
                SP       = $cells[6]
                TR       = $cells[7]
                DU       = $cells[8]
                TF       = $cells[9]
                overall  = $cells[10]
                caps     = $cells[11]
                rationale= $cells[12]
                scorer   = $scorerId
            })
        }
        if ($inTable -and -not $line.StartsWith("|")) { $inTable = $false }
    }
    return $rows
}

$a = Parse-Table -path (Join-Path $RepoRoot "scorer_packets" "output" "scorerA_all.md") -scorerId "A"
$b = Parse-Table -path (Join-Path $RepoRoot "scorer_packets" "output" "scorerB_all.md") -scorerId "B"

Write-Host "Scorer A rows: $($a.Count)"
Write-Host "Scorer B rows: $($b.Count)"

function Numerize {
    param($v)
    if ($v -eq "NA" -or $v -eq "" -or $null -eq $v) { return $null }
    return [int]$v
}

function Adjudicate {
    param($va, $vb)
    $na = Numerize $va; $nb = Numerize $vb
    if ($null -eq $na -and $null -eq $nb) { return @{ value = "NA"; flag = "none" } }
    if ($null -eq $na) { return @{ value = $nb.ToString(); flag = "A=NA;B=$nb" } }
    if ($null -eq $nb) { return @{ value = $na.ToString(); flag = "A=$na;B=NA" } }
    $diff = [Math]::Abs($na - $nb)
    if ($diff -ge 2) {
        # Conservative: take the lower score.
        $low = [Math]::Min($na, $nb)
        return @{ value = $low.ToString(); flag = "DISAGREE>=2(A=$na;B=$nb)->conservative=$low" }
    }
    $mean = [Math]::Round(($na + $nb) / 2.0)
    return @{ value = $mean.ToString(); flag = "none" }
}

# Write CSV header.
$header = "case_id,source_arm,synthesis_file,scorer1_id,scorer2_id,evidence_fidelity,missing_detail_control,unsupported_claim_detection,version_provenance_fidelity,supplement_protocol_table_figure_use,traceability,domain_usefulness,time_friction,overall_score,caps_applied,adjudication_status,scorer1_output,scorer2_output,notes"
Set-Content -LiteralPath $scoresCsv -Value $header -Encoding UTF8

# Index B by (case, arm).
$bIdx = @{}
foreach ($r in $b) { $bIdx["$($r.case_id)__$($r.arm)"] = $r }

$adjudicationNeeded = 0
foreach ($ra in $a) {
    $key = "$($ra.case_id)__$($ra.arm)"
    if (-not $bIdx.ContainsKey($key)) {
        Write-Host "WARN: no B entry for $key"
        continue
    }
    $rb = $bIdx[$key]

    $adj_EF = Adjudicate $ra.EF $rb.EF
    $adj_MD = Adjudicate $ra.MD $rb.MD
    $adj_UC = Adjudicate $ra.UC $rb.UC
    $adj_VP = Adjudicate $ra.VP $rb.VP
    $adj_SP = Adjudicate $ra.SP $rb.SP
    $adj_TR = Adjudicate $ra.TR $rb.TR
    $adj_DU = Adjudicate $ra.DU $rb.DU
    $adj_TF = Adjudicate $ra.TF $rb.TF
    $adj_overall = Adjudicate $ra.overall $rb.overall

    $flags = @($adj_EF.flag, $adj_MD.flag, $adj_UC.flag, $adj_VP.flag, $adj_SP.flag, $adj_TR.flag, $adj_DU.flag, $adj_TF.flag, $adj_overall.flag) | Where-Object { $_ -ne "none" }
    $adjStatus = if ($flags.Count -gt 0) { "needs-review" } else { "auto-merged" }
    if ($adjStatus -eq "needs-review") { $adjudicationNeeded++ }

    $synthFile = "synthesis_outputs/$($ra.case_id)__$($ra.arm).md"
    $capsCombined = @($ra.caps, $rb.caps) | Where-Object { $_ -and $_ -ne "none" } | Select-Object -Unique
    $capsStr = ($capsCombined -join " || ")

    $notes = "A_rationale: $($ra.rationale) | B_rationale: $($rb.rationale)"
    if ($flags.Count -gt 0) { $notes += " | DIVERGENCE: " + ($flags -join "; ") }

    $row = @(
        $ra.case_id, $ra.arm, $synthFile, "A", "B",
        $adj_EF.value, $adj_MD.value, $adj_UC.value, $adj_VP.value, $adj_SP.value, $adj_TR.value, $adj_DU.value, $adj_TF.value,
        $adj_overall.value, $capsStr, $adjStatus,
        "scorer_packets/output/scorerA_all.md", "scorer_packets/output/scorerB_all.md",
        $notes
    ) | ForEach-Object {
        $v = ($_ -as [string]); if ($null -eq $v) { $v = "" }
        if ($v -match '[,"\r\n]') { $v = '"' + ($v -replace '"', '""') + '"' }
        $v
    }
    ($row -join ",") | Add-Content -LiteralPath $scoresCsv -Encoding UTF8
}

Write-Host ""
Write-Host "synthesis_scores.csv written ($((Import-Csv $scoresCsv).Count) rows)"
Write-Host "Rows needing review (divergence flagged): $adjudicationNeeded"
