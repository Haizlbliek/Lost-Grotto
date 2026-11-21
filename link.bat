@echo off
setlocal

net session >nul 2>&1
if %errorlevel% neq 0 (
	echo Requesting administrator privileges...
	powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
	exit /b
)

set "SOURCE=%~dp0mod"
set "TARGET=C:\Program Files (x86)\Steam\steamapps\common\Rain World\RainWorld_Data\StreamingAssets\mods\Lost-Grotto"

if not exist "%SOURCE%" (
	echo [ERROR] Could not find source folder: "%SOURCE%"
	pause
	exit /b 1
)

if exist "%TARGET%" (
	echo Removing existing Lost-Grotto folder/link...
	rmdir "%TARGET%" 2>nul
	if exist "%TARGET%" rmdir /s /q "%TARGET%"
)

mklink /D "%TARGET%" "%SOURCE%"

echo.
pause
