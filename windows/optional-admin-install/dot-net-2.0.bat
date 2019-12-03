@echo off

echo Install .NET 2.0 from https://dotnet.microsoft.com/download/dotnet-core/2.2#sdk-2.2.100

if not exist "%tmp%\dotnet-sdk-2.2.100-win-x64.exe" (
   echo call %~dp0\..\download-web-file.bat "https://download.visualstudio.microsoft.com/download/pr/7ae62589-2bc1-412d-a653-5336cff54194/b573c4b135280fb369e671a8f477163a/dotnet-sdk-2.2.100-win-x64.exe" "%tmp%" | msr -XM || exit /b -1
)

echo "%tmp%\dotnet-sdk-2.2.100-win-x64.exe" /install | msr -XM || exit /b -1
exit /b 0
