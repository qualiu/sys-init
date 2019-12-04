@echo off
SetLocal EnableExtensions EnableDelayedExpansion

msr -z "NotFirstArg%~1" -t "^NotFirstArg(-h|--help|/\?)$" >nul || (
    echo Usage:   %0  ExeNameNoExt  [ChocoInstallName]  [ChocoInstallArgs]
    echo Example: %0  yarn    yarn
    echo Example: %0  node    nodejs
    echo Example: %0  az      azure-cli  "Azure Command Line Interface"
    echo Example: %0  conda   miniconda3
    echo Example: %0  conda   anaconda3
    echo Example: %0  docker  docker-for-windows
    exit /b -1
)

call %~dp0\set-env.bat || exit /b -1
set ExeNameNoExt=%~1
if not "%~2" == "" ( set "ChocoInstallName=%~2" ) else ( set "ChocoInstallName=!ExeNameNoExt!" )

set ChocoInstallArgs=%3
shift & shift & shift
:CheckArgs
    if [%~1] == [] if [%~2] == [] goto CheckArgsCompleted
    set ChocoInstallArgs=!ChocoInstallArgs! %1
    shift
    goto CheckArgs
:CheckArgsCompleted

REM echo choco install -y !ChocoInstallName! !ChocoInstallArgs!

echo. & echo Check if has installed !ExeNameNoExt! ... | msr -aPA -e "(!ExeNameNoExt!)"
where !ExeNameNoExt! 2>nul | msr -aPA -e .+ -it "[/\\](!ExeNameNoExt!)\.(?:cmd|exe|bat)\s*$" && (
    echo choco install -y !ChocoInstallName! !ChocoInstallArgs! | msr -XM || exit /b -1
)

exit /b 0
