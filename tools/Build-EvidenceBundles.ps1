# Pass-3 evidence bundle assembler.
# Origin: Claude Opus 4.7 (1M context). 2026-05-22.
#
# For each case x arm, build a self-contained markdown bundle in
# evidence_bundles/<case>__<arm>.md. The bundle is the ONLY input the
# corresponding synthesizer subagent will receive. Arm isolation is enforced
# at this layer.

param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$ErrorActionPreference = "Stop"
$fence = '```'
$packetsDir = Join-Path $RepoRoot "retrieval_packets"
$bundlesDir = Join-Path $RepoRoot "evidence_bundles"
$gtDir = Join-Path $RepoRoot "ground_truth"
$sliceDir = Join-Path $RepoRoot "validation_logs" "local_pdf_slices"

# Per-case arm presence matrix and metadata.
$cases = [ordered]@{
    "famulare-2018-plosbio" = @{
        target = "DOI 10.1371/journal.pbio.2002468 | PMID 29702638 | PMCID PMC5942853 | bioRxiv 10.1101/084012"
        arms = @("paperclip","web","local","hybrid")
        local_slots = @("famulare-2018-plosbio__main","famulare-2018-plosbio__s1")
        notes = "Supplement-heavy; preprint-final lineage; canonical Paperclip-DOI-miss case."
    }
    "sfs-nejm-2020" = @{
        target = "DOI 10.1056/NEJMc2008646 | PMID 32356944 | PMCID PMC7206929"
        arms = @("paperclip","web","hybrid")
        local_slots = @()
        notes = "NEJM correspondence; canonical content-organization spot-check (supplement merged into content.lines)."
    }
    "kew-2005-opv-review" = @{
        target = "DOI 10.1146/annurev.micro.58.030603.123625 | PMID 16153180"
        arms = @("paperclip","web","local","hybrid")
        local_slots = @("kew-2005-opv-review")
        notes = "Annual Reviews; canonical Paperclip exact-ID miss."
    }
    "khoury-2021-natmed" = @{
        target = "DOI 10.1038/s41591-021-01377-8 | PMID 34002089 | medRxiv 10.1101/2021.03.09.21252641"
        arms = @("paperclip","web","hybrid")
        local_slots = @()
        notes = "Final article vs preprint; canonical preprint-returned-when-final-requested case."
    }
    "hornick-typhoid" = @{
        target = "PMID 4916913 | N Engl J Med 1970"
        arms = @("paperclip","web","local","hybrid")
        local_slots = @("hornick-typhoid__1966","hornick-typhoid__1970","hornick-typhoid__2008")
        notes = "Pre-1980 NEJM + OCR stress case."
    }
    "thakkar-famulare-arxiv" = @{
        target = "arXiv 2205.02150 | arXiv 2311.16317"
        arms = @("paperclip","web","local","hybrid")
        local_slots = @("thakkar-famulare-arxiv__2023")
        notes = "Theory/math preprints; notation-aware."
    }
    "nigeria-2015-versioning" = @{
        target = "arXiv 1504.02751 | PMID 26317401 | DOI 10.1371/journal.pone.0135765"
        arms = @("paperclip","web","hybrid")
        local_slots = @()
        notes = "Canonical version-lineage case."
    }
    "cheslock-1960-ocr" = @{
        target = "Local: Cheslock_McCULLY_1960 PDF"
        arms = @("paperclip","local","hybrid")
        local_slots = @("cheslock-1960-ocr")
        notes = "Old scanned local-only case; no PubMed metadata."
    }
    "nct04232943-pmid36746739" = @{
        target = "NCT04232943 | PMID 36746739 | PMCID PMC9996288 | DOI 10.1016/j.vaccine.2023.01.048"
        arms = @("paperclip","web","hybrid")
        local_slots = @()
        notes = "Trial-paper bridge; canonical trial-map failure."
    }
    "heldout-tbe-vaccine" = @{
        target = "PMID 23997980"
        arms = @("paperclip","web","hybrid")
        local_slots = @()
        notes = "Held-out outside-wheelhouse: TBE vaccine."
    }
    "heldout-hepc-ns5a" = @{
        target = "PMID 26904396"
        arms = @("paperclip","web","hybrid")
        local_slots = @()
        notes = "Held-out outside-wheelhouse: HCV DAA."
    }
    "heldout-tafamidis-attr" = @{
        target = "PMID 30145929"
        arms = @("paperclip","web","hybrid")
        local_slots = @()
        notes = "Held-out outside-wheelhouse: NEJM cardiology RCT."
    }
    "heldout-snakebite" = @{
        target = "PMID 29363648"
        arms = @("paperclip","web","hybrid")
        local_slots = @()
        notes = "Held-out outside-wheelhouse: snakebite preclinical."
    }
    "heldout-podoconiosis" = @{
        target = "PMID 33558538"
        arms = @("paperclip","web","hybrid")
        local_slots = @()
        notes = "Held-out outside-wheelhouse: NTD genetics."
    }
}

