@echo off
title UtilityToolsV2 - Running
echo.

REM Activate virtual environment if it exists
if exist venv\Scripts\activate.bat (
    call venv\Scripts\activate.bat
)

python main.py
if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Bot crashed or failed to start.
    echo Make sure you ran build.bat first to install dependencies.
    echo and make sure you intents enabled for bot in Discord developer portal.
    pause
    exit /b 1
)
pause
