function Include-PlayFile([string]$relative,[bool]$includeSaves=$false){
 $r=$relative.Replace('\','/');$leaf=[IO.Path]::GetFileName($r);$ext=[IO.Path]::GetExtension($r).ToLowerInvariant()
 if($r -match '(^|/)(Cache|wavs|wavs_extracted)(/|$)'){return $false}
 if($r -match '^Save/'){return $includeSaves}
 if($ext -in '.log','.zip','.7z','.bak','.tmp','.bmp','.obj','.pdb','.lib','.lnk'){return $false}
 if($leaf -match '^(broom-steering-bytecode|lesson-data|native-gesture-points|native-spell-defaults|player-fields|scene-options-dump|spell-bytecode)\.txt$'){return $false}
 if($leaf -in 'dgVoodooCpl.exe','dgVoodoo.conf','D3D8.dll','D3D9.dll','D3DImm.dll','DDraw.dll'){return $false}
 return $true
}
