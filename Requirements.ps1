# Read-only checks for the GUI. Install.ps1 repeats authoritative validation.
. (Join-Path $PSScriptRoot 'SetupPaths.ps1')
function Get-HP1Requirements([hashtable]$Values,[bool]$OriginalTextures){
 $ErrorActionPreference='Stop'
 $supported=Get-Content -LiteralPath (Join-Path $PSScriptRoot 'supported-inputs.json') -Raw | ConvertFrom-Json
 function CheckHash([string]$Path,[string]$Hash){
  if(!(Test-Path -LiteralPath $Path -PathType Leaf)){throw "Missing file: $Path"}
  $actual=(Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash
  if($actual -ne $Hash){throw "Wrong version: $Path`r`nExpected SHA256: $Hash`r`nActual SHA256: $actual"}
 }
 foreach($component in 'HP1 game','HP1 renderer','HD textures','VC++ 2010 x86','Legacy DirectX','SteamVR','Destination'){
  $status='Ready';$detail='';$help=''
  try {
   switch($component){
    'HP1 game' {
     $root=Clean-SetupPath $Values.GameRoot
     if(!$root){throw 'Select the extracted/installed game folder containing System and Maps.'}
     foreach($f in $supported.game){CheckHash (Join-Path $root ('System\'+$f.name)) $f.sha256}
     if(!(Test-Path -LiteralPath (Join-Path $root 'Maps\Lev_Tut1.unr'))){throw 'Maps\Lev_Tut1.unr missing: this is not the complete game root.'}
     $detail="Verified engine/scripts: $root"
    }
    'HP1 renderer' {
     $root=Clean-SetupPath $Values.RendererRoot
     if(!$root){throw 'Select HP1 DX11 renderer 1.6.2 extracted folder. HP2 renderer is not interchangeable.'}
     foreach($f in (Get-Content -LiteralPath (Join-Path $PSScriptRoot 'renderer-files.json') -Raw | ConvertFrom-Json)){CheckHash (Resolve-HP1Renderer $root $f.path) $f.sha256}
     $detail='All required renderer and shader hashes match. '+(Resolve-HP1Renderer $root 'Harry Potter 1/d3d11drv.dll')
    }
    'HD textures' {
     $root=Clean-SetupPath $Values.TexturePackRoot
     if($OriginalTextures){$status='Optional';$detail='Original textures explicitly selected; ESRGAN will not be copied.'}
     else {
      if(!$root){throw 'Select extracted HP1 ESRGAN v3, or explicitly check Use original textures.'}
      if((Split-Path $root -Leaf) -eq 'Textures'){$root=Split-Path $root -Parent}
      foreach($f in $supported.textures){CheckHash (Join-Path $root $f.path) $f.sha256}
      $detail="ESRGAN v3 checks passed: $root"
     }
    }
    'VC++ 2010 x86' {
     foreach($dll in 'msvcr100.dll','msvcp100.dll'){if(!(Test-Path -LiteralPath (Join-Path $env:WINDIR "SysWOW64\$dll"))){throw "Missing x86 $dll. Download VC++ 2010 SP1 x86 using the button, RUN vcredist_x86.exe, then retry. x64 alone is insufficient."}}
     $detail='32-bit runtime files present; not a complete runtime-health test.'
    }
    'Legacy DirectX' {
     foreach($dll in 'd3dx11_43.dll','d3dcompiler_43.dll'){if(!(Test-Path -LiteralPath (Join-Path $env:WINDIR "SysWOW64\$dll"))){throw "Missing $dll. Download June 2010 runtime, run it to EXTRACT to a temporary folder, then RUN DXSETUP.exe there."}}
     $detail='Legacy 32-bit files present; not a complete runtime-health test.'
    }
    'SteamVR' {$status='Check manually';$detail='Connect headset and both controllers; verify SteamVR works before launching. Alternate Steam libraries are supported; no default-path assumption. OpenVR DLLs are included with their license.'}
    'Destination' {
     $root=Clean-SetupPath $Values.Destination;if(!$root){throw 'Choose a NEW installation folder, separate from the game, dependencies and package.'}
     if((Test-Path -LiteralPath $root) -and @(Get-ChildItem -LiteralPath $root -Force).Count){throw 'Destination is not empty. Choose a new folder; do not delete your game or saves.'}
     $detail="New/empty destination: $root. Full validation checks overlap; copy stage checks actual writes."
    }
   }
  } catch {$status='Needs attention';$detail=$_.Exception.Message}
  switch($component){
   'HP1 game' {$help='Use the complete compatible 2001 PC game. Tested source: HP1 MagiPack from MyAbandonware (not the HP2 MagiPack). Select parent of System and Maps, not System itself. No game files/download are included. Hash mismatch is not fixed by renaming.'}
   'HP1 renderer' {$help='Download HP1 renderer 1.6.2 using its button; extract the whole ZIP. Keep Common and Harry Potter 1 together. Select their parent. Compatible Common, Harry Potter 1, System or installed layouts are resolved automatically; exact file hashes are still required. Do not use HP2 files.'}
   'HD textures' {$help='Download HP1 ESRGAN v3 using its button and extract the whole pack. Choose parent containing Textures and System (or its Textures folder). Do not flatten subfolders or select HP2 textures. Original-texture fallback is available explicitly.'}
   default {$help='See Full instructions for click-by-click steps. Double-click other rows for component-specific instructions. Installation rechecks files before copying; input folders remain untouched.'}
  }
  [pscustomobject]@{Component=$component;Status=$status;Details=$detail;Help=$help}
 }
}
