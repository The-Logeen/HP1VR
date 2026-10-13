$ErrorActionPreference='Stop'
try {
 . (Join-Path $PSScriptRoot 'LogSupport.ps1')
 Initialize-SetupLog '' 'startup' $PSScriptRoot
 $startupLog=$script:SetupLog
 Set-SetupStage 'GUI startup'
 & (Join-Path $PSScriptRoot 'Setup.ps1')
 Write-SetupLog INFO 'Installer window closed normally.'
 exit 0
} catch {
 $failure=$_
 try {$message=Write-SetupFailure $failure} catch {$message="Installer could not start: $($failure.Exception.ToString())`r`nLogging also failed: $($_.Exception.Message)`r`nSee the Install.cmd launcher log."}
 Write-Host $message
 try {Add-Type -AssemblyName System.Windows.Forms;[void][Windows.Forms.MessageBox]::Show($message,'HP1 VR V31 setup failed')}catch{Write-Host 'Could not display the error window; read this launcher log.'}
 exit 1
}
