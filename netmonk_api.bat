@echo off
setlocal enabledelayedexpansion

REM 
set ENV_FILE=config.env

if exist "%ENV_FILE%" (
  for /f "usebackq tokens=1,2 delims==" %%A in ("%ENV_FILE%") do (
    if not "%%A"=="" (
      set %%A=%%B
    )
  )
) else (
  echo File %ENV_FILE% tidak ditemukan. Pastikan udah dibuat ya say.
  pause
  exit /b 1
)

cls
echo.
echo Pilih report yang mau dijalankan ya say:
echo [1] HI
echo [2] PRIME
echo [3] PORTAL
set /p choice="Ketik nomornya (1/2/3): "

if "%choice%"=="1" (
  set REPORT_NAME=HI
  set COLLECTION_ID=%HI_COLLECTION_ID%
  set ENVIRONMENT_ID=%HI_ENVIRONMENT_ID%
) else if "%choice%"=="2" (
  set REPORT_NAME=PRIME
  set COLLECTION_ID=%PRIME_COLLECTION_ID%
  set ENVIRONMENT_ID=%PRIME_ENVIRONMENT_ID%
) else if "%choice%"=="3" (
  set REPORT_NAME=PORTAL
  set COLLECTION_ID=%PORTAL_COLLECTION_ID%
  set ENVIRONMENT_ID=%PORTAL_ENVIRONMENT_ID%
) else (
  echo Pilihan tidak valid say.
  pause
  exit /b 1
)

set "TARGET_DIR=%USERPROFILE%\Documents\postman_newman"
if not exist "%TARGET_DIR%" (
  mkdir "%TARGET_DIR%"
)

for /f %%a in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd_HH-mm-ss"') do set "TIMESTAMP=%%a"
set "FILENAME=%REPORT_NAME%_Report_%TIMESTAMP%.html"
set "FULL_PATH=%TARGET_DIR%\%FILENAME%"

echo.
echo Jalanin tes untuk: %REPORT_NAME%...
newman run "https://api.getpostman.com/collections/%COLLECTION_ID%?apikey=%POSTMAN_API_KEY%" ^
  --environment "https://api.getpostman.com/environments/%ENVIRONMENT_ID%?apikey=%POSTMAN_API_KEY%" ^
  -r htmlextra ^
  --reporter-htmlextra-title "%REPORT_NAME% Netmonk" ^
  --reporter-htmlextra-displayProgressBar true ^
  --reporter-htmlextra-export "%FULL_PATH%"

echo.
echo Done say!
echo Report disimpan di: %FULL_PATH%
echo.

set /p open="Mau langsung buka report-nya sekarang say? (Y/N): "
if /i "%open%"=="Y" (
  start "" "%FULL_PATH%"
) else (
  echo Siap, report-nya disimpan aja ya say.
)

pause