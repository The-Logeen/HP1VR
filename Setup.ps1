
$ErrorActionPreference='Stop'
Add-Type -AssemblyName System.Windows.Forms,System.Drawing
[Windows.Forms.Application]::EnableVisualStyles()
$script:kit=$PSScriptRoot;$script:job=$null
$form=New-Object Windows.Forms.Form
$form.Text='HP1 VR V31 - Install into a separate folder';$form.ClientSize=New-Object Drawing.Size(880,720)
$form.StartPosition='CenterScreen';$form.Font=New-Object Drawing.Font('Segoe UI',10)
$form.FormBorderStyle='FixedDialog';$form.MaximizeBox=$false
function Label($text,$x,$y,$w,$h){$c=New-Object Windows.Forms.Label;$c.Text=$text;$c.SetBounds($x,$y,$w,$h);$form.Controls.Add($c)}
Label 'HP1 VR V31 | Final mod setup' 22 18 820 35
Label '1. Get and extract the exact dependencies.  2. Select folders.  3. Verify, then install.' 22 56 830 28
$links=Get-Content (Join-Path $kit 'DEPENDENCIES.json') -Raw|ConvertFrom-Json
for($i=0;$i -lt $links.Count;$i++){
 $button=New-Object Windows.Forms.Button;$button.Text=$links[$i].label;$button.Tag=$links[$i].url
 $button.SetBounds((22+($i%3)*280),(90+[math]::Floor($i/3)*40),270,34)
 $button.Add_Click({try{Start-Process -FilePath $this.Tag}catch{[Windows.Forms.MessageBox]::Show($_.Exception.Message,'Cannot open download page')}})
 $form.Controls.Add($button)
}
$script:boxes=@{};$labels=@('Your compatible HP1 game folder','Extracted HP1 renderer 1.6.2 folder','Extracted ESRGAN v3 folder','New / empty installation folder')
$keys=@('GameRoot','RendererRoot','TexturePackRoot','Destination')
for($i=0;$i -lt 4;$i++){
 $y=184+$i*65;Label $labels[$i] 22 $y 810 23
 $box=New-Object Windows.Forms.TextBox;$box.SetBounds(22,($y+24),734,27);$script:boxes[$keys[$i]]=$box;$form.Controls.Add($box)
 $button=New-Object Windows.Forms.Button;$button.Text='Browse';$button.Tag=$keys[$i];$button.SetBounds(766,($y+23),92,29)
 $button.Add_Click({$dialog=New-Object Windows.Forms.FolderBrowserDialog;$dialog.Description='Select folder (not an archive)';if($dialog.ShowDialog() -eq 'OK'){$script:boxes[$this.Tag].Text=$dialog.SelectedPath};$dialog.Dispose()});$form.Controls.Add($button)
}
$script:boxes.Destination.Text=Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'HP1 VR V31 Installed'
Label 'No game files are downloaded. Sources are read-only. Existing destinations are never overwritten.' 22 450 840 25
$verify=New-Object Windows.Forms.Button;$verify.Text='Verify inputs';$verify.SetBounds(22,484,190,38);$form.Controls.Add($verify)
$install=New-Object Windows.Forms.Button;$install.Text='Install V31';$install.SetBounds(226,484,190,38);$form.Controls.Add($install)
$readme=New-Object Windows.Forms.Button;$readme.Text='Full instructions';$readme.SetBounds(430,484,190,38);$form.Controls.Add($readme)
$readme.Add_Click({Start-Process notepad.exe -ArgumentList ('"'+(Join-Path $script:kit 'README.md')+'"')})
$script:status=New-Object Windows.Forms.TextBox;$script:status.Multiline=$true;$script:status.ReadOnly=$true;$script:status.ScrollBars='Vertical';$script:status.SetBounds(22,538,836,160);$form.Controls.Add($script:status)
$script:status.Text='Download buttons open version-specific pages in your browser. Install Microsoft runtimes yourself, then return here. No automatic game or SteamVR launch.'
function Begin-Install([bool]$validate){
 if($script:job){return}
 $values=@{};foreach($key in $keys){$values[$key]=$script:boxes[$key].Text.Trim();if(!$values[$key]){[Windows.Forms.MessageBox]::Show('Please select all four folders.','Missing folder');return}}
 $script:status.Text='Checking hashes and dependencies. This can take several minutes...';$verify.Enabled=$install.Enabled=$false
 $script:job=Start-Job -ScriptBlock {param($root,$values,$validate) $ErrorActionPreference='Stop'; & (Join-Path $root 'Install.ps1') @values -ValidateOnly:$validate} -ArgumentList $script:kit,$values,$validate
 $timer.Start()
}
$verify.Add_Click({Begin-Install $true});$install.Add_Click({Begin-Install $false})
$timer=New-Object Windows.Forms.Timer;$timer.Interval=300
$timer.Add_Tick({
 if($script:job -and $script:job.State -in 'Completed','Failed','Stopped'){
  $timer.Stop();$output=Receive-Job $script:job -ErrorAction Continue 2>&1|Out-String
  $reason=$script:job.ChildJobs[0].JobStateInfo.Reason
  $script:status.Text=$output;if($reason){$script:status.AppendText("`r`nFAILED: "+$reason.Message)}
  Remove-Job $script:job;$script:job=$null;$verify.Enabled=$install.Enabled=$true
 }
})
$form.Add_FormClosing({if($script:job){$_.Cancel=$true;[Windows.Forms.MessageBox]::Show('Please wait for the current operation to finish.','Installation running')}})
[void]$form.ShowDialog()
$timer.Dispose();$form.Dispose()
