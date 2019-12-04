@echo off

choco install -y git curl wget 7zip.install

where code.exe /q 2>nul || choco install vscode -y

SetLocal EnableExtensions EnableDelayedExpansion
call %~dp0\set-env.bat || exit /b -1

choco install -y anaconda3 --params '"/AddToPath /JustMe /D:!AppFolder!"'
