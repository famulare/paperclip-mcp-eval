param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$ErrorActionPreference = "Stop"

$requiredFiles = @(
    "README.md",
    "methodology.md",
    "final_recommendation.md",
    "adversarial_review_response.md",
    "scoring_rubric.md",
    "hybrid_workflow.md",
    "error_taxonomy.md",
    "index_scope_findings.md",
    "corpus_registry.csv",
    "retrieval_observations.csv",
    "identity_validation.csv",
    "index_scope_probes.csv",
    "supplement_inventory.csv",
    "version_lineage.csv",
    "trial_reconciliation.csv",
    "negative_controls.csv",
    "hybrid_runs.csv",
    "synthesis_scores.csv",
    "hybrid_value_classification.csv"
)

$requiredDirs = @(
    "evidence_bundles",
    "synthesis_outputs",
    "scorer_packets/input",
    "scorer_packets/output",
    "retrieval_packets",
    "validation_logs",
    "ground_truth",
    "tools"
)

$errors = New-Object System.Collections.Generic.List[string]

foreach ($file in $requiredFiles) {
    $path = Join-Path $RepoRoot $file
    if (-not (Test-Path -LiteralPath $path)) {
        $errors.Add("Missing required file: $file")
    }
}

foreach ($dir in $requiredDirs) {
    $path = Join-Path $RepoRoot $dir
    if (-not (Test-Path -LiteralPath $path -PathType Container)) {
        $errors.Add("Missing required directory: $dir")
    }
}

$csvFiles = Get-ChildItem -LiteralPath $RepoRoot -Filter "*.csv" -File
foreach ($csv in $csvFiles) {
    try {
        $null = Import-Csv -LiteralPath $csv.FullName
    }
    catch {
        $errors.Add("CSV parse failed: $($csv.Name): $($_.Exception.Message)")
    }
}

# Score rows must link to synthesis files, scorer outputs, and ground truth files.
$scoresPath = Join-Path $RepoRoot "synthesis_scores.csv"
if (Test-Path -LiteralPath $scoresPath) {
    $scores = Import-Csv -LiteralPath $scoresPath
    foreach ($score in $scores) {
        if ($score.overall_score -and $score.overall_score -ne "NA") {
            if (-not $score.synthesis_file) {
                $errors.Add("Score missing synthesis_file for $($score.case_id)/$($score.source_arm)")
            }
            else {
                $synthPath = Join-Path $RepoRoot $score.synthesis_file
                if (-not (Test-Path -LiteralPath $synthPath)) {
                    $errors.Add("Score references missing synthesis file: $($score.synthesis_file)")
                }
            }
            foreach ($scorerCol in @("scorer1_output", "scorer2_output")) {
                if (-not $score.$scorerCol) {
                    $errors.Add("Score row missing $scorerCol for $($score.case_id)/$($score.source_arm)")
                }
                else {
                    $scorerPath = Join-Path $RepoRoot $score.$scorerCol
                    if (-not (Test-Path -LiteralPath $scorerPath)) {
                        $errors.Add("Score references missing scorer output: $($score.$scorerCol)")
                    }
                }
            }
            $gtPath = Join-Path $RepoRoot "ground_truth/$($score.case_id).md"
            if (-not (Test-Path -LiteralPath $gtPath)) {
                $errors.Add("Score row case has no ground-truth file: $gtPath")
            }
        }
    }
}

# Forbidden patterns: secrets, OAuth tokens.
$forbiddenPatterns = @(
    "\.paperclip\.key",
    "PAPERCLIP_API_KEY\s*=",
    "X-API-Key\s*[:=]",
    "device_code",
    "access_token",
    "refresh_token"
)

# Files where forbidden patterns may legitimately appear as documentation
# (rubric / methodology / this test script itself / README).
$secretAllowlist = @(
    "README.md",
    "CLAUDE.md",
    "methodology.md",
    "scoring_rubric.md",
    "Test-Artifacts.ps1",
    "Invoke-PaperclipMcp.ps1"
)

$textFiles = Get-ChildItem -LiteralPath $RepoRoot -Recurse -File | Where-Object {
    $_.Extension -match "\.(md|csv|txt|json|ps1)$"
}

foreach ($file in $textFiles) {
    $content = Get-Content -LiteralPath $file.FullName -Raw -ErrorAction SilentlyContinue
    if ($null -eq $content) { continue }
    foreach ($pattern in $forbiddenPatterns) {
        if ($content -match $pattern) {
            if ($file.Name -in $secretAllowlist) {
                continue
            }
            $errors.Add("Forbidden pattern '$pattern' in $($file.FullName)")
        }
    }
    if ($content.Length -gt 250000 -and $file.FullName -match "synthesis_outputs|retrieval_packets|evidence_bundles|validation_logs|ground_truth") {
        $errors.Add("Potential text dump too large: $($file.FullName)")
    }
}

# Residual-reference gate: no file (other than the legitimate-history-mentioning
# documents) should contain `pass3/` or `_v3` patterns after the reorganization.
$residualAllowlist = @(
    "README.md",
    "methodology.md",
    "Test-Artifacts.ps1"
)
$residualPattern = "pass3/|_v3\.csv|_v3\.md|pass3_contract|pass3_plan|Test-Pass3"
foreach ($file in $textFiles) {
    if ($file.Name -in $residualAllowlist) { continue }
    $content = Get-Content -LiteralPath $file.FullName -Raw -ErrorAction SilentlyContinue
    if ($null -eq $content) { continue }
    if ($content -match $residualPattern) {
        $errors.Add("Residual pass3/_v3 reference in $($file.FullName) (post-reorg should have been cleaned)")
    }
}

if ($errors.Count -gt 0) {
    $errors | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Output "Artifact validation passed."
