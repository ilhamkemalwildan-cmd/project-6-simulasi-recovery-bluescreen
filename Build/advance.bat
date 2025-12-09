@echo off
title ADVANCED DATA RECOVERY SYSTEM
color 0B

set BASE=%USERPROFILE%\Desktop
set SOURCE=%BASE%\SimulasiDrive_D
set DEST_BASE=%BASE%\SimulasiDrive_C

:MENU
cls
echo ==========================================================
echo                ADVANCED DATA RECOVERY SYSTEM
echo ==========================================================
echo Source Folder: %SOURCE%
echo Destination:   %DEST_BASE%
echo ==========================================================
echo  1. Selective Backup (Pilih Folder)
echo  2. Incremental Backup (Hanya file baru/berubah)
echo  3. Scheduled Backup (Backup tiap X menit)
echo  4. Email Notification (Notifikasi Gmail)
echo  5. Exit
echo ==========================================================
set /p opc=Masukkan pilihan (1-5): 

if %opc%==1 goto SELECTIVE
if %opc%==2 goto INCREMENTAL
if %opc%==3 goto SCHEDULE
if %opc%==4 goto EMAIL
if %opc%==5 exit
goto MENU


:SELECTIVE
cls
echo ---- SELECTIVE BACKUP ----
echo Folder tersedia:
dir "%SOURCE%" /b
echo.
set /p FOLDER=Ketik nama folder yang ingin di-backup: 

set DEST=%DEST_BASE%\Selective_%FOLDER%_%date:~-4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%
mkdir "%DEST%"

xcopy "%SOURCE%\%FOLDER%" "%DEST%" /E /H /C /I /Y

echo SELESAI! Backup selective tersimpan di:
echo %DEST%
pause
goto MENU


:INCREMENTAL
cls
echo ---- INCREMENTAL BACKUP ----
set DEST=%DEST_BASE%\IncrementalBackup
mkdir "%DEST%"

robocopy "%SOURCE%" "%DEST%" /E /XO /LOG:%DEST%\incremental_log.txt

echo SELESAI! Incremental backup berjalan.
pause
goto MENU


:SCHEDULE
cls
echo ---- SCHEDULED BACKUP ----
set /p interval=Backup berulang setiap berapa menit?: 
echo Jalankan CTRL + C untuk menghentikan proses.
timeout 3 > nul

:LOOP
set TS=%date:~-4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%
set DEST=%DEST_BASE%\Schedule_%TS%
mkdir "%DEST%"
xcopy "%SOURCE%" "%DEST%" /E /H /C /I /Y

echo ----- Backup dilakukan pada %TS% -----
timeout %interval% * 60 > nul
goto LOOP


:EMAIL
cls
echo ---- EMAIL NOTIFICATION ----
set /p email=Masukkan email Gmail tujuan: 
set /p pesan=Tulis pesan singkat notifikasi: 

C:\Program Files\PowerShell\7\pwsh.exe-Command "Send-MailMessage -To '%email%' -From '%email%' -Subject 'Backup Selesai' -Body '%pesan%' -SmtpServer 'smtp.gmail.com' -Port 587 -UseSsl -Credential (New-Object System.Management.Automation.PSCredential('%email%', (Read-Host 'Password email Gmail' -AsSecureString)))"

echo Email notifikasi dikirim sukses!
pause
goto MENU