@echo off
setlocal enabledelayedexpansion

for /f "skip=9 tokens=1,2 delims=:" %%i in ('netsh wlan show profiles') do (
    set "profile=%%j"
    set "profile=!profile:~1!"
    echo SSID: !profile!

    netsh wlan show profile name="!profile!" key=clear > temp_output.txt

    for /f "tokens=*" %%l in ('findstr /r /c:"Key Content" temp_output.txt') do (

        for /f "tokens=2 delims=:" %%k in ("%%l") do (
            set "keyContent=%%k"
            set "keyContent=!keyContent:~1!"
            echo Password: !keyContent!
        )
    )

    echo.
)

del temp_output.txt

pause