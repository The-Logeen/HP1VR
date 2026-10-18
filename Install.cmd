@echo off
setlocal
set "HPVR_START_LOG=%TEMP%\HP1VR-V31-launcher-%RANDOM%-%RANDOM%.log"
echo HP1 VR V31 setup. Startup log: "%HPVR_START_LOG%"
echo Keep this window open until setup closes.
echo Process-only PowerShell policy; saved policy and antivirus settings are unchanged.
powershell.exe -ExecutionPolicy Bypass -NoProfile -STA -File "%~dp0Bootstrap.ps1" >"%HPVR_START_LOG%" 2>&1
if errorlevel 1 (
 echo Setup could not start or closed with an error. Startup details:
 type "%HPVR_START_LOG%"
 echo Log: "%HPVR_START_LOG%"
 pause
 exit /b 1
)
exit /b 0
