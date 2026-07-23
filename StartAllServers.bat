@echo off
setlocal

echo Starting backend servers...
for /d %%D in (*) do (
    if /I NOT "%%~nxD"=="Velocity" (
        if exist "%%D\StartServer.bat" (
            echo Launching server in: %%D
            pushd "%%D"
            start "%%~nxD" cmd /c "StartServer.bat"
            popd
            timeout /t 2 >nul
        )
    )
)

echo Waiting for backend servers to initialize...
timeout /t 5 >nul

echo Starting Velocity Proxy...
if exist "Velocity\StartServer.bat" (
    echo Launching Velocity...
    pushd "Velocity"
    start "Velocity" cmd /c "StartServer.bat"
    popd
) else (
    echo [Warning] Velocity StartServer.bat not found.
)

echo All servers have been launched!