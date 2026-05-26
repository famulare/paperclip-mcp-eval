param(
    [Parameter(Mandatory = $true)]
    [string]$Path
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $Path)) {
    throw "PDF not found: $Path"
}

$item = Get-Item -LiteralPath $Path
$pdfInfoText = & pdfinfo $item.FullName 2>&1
$text = & pdftotext -layout $item.FullName - 2>$null

$pages = $null
foreach ($line in $pdfInfoText) {
    if ($line -match "^Pages:\s+(\d+)") {
        $pages = [int]$Matches[1]
        break
    }
}

$joined = ($text -join "`n")
$nonWhitespaceChars = ($joined -replace "\s", "").Length
$lines = @($text).Count
$firstTextPresent = $nonWhitespaceChars -gt 100

$warnings = New-Object System.Collections.Generic.List[string]
if (-not $firstTextPresent) {
    $warnings.Add("little-or-no-extracted-text")
}
if ($joined -match "\uFFFD|Â|") {
    $warnings.Add("encoding-or-formfeed-artifacts")
}
if ($lines -gt 0 -and $pages -gt 0 -and ($lines / [Math]::Max($pages, 1)) -lt 8) {
    $warnings.Add("sparse-lines-per-page")
}

[pscustomobject]@{
    path = $item.FullName
    file_size_bytes = $item.Length
    pages = $pages
    extracted_lines = $lines
    extracted_chars = $joined.Length
    extracted_non_whitespace_chars = $nonWhitespaceChars
    first_text_present = $firstTextPresent
    warnings = @($warnings)
} | ConvertTo-Json -Depth 4
