# Builds the player download: dist/HP1-VR-V31-<Version>.zip plus a .sha256 file.
# The ZIP holds only the installable kit (manifest files, the manifest and LICENSE)
# inside one top folder, so players can extract it and run Install.cmd.
[CmdletBinding()]
param([string]$Version,[string]$KitRoot=(Split-Path $PSScriptRoot -Parent),[string]$OutDir)
$ErrorActionPreference='Stop'
Set-StrictMode -Version Latest
$KitRoot=[IO.Path]::GetFullPath($KitRoot)
if(!$OutDir){$OutDir=Join-Path $KitRoot 'dist'}

& (Join-Path $PSScriptRoot 'Test-Kit.ps1') -KitRoot $KitRoot
if($LASTEXITCODE){throw 'Kit check failed; release not built.'}

$manifest=Get-Content -LiteralPath (Join-Path $KitRoot 'package-manifest.json') -Raw -Encoding UTF8 | ConvertFrom-Json
if(!$Version){$Version=$manifest.version}
$top='HP1 VR V31 Mod'
$files=@($manifest.files | ForEach-Object { $_.path }) + 'package-manifest.json','LICENSE'

New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
$zip=Join-Path ([IO.Path]::GetFullPath($OutDir)) "HP1-VR-V31-$Version.zip"
if(Test-Path -LiteralPath $zip){Remove-Item -LiteralPath $zip}
Add-Type -AssemblyName System.IO.Compression,System.IO.Compression.FileSystem
$archive=[IO.Compression.ZipFile]::Open($zip,[IO.Compression.ZipArchiveMode]::Create)
try{
 foreach($rel in $files){
  $entry=$top+'/'+$rel.Replace('\','/')
  $null=[IO.Compression.ZipFileExtensions]::CreateEntryFromFile($archive,(Join-Path $KitRoot $rel),$entry,[IO.Compression.CompressionLevel]::Optimal)
 }
}finally{$archive.Dispose()}

$hash=(Get-FileHash -LiteralPath $zip -Algorithm SHA256).Hash
$name=[IO.Path]::GetFileName($zip)
[IO.File]::WriteAllText("$zip.sha256","$hash  $name`n")
Write-Host "Built $name ($($files.Count) files)"
Write-Host "SHA-256 $hash"
