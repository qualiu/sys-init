@echo off

where choco.exe /q 2>nul && exit /b 0

powershell Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
if %ERRORLEVEL% NEQ 0 exit /b -1

if not exist "%PROGRAMDATA%\chocolatey\bin" (
    echo Not found %PROGRAMDATA%\chocolatey\bin
    exit /b -1
)

where choco.exe /q 2>nul || set "PATH=%PATH%;%PROGRAMDATA%\chocolatey\bin"
exit /b 0
