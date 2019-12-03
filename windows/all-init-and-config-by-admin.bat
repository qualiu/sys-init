@echo off
call %~dp0\set-env.bat || exit /b -1
call %~dp0\install-choco.bat || exit /b -1
call %~dp0\install-by-admin.bat || exit /b -1

pushd %~dp0
::msr -p %~dp0%~nx0 -b "^:Install_By_User" -t "^\s*(\S+\.bat).*" -o "runas /trustlevel:0x20000 \1" -XM
for /f "tokens=*" %%a in ('msr -p %~dp0%~nx0 -b "^:Install_By_User" -t "^\s*(\S+\.bat).*" -o "\1" -PAC') do (
    echo runas /trustlevel:0x20000 %~dp0\%%a
    runas /trustlevel:0x20000 %~dp0\%%a
)

popd & exit /b %ERRORLEVEL%

:Install_By_User
install-by-user.bat
config-git.bat
config-all-cmd-alias.bat
create-links.bat
