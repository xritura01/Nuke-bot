@echo off
setlocal enabledelayedexpansion
title UtilityToolsV2 Setup
echo ============================================
echo  UtilityToolsV2 - Build and Setup
echo ============================================
echo.

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo [INFO] Python is not installed. Downloading and installing...
    echo [INFO] Downloading latest Python...
    powershell -Command "Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.13.5/python-3.13.5-amd64.exe' -OutFile 'python-installer.exe'"
    if errorlevel 1 (
        echo [ERROR] Failed to download Python installer.
        pause
        exit /b 1
    )
    echo [INFO] Installing Python...
    python-installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
    del python-installer.exe
    echo [INFO] Python installed. Restarting script...
    pause
    exit /b 0
)

echo [OK] Python is already installed.
echo.
echo [INFO] Creating virtual environment...
if exist venv (
    echo [OK] Virtual environment already exists.
) else (
    python -m venv venv
    if errorlevel 1 (
        echo [ERROR] Failed to create virtual environment.
        pause
        exit /b 1
    )
)

echo [INFO] Activating virtual environment...
call venv\Scripts\activate.bat

echo.
echo [INFO] Installing required packages...
python -m pip install --upgrade pip >nul 2>&1
python -m pip install discord.py aiohttp

if errorlevel 1 (
    echo [ERROR] Failed to install dependencies.
    pause
    exit /b 1
)

echo.
echo ============================================
echo  Setup complete! Run: run.bat
echo ============================================
pause
