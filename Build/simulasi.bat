@echo off
setlocal enabledelayedexpansion
title Simulasi Recovery Bluescreen - Full Automation
color 0A

echo ======================================================
echo      SIMULASI RECOVERY BLUESCREEN - OTOMATIS
echo ======================================================
echo.

:: SETUP LOKASI
set SRC=%USERPROFILE%\Desktop\SimulasiDrive_D
set DST=%USERPROFILE%\Desktop\SimulasiDrive_C

echo [1] Membuat struktur sumber data (SimulasiDrive_D)
mkdir "%SRC%" >nul 2>&1

:: ======================================================
:: GENERATE 10 FOLDER, 30 SUBFOLDER, 180 FILE
:: ======================================================
echo Membuat 10 folder utama, 30 subfolder, 180 file...

for /l %%F in (1,1,10) do (

    rem ---------- Format nomor 2 digit ----------
    set "Num=00%%F"
    set "Num=!Num:~-2!"

    rem ---------- Membuat folder utama ----------
    mkdir "%SRC%\Folder_!Num!"
    mkdir "%SRC%\Folder_!Num!\SubFolder_A"
    mkdir "%SRC%\Folder_!Num!\SubFolder_B"
    mkdir "%SRC%\Folder_!Num!\SubFolder_C"

    rem ---------- SubFolder A (6 file) ----------
    echo A1 > "%SRC%\Folder_!Num!\SubFolder_A\dokumen_!Num!_A.pdf"
    echo A2 > "%SRC%\Folder_!Num!\SubFolder_A\data_!Num!_A.csv"
    echo A3 > "%SRC%\Folder_!Num!\SubFolder_A\catatan_!Num!_A.txt"
    echo A4 > "%SRC%\Folder_!Num!\SubFolder_A\laporan_!Num!_A.docx"
    echo A5 > "%SRC%\Folder_!Num!\SubFolder_A\script_!Num!_A.bat"
    echo A6 > "%SRC%\Folder_!Num!\SubFolder_A\image_!Num!_A.png"

    rem ---------- SubFolder B (6 file) ----------
    echo B1 > "%SRC%\Folder_!Num!\SubFolder_B\foto_!Num!_B.jpg"
    echo B2 > "%SRC%\Folder_!Num!\SubFolder_B\musik_!Num!_B.mp3"
    echo B3 > "%SRC%\Folder_!Num!\SubFolder_B\video_!Num!_B.mp4"
    echo B4 > "%SRC%\Folder_!Num!\SubFolder_B\tabel_!Num!_B.xlsx"
    echo B5 > "%SRC%\Folder_!Num!\SubFolder_B\pdf_!Num!_B.pdf"
    echo B6 > "%SRC%\Folder_!Num!\SubFolder_B\note_!Num!_B.txt"

    rem ---------- SubFolder C (6 file) ----------
    echo C1 > "%SRC%\Folder_!Num!\SubFolder_C\db_!Num!_C.db"
    echo C2 > "%SRC%\Folder_!Num!\SubFolder_C\config_!Num!_C.ini"
    echo C3 > "%SRC%\Folder_!Num!\SubFolder_C\json_!Num!_C.json"
    echo C4 > "%SRC%\Folder_!Num!\SubFolder_C\sql_!Num!_C.sql"
    echo C5 > "%SRC%\Folder_!Num!\SubFolder_C\doc_!Num!_C.docx"
    echo C6 > "%SRC%\Folder_!Num!\SubFolder_C\bin_!Num!_C.exe"
)

echo Selesai membuat 180 file dan seluruh struktur.
echo.
timeout /t 1 >nul

:: ======================================================
:: SIMULASI BLUESCREEN
:: ======================================================
echo [2] Menjalankan SIMULASI BLUESCREEN...
color 0C
echo.
echo *** SYSTEM CRASH DETECTED ***
echo *** KERNEL_STACK_INPAGE_ERROR ***
echo *** STOP CODE: 0x0000007A ***
timeout /t 2 >nul

echo Menandai drive sumber sebagai "rusak"...
echo DRIVE_CORRUPTED > "%SRC%\_DRIVE_ERROR.sim"
timeout /t 1 >nul

:: ======================================================
:: PEMULIHAN DATA (RECOVERY)
:: ======================================================
echo.
echo [3] MEMULAI RECOVERY DATA
color 0A

if not exist "%DST%" mkdir "%DST%"

:: Timestamp recovery
set YEAR=%date:~10,4%
set MON=%date:~4,2%
set DAY=%date:~7,2%
set HR=%time:~0,2%
set MN=%time:~3,2%
set HR=%HR: =0%

set RECOVERY=%DST%\DataRecovery_%YEAR%%MON%%DAY%_%HR%%MN%

mkdir "%RECOVERY%"

echo Menyalin data dari drive rusak...
echo Harap tunggu...
robocopy "%SRC%" "%RECOVERY%" /E /COPYALL /R:1 /W:1 /LOG:"%RECOVERY%\RecoveryLog.txt"

echo.
echo ======================================================
echo             PEMULIHAN DATA SELESAI
echo ======================================================
echo Lokasi sumber rusak  : %SRC%
echo Lokasi hasil recovery : %RECOVERY%
echo Log file              : RecoveryLog.txt
echo ======================================================
echo.

explorer "%RECOVERY%"
pause
exit