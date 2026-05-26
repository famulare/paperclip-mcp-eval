param(
    [Parameter(Mandatory = $true)]
    [string]$Command,

    [string]$KeyPath = ""
)

$ErrorActionPreference = "Stop"

if (-not $KeyPath) {
    $scriptRoot = $PSScriptRoot
    if (-not $scriptRoot) {
        $scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
    }
    $KeyPath = Join-Path $scriptRoot "..\.paperclip.key"
}

if (-not (Test-Path -LiteralPath $KeyPath)) {
    throw "Paperclip key not found at $KeyPath"
}

$key = (Get-Content -LiteralPath $KeyPath -Raw).Trim()
if (-not $key) {
    throw "Paperclip key file is empty"
}

$body = @{
    jsonrpc = "2.0"
    method = "tools/call"
    params = @{
        name = "paperclip"
        arguments = @{
            command = $Command
            description = $Command.Substring(0, [Math]::Min(80, $Command.Length))
            skip_truncation = $true
        }
    }
    id = 1
} | ConvertTo-Json -Depth 8

$response = Invoke-RestMethod `
    -Uri "https://paperclip.gxl.ai/mcp" `
    -Method Post `
    -ContentType "application/json" `
    -Headers @{ "X-API-Key" = $key } `
    -Body $body

if ($response.error) {
    $response.error | ConvertTo-Json -Depth 8
    exit 1
}

$texts = @()
foreach ($block in @($response.result.content)) {
    if ($block.type -eq "text") {
        $texts += $block.text
    }
}

($texts -join "`n")
