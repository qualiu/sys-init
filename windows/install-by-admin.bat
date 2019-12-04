@echo off

whoami /groups | findstr /I BUILTIN\Administrators | findstr /I Enabled >nul || (
    echo %0 should be run as 'Administrator' role to install softwares.
    exit /b -1
)

choco install -y git curl wget 7zip.install

call %~dp0\check-install-app.bat code vscode || exit /b -1

call %~dp0\check-install-app.bat conda anaconda3 --params '"/AddToPath /JustMe /D:!AppFolder!"' || exit /b -1

exit /b 0
