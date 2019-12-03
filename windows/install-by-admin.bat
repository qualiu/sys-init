@echo off
SetLocal EnableExtensions EnableDelayedExpansion
call %~dp0\set-env.bat || exit /b -1

choco install -y git wget vscode 7zip.install

choco install -y nodejs
choco install -y yarn

choco install -y anaconda3 --params '"/AddToPath /JustMe /D:!AppFolder!"'
