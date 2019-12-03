@echo off
SetLocal EnableExtensions EnableDelayedExpansion
call %~dp0\set-env.bat || exit /b -1

set gitFolder=!OpenGitFolder!\msrTools
for /f "tokens=*" %%a in ('msr -l -rp !gitFolder! -f "^(ps\w+|fix-file-style)\.bat$" -PAC') do (
    echo if not exist !ToolFolder!\%%~nxa  mklink !ToolFolder!\%%~nxa %%a | msr -XM || exit /b -1
)
