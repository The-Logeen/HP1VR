# Reseals package-manifest.json after you deliberately edit files it lists
# (a README fix, a new binary). Updates each file's size and SHA-256 in place.
[CmdletBinding()]
param([string]$KitRoot=(Split-Path $PSScriptRoot -Parent))
$ErrorActionPreference='Stop'
Set-StrictMode -Version Latest
$path=Join-Path $KitRoot 'package-manifest.json'
$text=[IO.File]::ReadAllText($path)
$pattern='("path":\s*")([^"]+)(",\s*"bytes":\s*)(\d+)(,\s*"sha256":\s*")([0-9A-F]{64})(")'
$updated=[regex]::Replace($text,$pattern,{param($m)
 $file=Join-Path $KitRoot $m.Groups[2].Value
 $bytes=(Get-Item -LiteralPath $file).Length
 $hash=(Get-FileHash -LiteralPath $file -Algorithm SHA256).Hash
 if($hash -ne $m.Groups[6].Value){Write-Host "Updated $($m.Groups[2].Value)"}
 $m.Groups[1].Value+$m.Groups[2].Value+$m.Groups[3].Value+$bytes+$m.Groups[5].Value+$hash+$m.Groups[7].Value
})
[IO.File]::WriteAllText($path,$updated,(New-Object Text.UTF8Encoding($false)))
& (Join-Path $PSScriptRoot 'Test-Kit.ps1') -KitRoot $KitRoot
exit $LASTEXITCODE
