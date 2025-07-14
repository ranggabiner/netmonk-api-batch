@echo off
setlocal enabledelayedexpansion

set "ENV_FILE=config.env"
if exist "%ENV_FILE%" (
  for /f "usebackq tokens=1,* delims==" %%A in (`findstr /v "^#" "%ENV_FILE%"`) do (
    set %%A=%%B
  )
) else (
  echo File %ENV_FILE% tidak ditemukan. Pastikan sudah buat ya say.
  exit /b 1
)

cls

echo ███╗   ██╗███████╗████████╗███╗   ███╗ ██████╗ ███╗   ██╗██╗  ██╗     █████╗ ██████╗ ██╗
echo ████╗  ██║██╔════╝╚══██╔══╝████╗ ████║██╔═══██╗████╗  ██║██║ ██╔╝    ██╔══██╗██╔══██╗██║
echo ██╔██╗ ██║█████╗     ██║   ██╔████╔██║██║   ██║██╔██╗ ██║█████╔╝     ███████║██████╔╝██║
echo ██║╚██╗██║██╔══╝     ██║   ██║╚██╔╝██║██║   ██║██║╚██╗██║██╔═██╗     ██╔══██║██╔═══╝ ██║
echo ██║ ╚████║███████╗   ██║   ██║ ╚═╝ ██║╚██████╔╝██║ ╚████║██║  ██╗    ██║  ██║██║     ██║
echo ╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚═╝     ╚═╝
echo.
echo Pilih report yang mau dijalankan ya say:
echo nb: Ketikin aja ya, atau pilih pake arrow keys say
echo.

for /f %%R in ('echo PRIME^&echo HI^&echo PORTAL ^| fzf --layout=reverse --info=inline --border=rounded --height=30%% --prompt="PILIH REPORT: "') do (
  set "REPORT_NAME=%%R"
)

if not defined REPORT_NAME (
  echo Gak ada yang dipilih. Batal say.
  exit /b 1
)

if /i "%REPORT_NAME%"=="HI" (
  set COLLECTION_ID=%HI_COLLECTION_ID%
  set ENVIRONMENT_ID=%HI_ENVIRONMENT_ID%
) else if /i "%REPORT_NAME%"=="PRIME" (
  set COLLECTION_ID=%PRIME_COLLECTION_ID%
  set ENVIRONMENT_ID=%PRIME_ENVIRONMENT_ID%
) else if /i "%REPORT_NAME%"=="PORTAL" (
  set COLLECTION_ID=%PORTAL_COLLECTION_ID%
  set ENVIRONMENT_ID=%PORTAL_ENVIRONMENT_ID%
) else (
  echo Pilihan tidak valid say.
  exit /b 1
)

set "TARGET_DIR=%USERPROFILE%\Documents\postman_newman"
if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%"
for /f %%t in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd_HH-mm-ss"') do set "TIMESTAMP=%%t"
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

for /f %%C in ('echo YA^&echo TIDAK ^| fzf --layout=reverse --info=inline --border=rounded --height=30%% --prompt="MAU BUKA SEKARANG?: "') do (
  set "OPEN_CHOICE=%%C"
)

if /i "%OPEN_CHOICE%"=="YA" (
  echo Membuka report say...
  start "" "%FULL_PATH%"
) else (
  echo Siap, report-nya disimpan aja ya say.
)

