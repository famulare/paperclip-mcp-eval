# Pass-3 local PDF extractor.
# Origin: Claude Opus 4.7 (1M context). 2026-05-22.
#
# For each case with a local PDF in the evaluator's local PDF archive, runs
# pdftotext -layout and extracts a representative slice (head ~2500 chars +
# tail ~700 chars) so the local-PDF evidence bundle can reference real local
# text without dumping the whole article.
#
# Set $env:PAPERCLIP_EVAL_PDF_ROOT to point at your own PDF archive, or pass
# -PdfRoot. Missing PDFs are reported but do not halt the run.

param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path,
    [string]$PdfRoot = $(if ($env:PAPERCLIP_EVAL_PDF_ROOT) { $env:PAPERCLIP_EVAL_PDF_ROOT } else { Join-Path $PSScriptRoot "..\local_pdf_archive" })
)

$ErrorActionPreference = "Continue"
$fence = '```'
$outDir = Join-Path $RepoRoot "validation_logs" "local_pdf_slices"
if (-not (Test-Path -LiteralPath $outDir)) {
    New-Item -ItemType Directory -Path $outDir | Out-Null
}

$pdfMap = @{
    "famulare-2018-plosbio__main" = "Famulare_Bellevue_2017_Assessing_the_stability_of_polio_eradication_after_the_withdrawal_of_oral_polio.pdf"
    "famulare-2018-plosbio__s1" = "Unknown_1960_S1_Text_Assessing_the_stability_of_polio_eradication_after_the_withdrawal_of.pdf"
    "kew-2005-opv-review" = "Kew_2005_Vaccine_derived_polioviruses_and_the_endgame_strategy_for_global_polio.pdf"
    "hornick-typhoid__1966" = "Hornick_1966_Study_of_induced_typhoid_fever_in_man._I._Evaluati.pdf"
    "hornick-typhoid__1970" = "Hornick_Snyder_1970_Typhoid_fever_pathogenesis_and_immunologic_Part_2.pdf"
    "hornick-typhoid__2008" = "Hornick_R._B._Snyder_2008_Typhoid_Fever_Pathogenesis_and_Immunologic_Control.pdf"
    "thakkar-famulare-arxiv__2023" = "Unknown_2023_generating_function_perspective_on_the_transmission_forest.pdf"
    "cheslock-1960-ocr" = "Cheslock_McCULLY_1960_Response_of_human_beings_to_a_low_vitamin_B6_diet.pdf"
}

$metricsRows = New-Object System.Collections.Generic.List[string]
$metricsRows.Add("| Slot | File | Pages | Chars | Lines | First 80 chars |")
$metricsRows.Add("|---|---|---:|---:|---:|---|")

foreach ($slot in $pdfMap.Keys) {
    $fname = $pdfMap[$slot]
    $fpath = Join-Path $PdfRoot $fname
    if (-not (Test-Path -LiteralPath $fpath)) {
        Write-Host "MISSING: $fpath"
        $metricsRows.Add("| $slot | $fname | - | - | - | NOT FOUND |")
        continue
    }
    Write-Host "Extracting $slot from $fname"
    $tmpTxt = [System.IO.Path]::GetTempFileName()
    & pdftotext -layout -enc UTF-8 "$fpath" $tmpTxt 2>&1 | Out-Null
    $text = Get-Content -LiteralPath $tmpTxt -Raw
    $chars = $text.Length
    $lines = ($text -split "`r?`n").Count

    # Get page count via pdfinfo if available.
    $pages = "-"
    try {
        $pdfinfoOut = & pdfinfo "$fpath" 2>&1 | Out-String
        if ($pdfinfoOut -match "Pages:\s+(\d+)") { $pages = $Matches[1] }
    } catch {}

    $firstChars = if ($text.Length -gt 0) { ($text.Substring(0, [Math]::Min(80, $text.Length)) -replace "[\r\n]+", " ").Trim() } else { "" }
    $metricsRows.Add("| $slot | $fname | $pages | $chars | $lines | $firstChars |")

    # Slice: first 2500 chars + last 700 chars.
    $headLen = [Math]::Min(2500, $text.Length)
    $head = $text.Substring(0, $headLen)
    $tail = ""
    if ($text.Length -gt 3500) {
        $tail = $text.Substring($text.Length - 700, 700)
    }
    $sliceLines = New-Object System.Collections.Generic.List[string]
    $sliceLines.Add("# Local PDF Slice: $slot")
    $sliceLines.Add("")
    $sliceLines.Add("**File:** $fname")
    $sliceLines.Add("**Pages:** $pages")
    $sliceLines.Add("**Chars:** $chars")
    $sliceLines.Add("**Lines:** $lines")
    $sliceLines.Add("")
    $sliceLines.Add("## Head slice (first $headLen chars)")
    $sliceLines.Add("")
    $sliceLines.Add($fence)
    $sliceLines.Add($head)
    $sliceLines.Add($fence)
    if ($tail) {
        $sliceLines.Add("")
        $sliceLines.Add("## Tail slice (last 700 chars)")
        $sliceLines.Add("")
        $sliceLines.Add($fence)
        $sliceLines.Add($tail)
        $sliceLines.Add($fence)
    }
    $slice = $sliceLines -join "`r`n"
    $sliceFile = Join-Path $outDir "$slot.md"
    Set-Content -LiteralPath $sliceFile -Value $slice -Encoding UTF8
    Remove-Item -LiteralPath $tmpTxt -ErrorAction SilentlyContinue
}

# Write metrics summary.
$metricsHeader = @"
# Local PDF Metrics (Pass 3)

**Origin:** Claude Opus 4.7 (1M context).
**Date:** $(Get-Date -Format yyyy-MM-dd)

Slices are saved per file in ``local_pdf_slices/``. Identity validated by file name + first 80 chars.

"@
$metricsHeader + ($metricsRows -join "`r`n") | Set-Content -LiteralPath (Join-Path $RepoRoot "validation_logs" "local_pdf_metrics.md") -Encoding UTF8

Write-Host ""
Write-Host "Done. Slices in $outDir"
