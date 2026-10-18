$ErrorActionPreference='Stop'
$manifest=Get-Content -LiteralPath (Join-Path $PSScriptRoot 'package-manifest.json') -Raw | ConvertFrom-Json
$files=@(Get-ChildItem -LiteralPath $PSScriptRoot -Recurse -File)
foreach($f in $manifest.files){
 if($f.path -match '(^|[\\/])\.\.([\\/]|$)' -or [IO.Path]::IsPathRooted($f.path)){throw "Unsafe manifest path: $($f.path)"}
 $path=Join-Path $PSScriptRoot $f.path
 if(!(Test-Path -LiteralPath $path -PathType Leaf) -or (Get-FileHash -LiteralPath $path).Hash -ne $f.sha256){throw "Package mismatch: $($f.path)"}
}
if($files.Count -ne $manifest.files.Count+1){throw 'Unexpected unlisted files in release'}
$blocked=@($files | Where-Object {$_.Extension -in '.u','.utx','.unr','.uax','.umx','.dds','.usa','.sav','.log','.fco','.fxh' -or $_.Name -in 'Game.exe','HP.exe','Core.dll','Engine.dll','WinDrv.dll','Galaxy.dll','Fire.dll','D3D11Drv.dll','Effects11.dll','dgVoodooCpl.exe','DDraw.dll','D3DImm.dll'})
if($blocked.Count){throw ('Do not publish base-game/dependency/private files: '+($blocked.FullName -join ', '))}
$actions=Get-Content -LiteralPath (Join-Path $PSScriptRoot 'payload/VR/actions_v31.json') -Raw|ConvertFrom-Json
foreach($binding in $actions.default_bindings){$b=Get-Content -LiteralPath (Join-Path $PSScriptRoot ('payload/VR/'+$binding.binding_url)) -Raw|ConvertFrom-Json;if($b.controller_type -ne $binding.controller_type){throw 'Controller binding mismatch'}}
Write-Output "PASS: $($manifest.files.Count) files verified, controller profiles valid, no excluded game/renderer/HD/save files. Licensed OpenVR DLLs and retained mod assets included."
