function Clean-SetupPath([string]$Path){if(!$Path){return ''};return $Path.Trim().Trim('"').Trim()}
function Resolve-HP1Renderer([string]$Root,[string]$Relative){
 $Root=Clean-SetupPath $Root
 $tail=$Relative -replace '^(Common|Harry Potter 1)[\\/]',''
 $candidates=@((Join-Path $Root $Relative),(Join-Path $Root ('System\'+$tail)),(Join-Path $Root $tail))
 $parent=Split-Path $Root -Parent
 if($parent){$candidates+=Join-Path $parent $Relative;$candidates+=Join-Path $parent ('System\'+$tail)}
 foreach($candidate in $candidates){if(Test-Path -LiteralPath $candidate -PathType Leaf){return $candidate}}
 throw "Renderer file missing: $Relative. Searched: $($candidates -join ' | '). Download HP1 DX11 1.6.2, extract ALL files, and select the parent containing Common and Harry Potter 1. See SETUP-GUIDE.html."
}
