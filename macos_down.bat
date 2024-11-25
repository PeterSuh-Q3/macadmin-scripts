@echo off
setlocal enabledelayedexpansion

REM Function to read a yes/no answer
:readanswer
set /p answ=
if /i "!answ!"=="y" (set answer=!answ! & goto :eof)
if /i "!answ!"=="n" (set answer=!answ! & goto :eof)
echo Please answer y/Y or n/N.
goto readanswer

REM Function to check if the recovery folder exists and prompt the user
:check_recovery_folder
if exist "com.apple.recovery.boot" (
    echo The com.apple.recovery.boot folder exists. macOS will be overwritten. Is this okay? (y/n)
    call :readanswer
    if /i not "!answer!"=="y" (
        echo Operation cancelled by user.
        exit /b 1
    )
)
exit /b 0

REM Download macrecovery.py using wget
wget --no-check-certificate https://raw.githubusercontent.com/acidanthera/OpenCorePkg/refs/heads/master/Utilities/macrecovery/macrecovery.py

echo Select a macOS recovery version:
echo 1) Lion (10.7.5)
echo 2) Mountain Lion (10.8.5)
echo 3) Mavericks (10.9.5)
echo 4) Yosemite (10.10.5)
echo 5) El Capitan (10.11.6)
echo 6) Sierra (10.12.6)
echo 7) High Sierra (10.13.6)
echo 8) Mojave (10.14.6)
echo 9) Catalina (10.15.7)
echo 10) Big Sur (11.7.10)
echo 11) Monterey (12.7.6)
echo 12) Ventura (13.7.1)
echo 13) Sonoma (14.7.1)
echo 14) Sequoia (15.1.1)
echo 15) Exit

set /p choice=Choose an option:

if "%choice%"=="1" call :check_recovery_folder && python macrecovery.py -b Mac-2E6FAB96566FE58C -m 00000000000F25Y00 download
if "%choice%"=="2" call :check_recovery_folder && python macrecovery.py -b Mac-7DF2A3B5E5D671ED -m 00000000000F65100 download
if "%choice%"=="3" call :check_recovery_folder && python macrecovery.py -b Mac-F60DEB81FF30ACF6 -m 00000000000FNN100 download
if "%choice%"=="4" call :check_recovery_folder && python macrecovery.py -b Mac-E43C1C25D4880AD6 -m 00000000000GDVW00 download
if "%choice%"=="5" call :check_recovery_folder && python macrecovery.py -b Mac-FFE5EF870D7BA81A -m 00000000000GQRX00 download
if "%choice%"=="6" call :check_recovery_folder && python macrecovery.py -b Mac-77F17D7DA9285301 -m 00000000000J0DX00 download
if "%choice%"=="7" call :check_recovery_folder && python macrecovery.py -b Mac-7BA5B2D9E42DDD94 -m 00000000000J80300 download
if "%choice%"=="8" call :check_recovery_folder && python macrecovery.py -b Mac-7BA5B2DFE22DDD8C -m 00000000000KXPG00 download
if "%choice%"=="9" call :check_recovery_folder && python macrecovery.py -b Mac-CFF7D910A743CAAF -m 00000000000PHCD00 download
if "%choice%"=="10" call :check_recovery_folder && python macrecovery.py -b Mac-2BD1B31983FE1663 -m 00000000000000000 download
if "%choice%"=="11" call :check_recovery_folder && python macrecovery.py -b Mac-E43C1C25D4880AD6 -m 00000000000000000 download
if "%choice%"=="12" call :check_recovery_folder && python macrecovery.py -b Mac-B4831CEBD52A0C4C -m 00000000000000000 download
if "%choice%"=="13" call :check_recovery_folder && python macrecovery.py -b Mac-827FAC58A8FDFA22 -m 00000000000000000 download
if "%choice%"=="14" call :check_recovery_folder && python macrecovery.py -b Mac-937A206F2EE63C01 -m 00000000000000000 download
if "%choice%"=="15" (
    echo Exiting the menu.
    exit /b
)

echo Invalid selection.
