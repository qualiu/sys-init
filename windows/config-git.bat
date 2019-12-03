@echo off
SetLocal EnableExtensions EnableDelayedExpansion
call %~dp0\set-env.bat || exit /b -1

git lfs install
git config --global core.longpaths true

:: Set normal time format
git config --global log.date iso

:: Configure commit editor.
:: For notepad++ like: git config --global core.editor "'C:/Program Files (x86)/Notepad++/notepad++.exe' -multiInst -notabbar -nosession -noPlugin"
for /f "tokens=*" %%a in ('where notepad.exe ^| msr -x \ -o / -aPAC -T 1') do (
    echo git config --global core.editor "'%%a'" | msr -XM || exit /b -1
)

:: Configure beyond compare
for /f "tokens=*" %%a in ('where Comp.exe /q 2^>nul ^| msr -x \ -o / -aPAC -T 1') do (
    echo git config --global diff.tool bc4 | msr -XM
    echo git config --global difftool.bc4.cmd "\"%%a\" \"$LOCAL\" \"$REMOTE\"" | msr -XM || exit /b -1
    echo git config --global difftool.prompt false | msr -XM
)