function Get-PacketContent {
    param([string]$caseId, [string]$suffix)
    $glob = Join-Path $packetsDir "${caseId}__${suffix}*.txt"
    $files = Get-ChildItem -Path $glob -ErrorAction SilentlyContinue
    if (-not $files) { return $null }
    $result = New-Object System.Collections.Generic.List[string]
    foreach ($f in $files) {
        $result.Add("### $($f.Name)")
        $result.Add("")
        $result.Add($fence)
        $result.Add((Get-Content -LiteralPath $f.FullName -Raw))
        $result.Add($fence)
        $result.Add("")
    }
    return ($result -join "`r`n")
}

function Get-AllPacketsForCase {
    param([string]$caseId)
    # Exclude index-scope probes (those use Pnn-* IDs)
    $files = Get-ChildItem -Path $packetsDir -Filter "${caseId}__*.txt" -ErrorAction SilentlyContinue
    if (-not $files) { return $null }
    $result = New-Object System.Collections.Generic.List[string]
    foreach ($f in ($files | Sort-Object Name)) {
        $result.Add("### $($f.Name)")
        $result.Add("")
        $result.Add($fence)
        $result.Add((Get-Content -LiteralPath $f.FullName -Raw))
        $result.Add($fence)
        $result.Add("")
    }
    return ($result -join "`r`n")
}

function Build-PaperclipBundle {
    param([string]$caseId, [hashtable]$c)
    $bundle = New-Object System.Collections.Generic.List[string]
    $bundle.Add("# Evidence Bundle: $caseId | Arm: Paperclip MCP")
    $bundle.Add("")
    $bundle.Add("**Target identifier(s) requested:** $($c.target)")
    $bundle.Add("**Case notes:** $($c.notes)")
    $bundle.Add("**Synthesizer rule:** Answer the 8 evaluation prompts using ONLY the Paperclip outputs below. Do not consult external knowledge of the paper, authors, or topic. Quote bundle text to support claims. If Paperclip's outputs are wrong, missing, or contaminated (e.g., map across multiple papers), say so explicitly.")
    $bundle.Add("")
    $bundle.Add("**Known Paperclip behaviors to flag:**")
    $bundle.Add("- `map -n 1` does NOT honor the result limit; map output across multiple papers is contaminated.")
    $bundle.Add("- Empty `/papers/<id>/supplements/` directory does not mean no supplements — may be merged into `content.lines`.")
    $bundle.Add("- Top-1 search hit is not identity proof; check that returned PMC/med/arx ID matches the target.")
    $bundle.Add("")
    $bundle.Add("## Paperclip retrieval outputs (verbatim)")
    $bundle.Add("")
    $all = Get-AllPacketsForCase -caseId $caseId
    if ($all) {
        $bundle.Add($all)
    } else {
        $bundle.Add("(no Paperclip packets found for this case)")
    }
    $bundle -join "`r`n"
}

function Build-WebBundle {
    param([string]$caseId, [hashtable]$c)
    $gtPath = Join-Path $gtDir "$caseId.md"
    if (-not (Test-Path -LiteralPath $gtPath)) { return $null }
    $gt = Get-Content -LiteralPath $gtPath -Raw

    $bundle = New-Object System.Collections.Generic.List[string]
    $bundle.Add("# Evidence Bundle: $caseId | Arm: Live web/API")
    $bundle.Add("")
    $bundle.Add("**Target identifier(s) requested:** $($c.target)")
    $bundle.Add("**Case notes:** $($c.notes)")
    $bundle.Add("**Synthesizer rule:** Answer the 8 evaluation prompts using ONLY the web/API metadata, abstract, and registry information below. Do not consult external knowledge. Metadata-only synthesis is intentionally limited; if a prompt requires content beyond the abstract, write 'Cannot answer from web/API metadata + abstract only' and explain. The 'Diagnostic claim anchors' section is the answer key for scorers, not for you — but using those phrasings is fine when they appear in the abstract.")
    $bundle.Add("")
    $bundle.Add("## Web/API authoritative metadata")
    $bundle.Add("")
    $bundle.Add($gt)
    $bundle -join "`r`n"
}

