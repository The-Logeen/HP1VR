[CmdletBinding()]
param(
 [string]$GameRoot, [string]$RendererRoot, [string]$TexturePackRoot,
 [string]$MenuAddonRoot, [string]$MenuLanguage,
 [string[]]$GameModRoots=@(), [string]$Destination,
 [switch]$ValidateOnly
)
$ErrorActionPreference='Stop'
Set-StrictMode -Version Latest
$kit=$PSScriptRoot
. (Join-Path $kit 'FilePolicy.ps1')
if(!$GameRoot){$GameRoot=Read-Host 'Your installed HP1 game folder (containing System and Maps)'}
if(!$RendererRoot){$RendererRoot=Read-Host 'Extracted hp1dx11renderer162 folder (containing Common and Harry Potter 1)'}
if(!$TexturePackRoot -and !$PSBoundParameters.ContainsKey('TexturePackRoot')){$TexturePackRoot=Read-Host 'Recommended: extracted ESRGAN v3 pack folder (Enter explicitly selects original-texture fallback)'}
if(!$TexturePackRoot){Write-Warning 'Original-texture fallback selected. VR and our water fix remain active, but this will not match the ESRGAN-enhanced appearance.'}
if(!$Destination){$Destination=Join-Path (Split-Path $kit -Parent) 'HP1 VR V31 Installed'}
function Full([string]$p){[IO.Path]::GetFullPath($p).TrimEnd('\','/')}
function Under([string]$child,[string]$parent){$c=Full $child;$p=Full $parent;return $c.Equals($p,[StringComparison]::OrdinalIgnoreCase) -or $c.StartsWith($p+'\',[StringComparison]::OrdinalIgnoreCase)}
function RequireFile([string]$p){if(!(Test-Path -LiteralPath $p -PathType Leaf)){throw "Required file missing: $p"}}
$GameRoot=Full $GameRoot;$RendererRoot=Full $RendererRoot;$Destination=Full $Destination
if((Under $Destination $kit) -or (Under $kit $Destination)){throw 'Choose a destination separate from this mod kit.'}
foreach($source in @($GameRoot,$RendererRoot,$TexturePackRoot,$MenuAddonRoot)+$GameModRoots){if($source){if(!(Test-Path -LiteralPath $source -PathType Container)){throw "Source folder missing: $source"};if((Under $source $Destination) -or (Under $Destination $source)){throw 'Install destination must be separate from every source folder.'}}}
if(Test-Path -LiteralPath $Destination){if(@(Get-ChildItem -LiteralPath $Destination -Force).Count){throw "Destination is not empty. Nothing overwritten: $Destination"}}
foreach($name in 'Core.dll','Engine.dll','WinDrv.dll','Galaxy.dll','Fire.dll','HPBase.u','HarryPotter.u','HPMenu.u'){RequireFile (Join-Path $GameRoot "System\$name")}
RequireFile (Join-Path $GameRoot 'Maps\Lev_Tut1.unr')
foreach($name in 'Common\D3D11Drv.int','Common\Effects11.dll','Harry Potter 1\d3d11drv.dll','Harry Potter 1\tessellation.cfg','Common\d3d11drv\firstpass.fco'){RequireFile (Join-Path $RendererRoot $name)}
if($TexturePackRoot -and !(Test-Path -LiteralPath (Join-Path $TexturePackRoot 'Textures'))){throw 'Texture pack must contain its Textures folder; select the extracted pack root.'}
foreach($source in @($GameRoot,$RendererRoot,$TexturePackRoot,$MenuAddonRoot)+$GameModRoots){if($source){
 if((Get-Item -LiteralPath $source).Attributes -band [IO.FileAttributes]::ReparsePoint){throw 'Linked source folders are not supported.'}
 if(Get-ChildItem -LiteralPath $source -Recurse -Force | Where-Object {$_.Attributes -band [IO.FileAttributes]::ReparsePoint} | Select-Object -First 1){throw 'Linked files/folders inside inputs are not supported.'}
}}
if($MenuLanguage){if(!$MenuAddonRoot){throw 'MenuLanguage also requires MenuAddonRoot.'};if([IO.Path]::GetFileName($MenuLanguage) -ne $MenuLanguage -or $MenuLanguage -eq '..'){throw 'MenuLanguage must be one addon folder name.'};if(!(Test-Path -LiteralPath (Join-Path $MenuAddonRoot "$MenuLanguage\Textures"))){throw 'Requested menu language is not in the supplied addon.'}}
foreach($mod in $GameModRoots){if(!(@('System','Maps','Textures','Sounds','Music')|Where-Object {Test-Path -LiteralPath (Join-Path $mod $_)})){throw "Game mod has no supported game folder layout: $mod"}}
$manifest=Get-Content -LiteralPath (Join-Path $kit 'package-manifest.json') -Raw -Encoding UTF8 | ConvertFrom-Json
foreach($f in $manifest.files){$path=Join-Path $kit $f.path;if(!(Under $path $kit)){throw 'Invalid package manifest path'};RequireFile $path;if((Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash -ne $f.sha256){throw "Package file damaged or changed: $($f.path)"}}
$supported=Get-Content -LiteralPath (Join-Path $kit 'supported-inputs.json') -Raw -Encoding UTF8 | ConvertFrom-Json
foreach($f in $supported.game){
 $path=Join-Path $GameRoot ('System\'+$f.name)
 # Account for supplied mods in order: later overlays win, as on installation.
 foreach($mod in $GameModRoots){$overlay=Join-Path $mod ('System\'+$f.name);if(Test-Path -LiteralPath $overlay){$path=$overlay}}
 if((Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash -ne $f.sha256){throw "Unsupported engine/script build: $($f.name). This VR build uses verified native hooks; refusing an untested combination."}
}
if((Get-FileHash -LiteralPath (Join-Path $RendererRoot 'Harry Potter 1\d3d11drv.dll')).Hash -ne $supported.renderer.sha256){throw 'This installer expects the HP1 DX11 renderer 1.6.2, not a renderer DLL for another game/version.'}
$rendererFiles=Get-Content -LiteralPath (Join-Path $kit 'renderer-files.json') -Raw -Encoding UTF8 | ConvertFrom-Json
foreach($f in $rendererFiles){$path=Join-Path $RendererRoot $f.path;if(!(Under $path $RendererRoot)){throw 'Invalid renderer path'};RequireFile $path;if((Get-FileHash -LiteralPath $path).Hash -ne $f.sha256){throw "Renderer 1.6.2 component mismatch: $($f.path)"}}
if($TexturePackRoot){foreach($f in $supported.textures){$path=Join-Path $TexturePackRoot $f.path;RequireFile $path;if((Get-FileHash -LiteralPath $path).Hash -ne $f.sha256){throw "Texture pack version/file mismatch: $($f.path). Use the supported ESRGAN v3 pack, or explicitly choose the fallback."}}}
foreach($dll in 'msvcr100.dll','msvcp100.dll','d3dx11_43.dll','d3dcompiler_43.dll'){
 if(!(Test-Path -LiteralPath (Join-Path $env:WINDIR "SysWOW64\$dll"))){throw "Missing x86 runtime $dll. Use the VC++ 2010 SP1 x86 and DirectX June 2010 download buttons, install them, then retry."}
}
Write-Host 'Inputs and mod package verified. Original game and mod source folders will remain unchanged.'
if($ValidateOnly){return}
$runtime=Join-Path $Destination 'Runtime'
$origins=@{}
function PutFile([string]$source,[string]$relative,[string]$kind){
 $target=Join-Path $runtime $relative
 if(!(Under $target $runtime)){throw "Unsafe destination: $relative"}
 New-Item -ItemType Directory -Path (Split-Path $target -Parent) -Force | Out-Null
 Copy-Item -LiteralPath $source -Destination $target -Force
 $origins[$relative]=[ordered]@{path=$relative;source=[IO.Path]::GetFullPath($source);origin=$kind;sha256=(Get-FileHash -LiteralPath $target).Hash}
}
function PutTree([string]$source,[string]$relative,[string]$kind,[switch]$GameFiles){
 if(!(Test-Path -LiteralPath $source)){return}
 $root=Full $source
 foreach($f in Get-ChildItem -LiteralPath $root -Recurse -File){
  if($f.Attributes -band [IO.FileAttributes]::ReparsePoint){throw "Linked/reparse source file is not supported: $($f.FullName)"}
  $tail=$f.FullName.Substring($root.Length).TrimStart('\','/')
  if(!(Include-PlayFile (Join-Path $relative $tail))){continue}
  if($GameFiles -and ($f.Extension -in '.usa' -or $f.Name -match '^(HP1VR|VRUser|Probe|StereoV\d|GameSaveInfo)')){continue}
  PutFile $f.FullName (Join-Path $relative $tail) $kind
 }
}
New-Item -ItemType Directory -Path $Destination,$runtime,(Join-Path $runtime 'Save'),(Join-Path $runtime 'Cache'),(Join-Path $runtime 'VR') -Force | Out-Null
foreach($dir in 'System','Maps','Textures','Sounds','Music'){PutTree (Join-Path $GameRoot $dir) $dir 'user-game' -GameFiles}
foreach($mod in $GameModRoots){foreach($dir in 'System','Maps','Textures','Sounds','Music'){PutTree (Join-Path $mod $dir) $dir ('user-game-mod:'+ (Split-Path $mod -Leaf)) -GameFiles}}
# Follow renderer readme layout, without deleting anything in the supplied game.
PutFile (Join-Path $RendererRoot 'Common\D3D11Drv.int') 'System\D3D11Drv.int' 'user-dx11-renderer'
PutFile (Join-Path $RendererRoot 'Common\Effects11.dll') 'System\Effects11.dll' 'user-dx11-renderer'
PutFile (Join-Path $RendererRoot 'Harry Potter 1\d3d11drv.dll') 'System\d3d11drv.dll' 'user-dx11-renderer'
PutFile (Join-Path $RendererRoot 'Harry Potter 1\tessellation.cfg') 'System\tessellation.cfg' 'user-dx11-renderer'
PutTree (Join-Path $RendererRoot 'Common\d3d11drv') 'System\d3d11drv' 'user-dx11-renderer'
if($TexturePackRoot){PutTree (Join-Path $TexturePackRoot 'Textures') 'Textures' 'user-esrgan-textures';PutTree (Join-Path $TexturePackRoot 'System') 'System' 'user-esrgan-settings' -GameFiles}
if($MenuLanguage){PutTree (Join-Path $MenuAddonRoot "$MenuLanguage\Textures") 'Textures' ('user-menu-addon:'+ $MenuLanguage)}
# Our VR overrides are last. No original package is altered by the water fix.
PutTree (Join-Path $kit 'payload\System') 'System' 'vr-mod'
PutTree (Join-Path $kit 'payload\VR') 'VR' 'vr-mod'
PutFile (Join-Path $kit 'config\StereoV31VR.ini') 'System\StereoV31VR.ini' 'vr-mod-config'
PutFile (Join-Path $kit 'config\VRUser.ini') 'System\VRUser.ini' 'vr-mod-controls'
Copy-Item -LiteralPath (Join-Path $kit 'Launch-HP1-VR-V31.exe') -Destination $Destination
$launch=[IO.File]::ReadAllText((Join-Path $kit 'config\HP1VR-V31.ini'))
# The versioned template already has one portable [Paths] section.
[IO.File]::WriteAllText((Join-Path $Destination 'HP1VR-V31.ini'),$launch)
Copy-Item -LiteralPath (Join-Path $kit 'README.md') -Destination (Join-Path $Destination 'START HERE.md')
Get-ChildItem -LiteralPath $kit -Filter '*.md' -File | ForEach-Object { Copy-Item -LiteralPath $_.FullName -Destination $Destination }
Copy-Item -LiteralPath (Join-Path $kit 'OPENVR-LICENSE.txt') -Destination $Destination
$record=[ordered]@{schema=1;installedUtc=[DateTime]::UtcNow.ToString('o');gameSource=$GameRoot;rendererSource=$RendererRoot;textureSource=$TexturePackRoot;menuSource=$MenuAddonRoot;menuLanguage=$MenuLanguage;gameModSources=$GameModRoots;files=@($origins.Values|Sort-Object path)}
[IO.File]::WriteAllText((Join-Path $Destination 'installation-manifest.json'),($record|ConvertTo-Json -Depth 7))
$dds=@(Get-ChildItem -LiteralPath (Join-Path $runtime 'Textures') -Recurse -File -Filter '*.dds').Count
Write-Host "Installed: $Destination"
Write-Host "User-supplied DDS replacements: $dds. Saves are local to Runtime\Save. Launch-HP1-VR-V31.exe starts VR."
Write-Host 'This installed folder contains your game/mod files: keep it private. Share the original mod-only ZIP instead.'
