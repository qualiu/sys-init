@echo off
SetLocal EnableExtensions EnableDelayedExpansion
call %~dp0\set-env.bat || exit /b -1

set cmdAliasFile=!ToolFolder!\cmd-alias.doskeys
for /f "tokens=*" %%a in ('msr -z !cmdAliasFile! -x \ -o \\ -PAC') do set "cmdAliasFile2Slashes=%%a"
msr -p %~dp0\doskeys -f "\.doskeys$" -PIC -c Merge all doskeys > !cmdAliasFile!
msr -p !cmdAliasFile! -it "\b[a-z]:\\\S+\.doskeys" -o !cmdAliasFile2Slashes! -R -c Update doskeys file path.

msr -p !cmdAliasFile! -t "update-doskeys=(.+)" -o "\1" -XM Activate doskeys

echo REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Command Processor" /v Autorun /d "DOSKEY /MACROFILE=!cmdAliasFile!" /f | msr -XM
exit /b 0
