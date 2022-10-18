@if not defined _echo echo off
REM locate VS2017 and later, see https://github.com/microsoft/vswhere wiki
for /f "usebackq delims=" %%i in (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -prerelease -latest -property installationPath`) do (
  if exist "%%i\Common7\Tools\vsdevcmd.bat" (
    %comspec% /k "%%i\Common7\Tools\vsdevcmd.bat" -arch=amd64
    cd /D %~dp0
    exit /b
  )
)
rem Instance or command prompt not found
exit /b 2
