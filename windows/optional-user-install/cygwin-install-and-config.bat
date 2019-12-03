@echo off
SetLocal EnableExtensions EnableDelayedExpansion

call %~dp0\..\set-env.bat || exit /b -1

set CygwinRoot=!AppFolder!\cygwin
set ScriptsFolder=!OpenGitFolder!\msrTools
set CygwinBashFile=!ToolFolder!\cygbash.bat

if not exist !CygwinRoot! echo !ScriptsFolder!\system\install-cygwin.bat !CygwinRoot! | msr -XM || exit /b -1

msr -p %0 -b "^\s*:CygwinBash_Content" --nx CygwinBash_Content -PAC > !CygwinBashFile!
for /f "tokens=*" %%a in ('msr -p %0 -it "^set\s+(\w+)=.*" -o "\1" -PAC') do (
    for /f "tokens=*" %%b in ('msr -z "!%%a!" -PAC') do (
        msr -p !CygwinBashFile! -ix "^!%%a^!" -o "%%b" -R -c Replace variables.
    )
)

msr -l --wt --sz -p !CygwinBashFile! -PM
exit /b 0

:CygwinBash_Content
call !ScriptsFolder!\disable-exe-in-PATH.bat grep.exe || exit /b -1
call !ScriptsFolder!\disable-folder-in-PATH.bat !CygwinRoot! || exit /b -1
call !ScriptsFolder!\disable-folder-in-PATH.bat !CygwinRoot! || exit /b -1
@set CYGWIN_ROOT=!CygwinRoot!
@set "PATH=!CygwinRoot!\bin;%PATH%"
@bash %*
