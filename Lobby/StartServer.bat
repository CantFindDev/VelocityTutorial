@echo off
cd /d "%~dp0"
cls

:: Get the current folder name
for %%I in (.) do set "FolderName=%%~nxI"

:: Find the first .jar file
set "JarFile="
for %%F in (*.jar) do (
    set "JarFile=%%F"
    goto :start
)

:: If no .jar is found
echo [ERROR] Failed to find a .jar file in the current directory!
pause
exit /b

:start
title %FolderName% Server
echo Starting %JarFile%...
java -DIReallyKnowWhatIAmDoingISwear -Xmx1512M -jar "%JarFile%" nogui

:: Check if Java exited with an error
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] Java execution failed or the server crashed!
    echo [ERROR] Exit Code: %ERRORLEVEL%
) else (
    echo.
    echo [INFO] Server stopped normally.
)

echo.
echo [INFO] Process Ended.
pause