function Build-LocalBundle {
    param([string]$caseId, [hashtable]$c)
    if (-not $c.local_slots -or $c.local_slots.Count -eq 0) { return $null }

    $bundle = New-Object System.Collections.Generic.List[string]
    $bundle.Add("# Evidence Bundle: $caseId | Arm: Local PDF")
    $bundle.Add("")
    $bundle.Add("**Target identifier(s) requested:** $($c.target)")
    $bundle.Add("**Case notes:** $($c.notes)")
    $bundle.Add("**Synthesizer rule:** Answer the 8 evaluation prompts using ONLY the local PDF text slices below. Do not consult external knowledge. The slices include head + tail of the extracted text, plus filename and metrics. If the slice text is OCR-poor or sparse, say so. Do not invent content not in the slice.")
    $bundle.Add("")
    foreach ($slot in $c.local_slots) {
        $slicePath = Join-Path $sliceDir "$slot.md"
        if (Test-Path -LiteralPath $slicePath) {
            $bundle.Add("## Slot: $slot")
            $bundle.Add("")
            $bundle.Add((Get-Content -LiteralPath $slicePath -Raw))
            $bundle.Add("")
        } else {
            $bundle.Add("## Slot: $slot")
            $bundle.Add("")
            $bundle.Add("(slice file not found at $slicePath)")
            $bundle.Add("")
        }
    }
    $bundle -join "`r`n"
}

function Build-HybridBundle {
    param([string]$caseId, [hashtable]$c)
    # Hybrid is the deliberate combination per the predeclared workflow.
    # Order: web identity -> Paperclip inventory -> local PDF (if available).
    $bundle = New-Object System.Collections.Generic.List[string]
    $bundle.Add("# Evidence Bundle: $caseId | Arm: Hybrid (predeclared workflow)")
    $bundle.Add("")
    $bundle.Add("**Target identifier(s) requested:** $($c.target)")
    $bundle.Add("**Case notes:** $($c.notes)")
    $bundle.Add("**Synthesizer rule:** This is the hybrid arm. You have access to web/API identity, Paperclip retrieval, and (if applicable) local PDF slices. Answer the 8 prompts using only the evidence in this bundle. Treat the web/API metadata as identity truth, Paperclip outputs as content evidence to be checked, and local PDF slices as content evidence to be checked. Flag arm conflicts (e.g., Paperclip returned a different paper than the target) explicitly. Do not invent.")
    $bundle.Add("")

    # 1. Web identity.
    $gtPath = Join-Path $gtDir "$caseId.md"
    if (Test-Path -LiteralPath $gtPath) {
        $bundle.Add("## Section 1 — Web/API identity and abstract")
        $bundle.Add("")
        $bundle.Add((Get-Content -LiteralPath $gtPath -Raw))
        $bundle.Add("")
    }

    # 2. Paperclip outputs.
    $pcOut = Get-AllPacketsForCase -caseId $caseId
    if ($pcOut) {
        $bundle.Add("## Section 2 — Paperclip retrieval outputs (verbatim)")
        $bundle.Add("")
        $bundle.Add("Reminder: `map -n 1` does not honor `-n`; map outputs may be multi-paper. Empty supplement dir does not mean no supplements (could be merged into content.lines).")
        $bundle.Add("")
        $bundle.Add($pcOut)
        $bundle.Add("")
    }

    # 3. Local PDF slices.
    if ($c.local_slots -and $c.local_slots.Count -gt 0) {
        $bundle.Add("## Section 3 — Local PDF slices")
        $bundle.Add("")
        foreach ($slot in $c.local_slots) {
            $slicePath = Join-Path $sliceDir "$slot.md"
            if (Test-Path -LiteralPath $slicePath) {
                $bundle.Add("### Slot: $slot")
                $bundle.Add("")
                $bundle.Add((Get-Content -LiteralPath $slicePath -Raw))
                $bundle.Add("")
            }
        }
    }
    $bundle -join "`r`n"
}

$total = 0
foreach ($caseId in $cases.Keys) {
    $c = $cases[$caseId]
    foreach ($arm in $c.arms) {
        $content = $null
        switch ($arm) {
            "paperclip" { $content = Build-PaperclipBundle -caseId $caseId -c $c }
            "web"       { $content = Build-WebBundle -caseId $caseId -c $c }
            "local"     { $content = Build-LocalBundle -caseId $caseId -c $c }
            "hybrid"    { $content = Build-HybridBundle -caseId $caseId -c $c }
        }
        if ($content) {
            $fname = "${caseId}__${arm}.md"
            $outPath = Join-Path $bundlesDir $fname
            Set-Content -LiteralPath $outPath -Value $content -Encoding UTF8
            $total++
            Write-Host "Wrote $fname"
        } else {
            Write-Host "Skipped ${caseId}__${arm} (no content)"
        }
    }
}

Write-Host ""
Write-Host "Total bundles written: $total"
