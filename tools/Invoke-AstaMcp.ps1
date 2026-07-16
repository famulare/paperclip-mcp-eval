# Asta Scientific Corpus Tool MCP wrapper (Ai2 / Semantic Scholar).
# Canonical reproducible transport for the Asta arm, mirroring Invoke-PaperclipMcp.ps1.
#
# Differences from the Paperclip invoker:
#   - Endpoint is Ai2's Asta MCP (https://asta-tools.allen.ai/mcp/v1), a Streamable-HTTP
#     MCP server that responds with text/event-stream (SSE). We extract the JSON-RPC
#     result from the `data:` line(s), ignoring `: ping` keepalive comments.
#   - KEYLESS by default: the endpoint serves initialize/tools-list/tools-call without
#     an API key. -ApiKey is optional (sets x-api-key) for higher rate limits if Ai2
#     issues one via https://share.hsforms.com/1L4hUh20oT3mu8iXJQMV77w3ioxm.
#   - Built-in backoff+retry: the anonymous tier rate-limits (S2 returns HTTP 429;
#     the Asta wrapper surfaces this as refused upstream connections / SSE-pings-only),
#     so callers MUST pace. Defaults are conservative.
#
# Usage:
#   ./Invoke-AstaMcp.ps1 -Tool get_paper -Arguments '{"paper_id":"PMID:30145929","fields":"title,year,venue"}'
#   ./Invoke-AstaMcp.ps1 -Tool snippet_search -Arguments '{"query":"...","paper_ids":"PMID:30145929","limit":2}'

param(
    [Parameter(Mandatory = $true)][string]$Tool,
    [string]$Arguments = "{}",
    [string]$Endpoint = "https://asta-tools.allen.ai/mcp/v1",
    [string]$ApiKey = "",
    [int]$MaxRetries = 8,
    [double]$BaseDelaySeconds = 6,
    [int]$TimeoutSeconds = 120
)

$ErrorActionPreference = "Stop"

$argObj = $Arguments | ConvertFrom-Json
$body = @{
    jsonrpc = "2.0"
    id      = 1
    method  = "tools/call"
    params  = @{ name = $Tool; arguments = $argObj }
} | ConvertTo-Json -Depth 12

# Key resolution: explicit -ApiKey, else env ASTA_API_KEY, else gitignored ..\.asta.key.
if (-not $ApiKey) { if ($env:ASTA_API_KEY) { $ApiKey = $env:ASTA_API_KEY } }
if (-not $ApiKey) {
    $keyFile = Join-Path $PSScriptRoot "..\.asta.key"
    if (Test-Path -LiteralPath $keyFile) { $ApiKey = (Get-Content -LiteralPath $keyFile -Raw).Trim() }
}

$headers = @{ "Accept" = "application/json, text/event-stream" }
if ($ApiKey) { $headers["x-api-key"] = $ApiKey }

$attempt = 0
$delay = $BaseDelaySeconds
while ($true) {
    $attempt++
    try {
        $resp = Invoke-WebRequest -Uri $Endpoint -Method Post -ContentType "application/json" `
            -Headers $headers -Body $body -TimeoutSec $TimeoutSeconds -UseBasicParsing
        # SSE payload: take the last `data:` line, ignore `: ping` comment lines.
        $dataLine = ($resp.Content -split "`n" | Where-Object { $_ -like "data:*" } | Select-Object -Last 1)
        if ($dataLine) {
            $obj = ($dataLine -replace '^data:\s*', '') | ConvertFrom-Json
            if ($obj.error) { throw "MCP error: $($obj.error | ConvertTo-Json -Compress -Depth 8)" }
            if ($null -ne $obj.result) {
                $txt = $null
                if ($obj.result.content) {
                    $txt = (@($obj.result.content) | Where-Object { $_.type -eq "text" } | ForEach-Object { $_.text }) -join "`n"
                }
                if (-not $txt) { $txt = $obj.result | ConvertTo-Json -Depth 20 }
                return $txt
            }
        }
        throw "no data payload (SSE pings only) — backend slow or rate-limited"
    }
    catch {
        if ($attempt -ge $MaxRetries) {
            throw "Asta MCP call failed after $attempt attempts: $($_.Exception.Message)"
        }
        Start-Sleep -Seconds $delay
        $delay = [Math]::Min($delay * 2, 120)
    }
}
