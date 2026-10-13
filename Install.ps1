[CmdletBinding()]
param(
 [string]$GameRoot, [string]$RendererRoot, [string]$TexturePackRoot,
 [string]$MenuAddonRoot, [string]$MenuLanguage,
 [string[]]$GameModRoots=@(), [string]$Destination,
 [switch]$ValidateOnly, [string]$LogPath
)
$ErrorActionPreference='Stop'
Set-StrictMode -Version Latest
$kit=$PSScriptRoot
if($LogPath){
 $logFull=[IO.Path]::GetFullPath($LogPath)
 if([IO.Path]::GetExtension($logFull) -ne '.log'){throw 'LogPath must name a .log file outside the kit, input folders and destination.'}
 foreach($folder in @($kit,$GameRoot,$RendererRoot,$TexturePackRoot,$MenuAddonRoot,$Destination)+$GameModRoots){if($folder){$base=[IO.Path]::GetFullPath($folder).TrimEnd('\','/');if($logFull.Equals($base,[StringComparison]::OrdinalIgnoreCase) -or $logFull.StartsWith($base+'\',[StringComparison]::OrdinalIgnoreCase)){throw "LogPath must be outside kit, source and destination folders: $logFull"}}}
}
. (Join-Path $kit 'LogSupport.ps1')
Initialize-SetupLog $LogPath $(if($ValidateOnly){'verify'}else{'install'}) $kit
try {
Set-SetupStage 'Input selection and path safety'
. (Join-Path $kit 'FilePolicy.ps1')
if(!$GameRoot){$GameRoot=Read-Host 'Your installed HP1 game folder (containing System and Maps)'}
if(!$RendererRoot){$RendererRoot=Read-Host 'Extracted hp1dx11renderer162 folder (containing Common and Harry Potter 1)'}
if(!$TexturePackRoot -and !$PSBoundParameters.ContainsKey('TexturePackRoot')){$TexturePackRoot=Read-Host 'Recommended: extracted ESRGAN v3 pack folder (Enter explicitly selects original-texture fallback)'}
if(!$TexturePackRoot){Write-Warning 'Original-texture fallback selected. VR and our water fix remain active, but this will not match the ESRGAN-enhanced appearance.'}
if(!$Destination){$Destination=Join-Path (Split-Path $kit -Parent) 'HP1 VR V31 Installed'}
function Full([string]$p){[IO.Path]::GetFullPath($p).TrimEnd('\','/')}
function Under([string]$child,[string]$parent){$c=Full $child;$p=Full $parent;return $c.Equals($p,[StringComparison]::OrdinalIgnoreCase) -or $c.StartsWith($p+'\',[StringComparison]::OrdinalIgnoreCase)}
function RequireFile([string]$p){$script:SetupOperation="Check required file: $p";Write-SetupLog DETAIL $script:SetupOperation;if(!(Test-Path -LiteralPath $p -PathType Leaf)){throw "Required file missing: $p"}}
$GameRoot=Full $GameRoot;$RendererRoot=Full $RendererRoot;$Destination=Full $Destination
Write-SetupLog INFO "Inputs: Game=$GameRoot Renderer=$RendererRoot Texture=$TexturePackRoot MenuAddon=$MenuAddonRoot Language=$MenuLanguage Overlays=$($GameModRoots -join ' | ') Destination=$Destination ValidateOnly=$ValidateOnly"
if(![Environment]::Is64BitOperatingSystem){throw '64-bit Windows is required.'}
if($PSVersionTable.PSVersion.Major -lt 5){throw 'Windows PowerShell 5.1 or newer is required.'}
foreach($path in @($GameRoot,$RendererRoot,$Destination)){$drive=[IO.Path]::GetPathRoot($path);try{$info=[IO.DriveInfo]::new($drive);Write-SetupLog INFO "Drive=$drive type=$($info.DriveType) availableBytes=$($info.AvailableFreeSpace)"}catch{Write-SetupLog WARN "Could not query drive space for $drive : $($_.Exception.Message)"}}
if((Under $Destination $kit) -or (Under $kit $Destination)){throw 'Choose a destination separate from this mod kit.'}
foreach($source in @($GameRoot,$RendererRoot,$TexturePackRoot,$MenuAddonRoot)+$GameModRoots){if($source){if(!(Test-Path -LiteralPath $source -PathType Container)){throw "Source folder missing: $source"};if((Under $source $Destination) -or (Under $Destination $source)){throw 'Install destination must be separate from every source folder.'}}}
if(Test-Path -LiteralPath $Destination){if(@(Get-ChildItem -LiteralPath $Destination -Force).Count){throw "Destination is not empty. Nothing overwritten: $Destination"}}
Set-SetupStage 'Required folder layout'
foreach($name in 'Core.dll','Engine.dll','WinDrv.dll','Galaxy.dll','Fire.dll','HPBase.u','HarryPotter.u','HPMenu.u'){RequireFile (Join-Path $GameRoot "System\$name")}
RequireFile (Join-Path $GameRoot 'Maps\Lev_Tut1.unr')
foreach($name in 'Common\D3D11Drv.int','Common\Effects11.dll','Harry Potter 1\d3d11drv.dll','Harry Potter 1\tessellation.cfg','Common\d3d11drv\firstpass.fco'){RequireFile (Join-Path $RendererRoot $name)}
if($TexturePackRoot -and !(Test-Path -LiteralPath (Join-Path $TexturePackRoot 'Textures'))){throw 'Texture pack must contain its Textures folder; select the extracted pack root.'}
foreach($source in @($GameRoot,$RendererRoot,$TexturePackRoot,$MenuAddonRoot)+$GameModRoots){if($source){
 $script:SetupOperation="Scan linked files: $source";Write-SetupLog DETAIL $script:SetupOperation
 if((Get-Item -LiteralPath $source).Attributes -band [IO.FileAttributes]::ReparsePoint){throw "Linked source folders are not supported: $source"}
 $linked=Get-ChildItem -LiteralPath $source -Recurse -Force | Where-Object {$_.Attributes -band [IO.FileAttributes]::ReparsePoint} | Select-Object -First 1
 if($linked){throw "Linked files/folders inside inputs are not supported: $($linked.FullName)"}
}}
if($MenuLanguage){if(!$MenuAddonRoot){throw 'MenuLanguage also requires MenuAddonRoot.'};if([IO.Path]::GetFileName($MenuLanguage) -ne $MenuLanguage -or $MenuLanguage -eq '..'){throw 'MenuLanguage must be one addon folder name.'};if(!(Test-Path -LiteralPath (Join-Path $MenuAddonRoot "$MenuLanguage\Textures"))){throw 'Requested menu language is not in the supplied addon.'}}
foreach($mod in $GameModRoots){if(!(@('System','Maps','Textures','Sounds','Music')|Where-Object {Test-Path -LiteralPath (Join-Path $mod $_)})){throw "Game mod has no supported game folder layout: $mod"}}
Set-SetupStage 'Mod package integrity'
$manifest=Read-SetupJson (Join-Path $kit 'package-manifest.json')
Write-SetupLog INFO "Release=$($manifest.version) files=$($manifest.files.Count)"
foreach($f in $manifest.files){$path=Join-Path $kit $f.path;if(!(Under $path $kit)){throw "Invalid package manifest path: $($f.path)"};RequireFile $path;Test-SetupHash $path $f.sha256 "Package file damaged or changed: $($f.path)"}
Set-SetupStage 'Original game compatibility'
$supported=Read-SetupJson (Join-Path $kit 'supported-inputs.json')
foreach($f in $supported.game){
 $path=Join-Path $GameRoot ('System\'+$f.name)
 # Account for supplied mods in order: later overlays win, as on installation.
 foreach($mod in $GameModRoots){$overlay=Join-Path $mod ('System\'+$f.name);if(Test-Path -LiteralPath $overlay){$path=$overlay}}
 Test-SetupHash $path $f.sha256 "Unsupported engine/script build: $($f.name). This VR build uses verified native hooks; refusing an untested combination."
}
Set-SetupStage 'Renderer 1.6.2 integrity'
Test-SetupHash (Join-Path $RendererRoot 'Harry Potter 1\d3d11drv.dll') $supported.renderer.sha256 'This installer expects the HP1 DX11 renderer 1.6.2, not a renderer DLL for another game/version.'
$rendererFiles=Read-SetupJson (Join-Path $kit 'renderer-files.json')
foreach($f in $rendererFiles){$path=Join-Path $RendererRoot $f.path;if(!(Under $path $RendererRoot)){throw "Invalid renderer path: $($f.path)"};RequireFile $path;Test-SetupHash $path $f.sha256 "Renderer 1.6.2 component mismatch: $($f.path)"}
Set-SetupStage 'ESRGAN v3 integrity'
if($TexturePackRoot){foreach($f in $supported.textures){$path=Join-Path $TexturePackRoot $f.path;RequireFile $path;Test-SetupHash $path $f.sha256 "Texture pack version/file mismatch: $($f.path). Use the supported ESRGAN v3 pack, or explicitly choose the fallback."}}else{Write-SetupLog WARN 'Original-texture fallback selected explicitly; no ESRGAN pack verified.'}
Set-SetupStage 'Microsoft runtime prerequisites'
foreach($dll in 'msvcr100.dll','msvcp100.dll','d3dx11_43.dll','d3dcompiler_43.dll'){
 if(!(Test-Path -LiteralPath (Join-Path $env:WINDIR "SysWOW64\$dll"))){throw "Missing x86 runtime $dll. Use the VC++ 2010 SP1 x86 and DirectX June 2010 download buttons, install them, then retry."}
 Write-SetupLog INFO "Runtime present: $dll version=$((Get-Item -LiteralPath (Join-Path $env:WINDIR "SysWOW64\$dll")).VersionInfo.FileVersion)"
}
Write-Host 'Inputs and mod package verified. Original game and mod source folders will remain unchanged.'
if($ValidateOnly){Write-SetupLog SUCCESS "Validation complete. checked=$script:SetupChecked elapsedSeconds=$($script:SetupClock.Elapsed.TotalSeconds). Destination not created; permissions/free space for copying are not guaranteed by validation.";return}
$runtime=Join-Path $Destination 'Runtime'
$origins=@{}
function PutFile([string]$source,[string]$relative,[string]$kind){
 $target=Join-Path $runtime $relative
 if(!(Under $target $runtime)){throw "Unsafe destination: $relative"}
 Write-SetupLog DETAIL "Origin=$kind relative=$relative"
 $hash=Copy-SetupFile $source $target
 $origins[$relative]=[ordered]@{path=$relative;source=[IO.Path]::GetFullPath($source);origin=$kind;sha256=$hash}
}
function PutTree([string]$source,[string]$relative,[string]$kind,[switch]$GameFiles){
 if(!(Test-Path -LiteralPath $source)){Write-SetupLog WARN "Optional source tree absent: $source";return}
 $script:SetupOperation="Enumerate source tree: $source";Write-SetupLog DETAIL $script:SetupOperation
 $root=Full $source
 foreach($f in Get-ChildItem -LiteralPath $root -Recurse -File){
  if($f.Attributes -band [IO.FileAttributes]::ReparsePoint){throw "Linked/reparse source file is not supported: $($f.FullName)"}
  $tail=$f.FullName.Substring($root.Length).TrimStart('\','/')
  if(!(Include-PlayFile (Join-Path $relative $tail))){$script:SetupSkipped++;Write-SetupLog DETAIL "SKIP release policy: $($f.FullName)";continue}
  if($GameFiles -and ($f.Extension -in '.usa' -or $f.Name -match '^(HP1VR|VRUser|Probe|StereoV\d|GameSaveInfo)')){$script:SetupSkipped++;Write-SetupLog DETAIL "SKIP personal/old-mod file: $($f.FullName)";continue}
  PutFile $f.FullName (Join-Path $relative $tail) $kind
 }
}
Set-SetupStage 'Create destination'
$script:SetupOperation="Create destination folders under $Destination"
New-Item -ItemType Directory -Path $Destination,$runtime,(Join-Path $runtime 'Save'),(Join-Path $runtime 'Cache'),(Join-Path $runtime 'VR') -Force | Out-Null
Set-SetupStage 'Copy original game and overlays'
foreach($dir in 'System','Maps','Textures','Sounds','Music'){PutTree (Join-Path $GameRoot $dir) $dir 'user-game' -GameFiles}
foreach($mod in $GameModRoots){foreach($dir in 'System','Maps','Textures','Sounds','Music'){PutTree (Join-Path $mod $dir) $dir ('user-game-mod:'+ (Split-Path $mod -Leaf)) -GameFiles}}
# Follow renderer readme layout, without deleting anything in the supplied game.
Set-SetupStage 'Copy renderer'
PutFile (Join-Path $RendererRoot 'Common\D3D11Drv.int') 'System\D3D11Drv.int' 'user-dx11-renderer'
PutFile (Join-Path $RendererRoot 'Common\Effects11.dll') 'System\Effects11.dll' 'user-dx11-renderer'
PutFile (Join-Path $RendererRoot 'Harry Potter 1\d3d11drv.dll') 'System\d3d11drv.dll' 'user-dx11-renderer'
PutFile (Join-Path $RendererRoot 'Harry Potter 1\tessellation.cfg') 'System\tessellation.cfg' 'user-dx11-renderer'
PutTree (Join-Path $RendererRoot 'Common\d3d11drv') 'System\d3d11drv' 'user-dx11-renderer'
Set-SetupStage 'Copy texture pack and optional menu'
if($TexturePackRoot){PutTree (Join-Path $TexturePackRoot 'Textures') 'Textures' 'user-esrgan-textures';PutTree (Join-Path $TexturePackRoot 'System') 'System' 'user-esrgan-settings' -GameFiles}
if($MenuLanguage){PutTree (Join-Path $MenuAddonRoot "$MenuLanguage\Textures") 'Textures' ('user-menu-addon:'+ $MenuLanguage)}
# Our VR overrides are last. No original package is altered by the water fix.
Set-SetupStage 'Copy V31 mod and configuration'
PutTree (Join-Path $kit 'payload\System') 'System' 'vr-mod'
PutTree (Join-Path $kit 'payload\VR') 'VR' 'vr-mod'
PutFile (Join-Path $kit 'config\StereoV31VR.ini') 'System\StereoV31VR.ini' 'vr-mod-config'
PutFile (Join-Path $kit 'config\VRUser.ini') 'System\VRUser.ini' 'vr-mod-controls'
[void](Copy-SetupFile (Join-Path $kit 'Launch-HP1-VR-V31.exe') (Join-Path $Destination 'Launch-HP1-VR-V31.exe'))
[void](Copy-SetupFile (Join-Path $kit 'config\HP1VR-V31.ini') (Join-Path $Destination 'HP1VR-V31.ini'))
Set-SetupStage 'Copy documentation'
[void](Copy-SetupFile (Join-Path $kit 'README.md') (Join-Path $Destination 'START HERE.md'))
Get-ChildItem -LiteralPath $kit -Filter '*.md' -File | ForEach-Object { [void](Copy-SetupFile $_.FullName (Join-Path $Destination $_.Name)) }
[void](Copy-SetupFile (Join-Path $kit 'OPENVR-LICENSE.txt') (Join-Path $Destination 'OPENVR-LICENSE.txt'))
Set-SetupStage 'Write installation record'
$record=[ordered]@{schema=1;installedUtc=[DateTime]::UtcNow.ToString('o');gameSource=$GameRoot;rendererSource=$RendererRoot;textureSource=$TexturePackRoot;menuSource=$MenuAddonRoot;menuLanguage=$MenuLanguage;gameModSources=$GameModRoots;files=@($origins.Values|Sort-Object path)}
$script:SetupOperation="Write installation record: $Destination/installation-manifest.json"
[IO.File]::WriteAllText((Join-Path $Destination 'installation-manifest.json'),($record|ConvertTo-Json -Depth 7))
$dds=@(Get-ChildItem -LiteralPath (Join-Path $runtime 'Textures') -Recurse -File -Filter '*.dds').Count
Write-Host "Installed: $Destination"
Write-Host "User-supplied DDS replacements: $dds. Saves are local to Runtime\Save. Launch-HP1-VR-V31.exe starts VR."
Write-Host 'This installed folder contains your game/mod files: keep it private. Share the original mod-only ZIP instead.'
Write-SetupLog SUCCESS "Installed=$Destination DDS=$dds copied=$script:SetupCopied skipped=$script:SetupSkipped checked=$script:SetupChecked bytes=$script:SetupBytes elapsedSeconds=$($script:SetupClock.Elapsed.TotalSeconds)"
} catch {
 $failure=$_
 try {Write-Host (Write-SetupFailure $failure)}catch{Write-Host "Could not finish diagnostic log: $($_.Exception.Message). Original error: $($failure.Exception.ToString())"}
 throw $failure
} finally {Write-Host "Installer log: $script:SetupLog"}
