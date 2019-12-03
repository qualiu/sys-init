@echo off
SetLocal EnableExtensions EnableDelayedExpansion

msr -z "NotFirstArg%~1" -t "^NotFirstArg(|-h|--help|/\?)$" >nul || (
    echo Usage  : %~n0  Web_File_Url  [Save_Folder_or_Path]  [Skip_If_Exist]^(default: 1^)
    echo Example: %~n0  "https://raw.githubusercontent.com/qualiu/msr/master/tools/nin.exe"
    echo Example: %~n0  "https://raw.githubusercontent.com/qualiu/msr/master/tools/nin.exe"  .\
    echo Example: %~n0  "https://raw.githubusercontent.com/qualiu/msr/master/tools/nin.exe"  D:\tools\nin.exe
    exit /b -1
)

set Web_File_Url=%1
set "SavePath=%~2"
if not "%~3" == "" ( set /a Skip_If_Exist=%3 ) else ( set /a Skip_If_Exist=1 )

if "!SavePath!" == "" (
    set "SavePath=%~nx1"
) else (
    echo "!SavePath!" | msr -it "%~nx1$" >nul && (
        if "%SavePath:~-1%" == "\" set "SavePath=%SavePath:~0,-1%"
        set "SavePath=!SavePath!\%~nx1"
    )
)

if exist "!SavePath!" (
    if !Skip_If_Exist! EQU 1 (
        echo Skip downloading !Web_File_Url! due to found !SavePath!
        exit /b 0
    ) else (
        echo Will overwrite !SavePath! by downloading from !Web_File_Url!
    )
)

echo wget !Web_File_Url! -O "!SavePath!.tmp" | msr -XM || exit /b -1
echo move /y "!SavePath!.tmp" "!SavePath!" | msr -XM || exit /b -1

exit /b 0
