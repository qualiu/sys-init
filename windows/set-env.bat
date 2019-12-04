@echo off

if exist D:\ (
    set "DiskD=D:"
) else (
    set "DiskD=%HOMEDRIVE%"
)

set ToolFolder=%DiskD%\tools
set OpenGitFolder=%DiskD%\opengit
set AppFolder=%DiskD%\apps

if not exist "%ToolFolder%" md "%ToolFolder%"
if not exist "%OpenGitFolder%" md "%OpenGitFolder%"
if not exist "%AppFolder%" md "%AppFolder%"

if "%PATH:~-1%" == "\" set "PATH=%PATH:~0,-1%"
where msr.exe /q 2>nul || (
    REM whoami /groups | msr -ix BUILTIN\Administrators -t Enabled >nul
    powershell "[System.Environment]::SetEnvironmentVariable('PATH', '%PATH%;%ToolFolder%', [EnvironmentVariableTarget]::Machine)"
    set "PATH=%PATH%;%ToolFolder%"
)

if not exist "%ToolFolder%\msr.exe" (
    powershell "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri https://github.com/qualiu/msr/blob/master/tools/msr.exe?raw=true -OutFile %ToolFolder%\msr.exe.tmp" || exit /b -1
    move /y "%ToolFolder%\msr.exe.tmp" "%ToolFolder%\msr.exe"  || exit /b -1
)

if not exist "%ToolFolder%\nin.exe" (
    powershell "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri https://github.com/qualiu/msr/blob/master/tools/nin.exe?raw=true -OutFile %ToolFolder%\nin.exe.tmp" || exit /b -1
    move /y "%ToolFolder%\nin.exe.tmp" "%ToolFolder%\nin.exe"  || exit /b -1
)

exit /b 0
