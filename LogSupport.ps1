# Shared by the GUI, bootstrap and CLI. No telemetry or automatic upload.
function New-SetupLogPath([string]$Kind='install') {
 $failures=@()
 foreach($base in @([Environment]::GetFolderPath('LocalApplicationData'),[IO.Path]::GetTempPath())) {
  if(!$base){continue}
  try {
   $dir=Join-Path $base 'HP1VR/InstallerLogs'
   New-Item -ItemType Directory -Path $dir -Force -ErrorAction Stop|Out-Null
   $path=Join-Path $dir ("V31-$Kind-"+[DateTime]::UtcNow.ToString('yyyyMMdd-HHmmss')+'-'+[guid]::NewGuid().ToString('N').Substring(0,8)+'.log')
   [IO.File]::WriteAllText($path,"HP1 VR V31 installer log; UTC timestamps. Contains local file paths. Review before sharing.`r`n")
   return $path
  } catch {$failures+=$_.Exception.Message}
 }
 throw ('Cannot create an installer log in LocalAppData or TEMP. Check free space and folder permissions. '+($failures -join ' | '))
}
function Initialize-SetupLog([string]$Path,[string]$Mode,[string]$Kit) {
 if(!$Path){$Path=New-SetupLogPath $Mode}
 $script:SetupLog=[IO.Path]::GetFullPath($Path)
 $script:SetupStage='startup';$script:SetupOperation='initialization';$script:SetupClock=[Diagnostics.Stopwatch]::StartNew()
 $script:SetupCopied=0;$script:SetupChecked=0;$script:SetupSkipped=0;$script:SetupBytes=[long]0
 New-Item -ItemType Directory -Path (Split-Path $script:SetupLog) -Force -ErrorAction Stop|Out-Null
 Write-SetupLog INFO "BEGIN mode=$Mode kit=$Kit"
 Write-SetupLog INFO "OS=$([Environment]::OSVersion.VersionString) OS64=$([Environment]::Is64BitOperatingSystem) process64=$([Environment]::Is64BitProcess) PowerShell=$($PSVersionTable.PSVersion) language=$($ExecutionContext.SessionState.LanguageMode) CLR=$([Environment]::Version)"
 Write-SetupLog INFO "CurrentDirectory=$((Get-Location).Path) Log=$script:SetupLog"
}
function Write-SetupLog([string]$Level,[string]$Message) {
 $line='[{0}] [{1}] [{2}] {3}' -f [DateTime]::UtcNow.ToString('o'),$Level,$script:SetupStage,$Message
 try {[IO.File]::AppendAllText($script:SetupLog,$line+"`r`n",[Text.UTF8Encoding]::new($false))}
 catch {throw "Cannot write installer log '$script:SetupLog': $($_.Exception.Message). Original event: $line"}
}
function Set-SetupStage([string]$Name) {
 $script:SetupStage=$Name;$script:SetupOperation=$Name
 Write-SetupLog STAGE $Name
 Write-Host "[$Name] Log: $script:SetupLog"
}
function Read-SetupJson([string]$Path) {
 $script:SetupOperation="Read JSON: $Path";Write-SetupLog DETAIL $script:SetupOperation
 $value=Get-Content -LiteralPath $Path -Raw -Encoding UTF8 -ErrorAction Stop|ConvertFrom-Json -ErrorAction Stop
 if($null -eq $value){throw "Empty JSON record: $Path"};return $value
}
function Test-SetupHash([string]$Path,[string]$Expected,[string]$Description) {
 $script:SetupOperation="SHA256: $Path";Write-SetupLog DETAIL "BEGIN hash path=$Path expected=$Expected"
 $watch=[Diagnostics.Stopwatch]::StartNew()
 $actual=(Get-FileHash -LiteralPath $Path -Algorithm SHA256 -ErrorAction Stop).Hash
 Write-SetupLog DETAIL "END hash path=$Path actual=$actual expected=$Expected elapsedMs=$($watch.ElapsedMilliseconds)"
 if($actual -ne $Expected){throw "$Description`nFile: $Path`nExpected SHA256: $Expected`nActual SHA256: $actual"}
 $script:SetupChecked++
}
function Copy-SetupFile([string]$Source,[string]$Target) {
 $script:SetupOperation="Copy: $Source -> $Target";Write-SetupLog DETAIL "BEGIN $script:SetupOperation"
 $watch=[Diagnostics.Stopwatch]::StartNew()
 New-Item -ItemType Directory -Path (Split-Path $Target) -Force -ErrorAction Stop|Out-Null
 $before=(Get-FileHash -LiteralPath $Source -Algorithm SHA256 -ErrorAction Stop).Hash
 Copy-Item -LiteralPath $Source -Destination $Target -Force -ErrorAction Stop
 $after=(Get-FileHash -LiteralPath $Target -Algorithm SHA256 -ErrorAction Stop).Hash
 if($before -ne $after){throw "Copied file checksum mismatch: $Target`nSource: $Source`nExpected SHA256: $before`nActual SHA256: $after"}
 $bytes=(Get-Item -LiteralPath $Target).Length;$script:SetupCopied++;$script:SetupBytes+=$bytes
 Write-SetupLog DETAIL "END copy source=$Source target=$Target bytes=$bytes sha256=$after elapsedMs=$($watch.ElapsedMilliseconds) count=$script:SetupCopied"
 return $after
}
function Get-SetupFailureAdvice([string]$Message) {
 switch -Regex ($Message) {
  'not empty' {return 'E_DEST_NOT_EMPTY | Choose a NEW/EMPTY output folder. Do not delete an existing game or saves to make room.'}
  'separate|overlap|Unsafe destination|Invalid .*path' {return 'E_PATH_LAYOUT | Keep kit, game, dependency folders and destination separate; do not nest the destination inside any input.'}
  'Unsupported engine/script' {return 'E_GAME_VERSION | This game/script revision is not supported. Send the named file and expected/actual hashes; do not bypass validation.'}
  'Renderer 1.6.2 component mismatch|expects the HP1 DX11 renderer' {return 'E_RENDERER | Extract the exact HP1 DX11 1.6.2 archive. Select its parent containing Common and Harry Potter 1, not a subfolder or another-game DLL.'}
  'Texture pack (version/file mismatch|must contain)' {return 'E_TEXTURE_PACK | Fully extract the supported ESRGAN v3 archive. Select the folder containing System and Textures; inspect the named missing/mismatched file.'}
  'Package file|package.manifest|Empty JSON|JSON|ConvertFrom-Json' {return 'E_PACKAGE | Re-extract a complete matching mod release. Do not mix versions or edit hashed files. Preserve this log.'}
  'Missing x86 runtime' {return 'E_PREREQUISITE | Install official VC++ 2010 SP1 x86 and DirectX June 2010 (run DXSETUP after extraction); never download individual DLLs from random sites.'}
  'Linked|reparse' {return 'E_LINKED_INPUT | Use ordinary local extracted folders rather than junctions, symlinks or cloud placeholders. The log names the rejected path.'}
  'denied|UnauthorizedAccess|permission|read.only' {return 'E_ACCESS | Choose a writable local destination. Check permissions or security-software protection history; do not disable antivirus globally.'}
  'space|disk full|0x80070070' {return 'E_DISK_SPACE | Free space on the named destination/log drive, then retry into another empty destination. Partial output is retained.'}
  'being used|sharing violation|0x80070020' {return 'E_FILE_LOCK | Close the application using the named file (including HP1/its launcher), then retry. No processes are force-closed.'}
  'too long|PathTooLong' {return 'E_PATH_LENGTH | Extract inputs and choose output under shorter paths, e.g. D:\HP1VR. Keep folders separate.'}
  'Required file missing|Source folder missing|cannot find|Could not find|does not exist' {return 'E_MISSING_FILE | Check the exact path below. Select extracted parent folders, check nested extraction and security-software quarantine, and re-extract incomplete downloads.'}
  'PowerShell|64.bit|ConstrainedLanguage|language mode' {return 'E_HOST | Use Windows PowerShell 5.1 on 64-bit Windows through Install.cmd. Ask the device administrator about execution restrictions; do not bypass managed security policy.'}
  default {return 'E_UNEXPECTED | Preserve the complete log and reproduction steps. Inspect the failing operation and underlying exception below; no specific cause has been established.'}
 }
}
function Write-SetupFailure($Record) {
 $detail=($Record|Format-List * -Force|Out-String -Width 300)+"`r`n"+$Record.Exception.ToString()
 $advice=Get-SetupFailureAdvice ($Record.Exception.ToString())
 Write-SetupLog ERROR "FAILED operation=$script:SetupOperation elapsedSeconds=$([math]::Round($script:SetupClock.Elapsed.TotalSeconds,2)) copied=$script:SetupCopied checked=$script:SetupChecked bytes=$script:SetupBytes"
 Write-SetupLog ERROR $advice
 Write-SetupLog ERROR "ExceptionType=$($Record.Exception.GetType().FullName) HResult=$($Record.Exception.HResult) ErrorId=$($Record.FullyQualifiedErrorId) Category=$($Record.CategoryInfo) Target=$($Record.TargetObject)"
 Write-SetupLog ERROR "$detail`r`nScriptStackTrace: $($Record.ScriptStackTrace)"
 Write-SetupLog ERROR 'Original inputs are not edited. If copying started, partial destination files remain; use a new empty destination on retry. No automatic cleanup or upload.'
 return "FAILED [$script:SetupStage]`r`n$advice`r`n$($Record.Exception.Message)`r`nOperation: $script:SetupOperation`r`nFull log: $script:SetupLog"
}
