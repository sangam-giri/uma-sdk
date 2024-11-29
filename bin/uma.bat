@echo off
setlocal

REM Get the current directory where the script is being run
set "currentDir=%cd%"

REM Get the path of the parent folder (the folder where 'bin' exists) relative to the script
set "sdkFolder=%~dp0.."

REM Check if the first argument is 'run' or 'new'
if "%1"=="run" (
    if "%2"=="start:server" (
        cd src
        dart main.dart
    )
) else (
    if "%1"=="new" (
        REM Call PowerShell script to colorize the creation process
        powershell -ExecutionPolicy Bypass -File "%~dp0script.ps1" "Creating project %2..."

        REM Create the new folder based on user input (%2) in the user's current directory
        mkdir "%currentDir%\%2" >nul 2>&1

        REM Copy everything from the SDK folder (excluding 'bin') to the new folder in the current directory
        for /d %%I in ("%sdkFolder%\*") do (
            if /I not "%%~nxI"=="bin" (
                xcopy "%%I" "%currentDir%\%2\%%~nxI" /E /H /I >nul 2>&1
            )
        )
        for %%I in ("%sdkFolder%\*.*") do (
            if /I not "%%~nxI"=="bin" (
                copy "%%I" "%currentDir%\%2\" >nul 2>&1
            )
        )

        REM Call PowerShell script to notify user of completion
        powershell -ExecutionPolicy Bypass -File "%~dp0script.ps1" "Project created successfully in %currentDir%\%2"
    )
)

endlocal
