@echo off
start "HP1 VR V31 Setup" powershell.exe -NoProfile -STA -ExecutionPolicy Bypass -WindowStyle Hidden -File "%~dp0Setup.ps1"
