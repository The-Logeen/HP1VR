# Checks that this folder is a complete, unmodified HP1 VR mod kit.
# Runs on Windows PowerShell 5.1 and PowerShell 7. Exit code 0 means the kit is good.
[CmdletBinding()]
param([string]$KitRoot=(Split-Path $PSScriptRoot -Parent))
$ErrorActionPreference='Stop'
Set-StrictMode -Version Latest
$KitRoot=[IO.Path]::GetFullPath($KitRoot)
$problems=New-Object Collections.Generic.List[string]

$manifest=Get-Content -LiteralPath (Join-Path $KitRoot 'package-manifest.json') -Raw -Encoding UTF8 | ConvertFrom-Json
foreach($f in $manifest.files){
 $path=Join-Path $KitRoot $f.path
 if(!(Test-Path -LiteralPath $path -PathType Leaf)){$problems.Add("Missing: $($f.path)");continue}
 $item=Get-Item -LiteralPath $path
 if($item.Length -ne $f.bytes){$problems.Add("Size changed: $($f.path) ($($item.Length) bytes, manifest says $($f.bytes))");continue}
 if((Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash -ne $f.sha256){$problems.Add("Contents changed: $($f.path)")}
}

foreach($json in 'DEPENDENCIES.json','supported-inputs.json','renderer-files.json','payload/VR/actions_v31.json'){
 try{$null=Get-Content -LiteralPath (Join-Path $KitRoot $json) -Raw -Encoding UTF8 | ConvertFrom-Json}catch{$problems.Add("Invalid JSON: $json")}
}

# Game content, saves and downloaded dependencies must never be part of the kit.
$forbidden='\.(unr|u|utx|uax|umx|dds|usa|log|zip|7z|rar)$'
$skip='^(\.git|\.github|tools|dist)(\\|/|$)'
Get-ChildItem -LiteralPath $KitRoot -Recurse -File -Force | ForEach-Object {
 $rel=$_.FullName.Substring($KitRoot.Length).TrimStart('\','/')
 if($rel -notmatch $skip -and ($rel -match $forbidden -or $rel -match '(^|[\\/])(Runtime|Save)([\\/])')){$problems.Add("Must not be in the kit: $rel")}
}

if($problems.Count){
 $problems | ForEach-Object { Write-Host "FAIL  $_" -ForegroundColor Red }
 Write-Host "$($problems.Count) problem(s). If you edited a listed file on purpose, reseal package-manifest.json." -ForegroundColor Red
 exit 1
}
Write-Host "OK  $($manifest.version): all $(@($manifest.files).Count) manifest files match." -ForegroundColor Green
exit 0
