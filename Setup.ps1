
$ErrorActionPreference='Stop'
. (Join-Path $PSScriptRoot 'LogSupport.ps1')
Initialize-SetupLog '' 'gui' $PSScriptRoot
Add-Type -AssemblyName System.Windows.Forms,System.Drawing
[Windows.Forms.Application]::EnableVisualStyles()
$script:kit=$PSScriptRoot;$script:job=$null
$form=New-Object Windows.Forms.Form
$form.Text='HP1 VR V31 - Install into a separate folder';$form.ClientSize=New-Object Drawing.Size(880,810)
$form.StartPosition='CenterScreen';$form.Font=New-Object Drawing.Font('Segoe UI',10)
$form.FormBorderStyle='FixedDialog';$form.MaximizeBox=$false
function Label($text,$x,$y,$w,$h){$c=New-Object Windows.Forms.Label;$c.Text=$text;$c.SetBounds($x,$y,$w,$h);$form.Controls.Add($c)}
Label 'HP1 VR V31 | Final mod setup' 22 18 820 35
Label '1. Get and extract the exact dependencies.  2. Select folders.  3. Verify, then install.' 22 56 830 28
$links=Read-SetupJson (Join-Path $kit 'DEPENDENCIES.json')
for($i=0;$i -lt $links.Count;$i++){
 $button=New-Object Windows.Forms.Button;$button.Text=$links[$i].label;$button.Tag=$links[$i].url
 $button.SetBounds((22+($i%3)*280),(90+[math]::Floor($i/3)*40),270,34)
 $button.Add_Click({try{Write-SetupLog INFO "Open dependency page: $($this.Tag)";Start-Process -FilePath $this.Tag}catch{Show-GuiFailure $_}})
 $form.Controls.Add($button)
}
$script:boxes=@{};$labels=@('Your compatible HP1 game folder','Extracted HP1 renderer 1.6.2 folder','Extracted ESRGAN v3 folder','New / empty installation folder')
$keys=@('GameRoot','RendererRoot','TexturePackRoot','Destination')
for($i=0;$i -lt 4;$i++){
 $y=184+$i*65;Label $labels[$i] 22 $y 810 23
 $box=New-Object Windows.Forms.TextBox;$box.SetBounds(22,($y+24),734,27);$script:boxes[$keys[$i]]=$box;$form.Controls.Add($box)
 $button=New-Object Windows.Forms.Button;$button.Text='Browse';$button.Tag=$keys[$i];$button.SetBounds(766,($y+23),92,29)
 $button.Add_Click({try{$dialog=New-Object Windows.Forms.FolderBrowserDialog;$dialog.Description='Select folder (not an archive)';if($dialog.ShowDialog() -eq 'OK'){$script:boxes[$this.Tag].Text=$dialog.SelectedPath};$dialog.Dispose()}catch{Show-GuiFailure $_}});$form.Controls.Add($button)
}
$script:boxes.Destination.Text=Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'HP1 VR V31 Installed'
Label 'No game files are downloaded. Sources are read-only. Existing destinations are never overwritten.' 22 450 840 25
$verify=New-Object Windows.Forms.Button;$verify.Text='Verify inputs';$verify.SetBounds(22,484,190,38);$form.Controls.Add($verify)
$install=New-Object Windows.Forms.Button;$install.Text='Install V31';$install.SetBounds(226,484,190,38);$form.Controls.Add($install)
$readme=New-Object Windows.Forms.Button;$readme.Text='Full instructions';$readme.SetBounds(430,484,190,38);$form.Controls.Add($readme)
$readme.Add_Click({try{Start-Process notepad.exe -ArgumentList ('"'+(Join-Path $script:kit 'README.md')+'"')}catch{Show-GuiFailure $_}})
$script:status=New-Object Windows.Forms.TextBox;$script:status.Multiline=$true;$script:status.ReadOnly=$true;$script:status.ScrollBars='Vertical';$script:status.SetBounds(22,538,836,160);$form.Controls.Add($script:status)
$script:status.Text='Download buttons open version-specific pages in your browser. Install Microsoft runtimes yourself, then return here. No automatic game or SteamVR launch.'
$script:currentLog=$script:SetupLog;$script:lastResult='';$script:lastTail=''
$logPathBox=New-Object Windows.Forms.TextBox;$logPathBox.ReadOnly=$true;$logPathBox.SetBounds(22,710,836,25);$logPathBox.Text=$script:currentLog;$form.Controls.Add($logPathBox)
$openLog=New-Object Windows.Forms.Button;$openLog.Text='Open full log';$openLog.SetBounds(22,750,190,35);$form.Controls.Add($openLog)
$openLog.Add_Click({try{Start-Process notepad.exe -ArgumentList ('"'+$script:currentLog+'"')}catch{Show-GuiFailure $_}})
$copyError=New-Object Windows.Forms.Button;$copyError.Text='Copy result details';$copyError.SetBounds(226,750,190,35);$form.Controls.Add($copyError)
$copyError.Add_Click({try{[Windows.Forms.Clipboard]::SetText($script:lastResult+"`r`nFull log: "+$script:currentLog)}catch{Show-GuiFailure $_}})
Label 'Logs contain local paths. Review before sharing. No automatic upload.' 430 753 430 35
function Show-GuiFailure($record){
 try {$message=Write-SetupFailure $record}catch{$message=$record.Exception.ToString()+"`r`nLogging error: "+$_.Exception.Message}
 try{if($script:currentLog -and $script:currentLog -ne $script:SetupLog){[IO.File]::AppendAllText($script:currentLog,"`r`nGUI/WORKER INFRASTRUCTURE FAILURE`r`n"+$message+"`r`n")}}catch{$message+="`r`nCould not append to operation log: "+$_.Exception.Message}
 $script:lastResult=$message;$script:status.Text=$message
 [void][Windows.Forms.MessageBox]::Show($message,'HP1 VR V31 setup error')
}
function Begin-Install([bool]$validate){
 if($script:job){return}
 try {
  $values=@{};foreach($key in $keys){$values[$key]=$script:boxes[$key].Text.Trim();if(!$values[$key]){throw "Missing folder selection: $key. Select all four extracted/output folders before continuing."}}
  $script:currentLog=New-SetupLogPath $(if($validate){'verify'}else{'install'});$logPathBox.Text=$script:currentLog
  $script:status.Text="Starting validation. Detailed live output appears below.`r`nLog: $script:currentLog";$script:lastTail='';$script:lastResult='Operation running.';$verify.Enabled=$install.Enabled=$false
  $script:SetupOperation="Start PowerShell worker; validate=$validate operationLog=$script:currentLog"
  Write-SetupLog INFO $script:SetupOperation
  $script:job=Start-Job -ScriptBlock {param($root,$values,$validate,$log) $ErrorActionPreference='Stop'; try{& (Join-Path $root 'Install.ps1') @values -ValidateOnly:$validate -LogPath $log}catch{[IO.File]::AppendAllText($log,"`r`nWORKER FAILED: "+$_.Exception.ToString()+"`r`n"+($_|Format-List * -Force|Out-String -Width 300));throw}} -ArgumentList $script:kit,$values,$validate,$script:currentLog
  $timer.Start()
 }catch{$verify.Enabled=$install.Enabled=$true;Show-GuiFailure $_}
}
$verify.Add_Click({Begin-Install $true});$install.Add_Click({Begin-Install $false})
$timer=New-Object Windows.Forms.Timer;$timer.Interval=500
$timer.Add_Tick({
 if($script:job){
  try{$tail=(Get-Content -LiteralPath $script:currentLog -Tail 80 -Encoding UTF8 -ErrorAction Stop)|Out-String;if($tail -ne $script:lastTail){$script:lastTail=$tail;$script:status.Text=$tail;$script:status.SelectionStart=$script:status.TextLength;$script:status.ScrollToCaret()}}catch [IO.IOException] {} catch {Write-SetupLog WARN "Live log read failed: $($_.Exception.Message)"}
 }
 if($script:job -and $script:job.State -in 'Completed','Failed','Stopped'){
  $timer.Stop()
  try{
   $state=$script:job.State;$output=Receive-Job $script:job -ErrorAction Continue 2>&1|Out-String -Width 240
   $reason=$script:job.ChildJobs[0].JobStateInfo.Reason
   $script:lastResult="Worker state: $state`r`n$output";if($reason){$script:lastResult+="`r`nFAILED: "+$reason.ToString()}
   [IO.File]::AppendAllText($script:currentLog,"`r`nGUI WORKER SUMMARY`r`n"+$script:lastResult)
   $script:status.Text=$script:lastResult+"`r`nFull log: "+$script:currentLog
   if($state -ne 'Completed'){[void][Windows.Forms.MessageBox]::Show("Setup failed. Read the result below and use Open full log for the exact file, stage and exception.`r`n"+$script:currentLog,'HP1 VR V31 setup failed')}
  }catch{Show-GuiFailure $_}finally{Remove-Job $script:job -Force -ErrorAction SilentlyContinue;$script:job=$null;$verify.Enabled=$install.Enabled=$true}
 }
})
$form.Add_FormClosing({if($script:job){$_.Cancel=$true;[Windows.Forms.MessageBox]::Show('Please wait for the current operation to finish.','Installation running')}})
[void]$form.ShowDialog()
$timer.Dispose();$form.Dispose()
