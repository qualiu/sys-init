@echo off
SetLocal EnableExtensions EnableDelayedExpansion
call %~dp0\set-env.bat || exit /b -1

pushd !OpenGitFolder! || exit /b -1

if not exist msrTools (
    echo git clone https://github.com/qualiu/msrTools | msr -XM
) else (
    msr -XM -z "pushd msrTools && git pull origin master"
)

popd & exit /b %ERRORLEVEL%
