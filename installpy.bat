@echo off
REM Source: https://github.com/corpnewt/SSDTTime/blob/97a3963e40a153a8df5ae61a73e150cd7a119b3c/SSDTTime.bat
REM Get our local path before delayed expansion - allows ! in path
set "thisDir=%~dp0"

setlocal enableDelayedExpansion
REM Setup initial vars
set "script_name="
set /a tried=0
set "toask=yes"
set "pause_on_error=yes"
set "py2v="
set "py2path="
set "py3v="
set "py3path="
set "pypath="
set "targetpy=3"

REM use_py3:
REM   TRUE  = Use if found, use py2 otherwise
REM   FALSE = Use py2
REM   FORCE = Use py3
set "use_py3=TRUE"

REM We'll parse if the first argument passed is
REM --install-python and if so, we'll just install
set "just_installing=FALSE"

REM Get the system32 (or equivalent) path
call :getsyspath "syspath"

REM Make sure the syspath exists
if "!syspath!" == "" (
    if exist "%SYSTEMROOT%\system32\cmd.exe" (
        if exist "%SYSTEMROOT%\system32\reg.exe" (
            if exist "%SYSTEMROOT%\system32\where.exe" (
                REM Fall back on the default path if it exists
                set "ComSpec=%SYSTEMROOT%\system32\cmd.exe"
                set "syspath=%SYSTEMROOT%\system32\"
            )
        )
    )
    if "!syspath!" == "" (
        cls
        echo   ###     ###
        echo  # Warning #
        echo ###     ###
        echo.
        echo Could not locate cmd.exe, reg.exe, or where.exe
        echo.
        echo Please ensure your ComSpec environment variable is properly configured and
        echo points directly to cmd.exe, then try again.
        echo.
        echo Current CompSpec Value: "%ComSpec%"
        echo.
        echo Press [enter] to quit.
        pause > nul
        exit /b 1
    )
)

if "%~1" == "--install-python" (
    set "just_installing=TRUE"
    goto installpy
)

:installpy
REM This will attempt to download and install python
REM First we get the html for the python downloads page for Windows
set /a tried=!tried!+1
cls
echo   ###               ###
echo  # Installing Python #
echo ###               ###
echo.
echo Gathering info from https://www.python.org/downloads/windows/...
powershell -command "[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12;(new-object System.Net.WebClient).DownloadFile('https://www.python.org/downloads/windows/','%TEMP%\pyurl.txt')"
REM Extract it if it's gzip compressed
powershell -command "$infile='%TEMP%\pyurl.txt';$outfile='%TEMP%\pyurl.temp';try{$input=New-Object System.IO.FileStream $infile,([IO.FileMode]::Open),([IO.FileAccess]::Read),([IO.FileShare]::Read);$output=New-Object System.IO.FileStream $outfile,([IO.FileMode]::Create),([IO.FileAccess]::Write),([IO.FileShare]::None);$gzipStream=New-Object System.IO.Compression.GzipStream $input,([IO.Compression.CompressionMode]::Decompress);$buffer=New-Object byte[](1024);while($true){$read=$gzipstream.Read($buffer,0,1024);if($read -le 0){break};$output.Write($buffer,0,$read)};$gzipStream.Close();$output.Close();$input.Close();Move-Item -Path $outfile -Destination $infile -Force}catch{}"
if not exist "%TEMP%\pyurl.txt" (
    if /i "!just_installing!" == "TRUE" (
        echo Failed to get info
        exit /b 1
    ) else (
        goto checkpy
    )
)
echo Parsing for latest...
pushd "%TEMP%"
:: Version detection code slimmed by LussacZheng (https://github.com/corpnewt/gibMacOS/issues/20)
for /f "tokens=9 delims=< " %%x in ('findstr /i /c:"Latest Python !targetpy! Release" pyurl.txt') do ( set "release=%%x" )
popd
if "!release!" == "" (
    if /i "!just_installing!" == "TRUE" (
        echo Failed to get python version
        exit /b 1
    ) else (
        goto checkpy
    )
)
echo Found Python !release! - Downloading...
REM Let's delete our txt file now - we no longer need it
del "%TEMP%\pyurl.txt"
REM At this point - we should have the version number.
REM We can build the url like so: "https://www.python.org/ftp/python/[version]/python-[version]-amd64.exe"
set "url=https://www.python.org/ftp/python/!release!/python-!release!-amd64.exe"
set "pytype=exe"
if "!targetpy!" == "2" (
    set "url=https://www.python.org/ftp/python/!release!/python-!release!.amd64.msi"
    set "pytype=msi"
)
REM Now we download it with our slick powershell command
powershell -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (new-object System.Net.WebClient).DownloadFile('!url!','%TEMP%\pyinstall.!pytype!')"
REM If it doesn't exist - we bail
if not exist "%TEMP%\pyinstall.!pytype!" (
    if /i "!just_installing!" == "TRUE" (
        echo Failed to download installer
        exit /b 1
    ) else (
        goto checkpy
    )
)
REM It should exist at this point - let's run it to install silently
echo Installing...
pushd "%TEMP%"
if /i "!pytype!" == "exe" (
    echo pyinstall.exe /quiet PrependPath=1 Include_test=0 Shortcuts=0 Include_launcher=0
    pyinstall.exe /quiet PrependPath=1 Include_test=0 Shortcuts=0 Include_launcher=0
) else (
    set "foldername=!release:.=!"
    echo msiexec /i pyinstall.msi /qb ADDLOCAL=ALL TARGETDIR="%LocalAppData%\Programs\Python\Python!foldername:~0,2!"
    msiexec /i pyinstall.msi /qb ADDLOCAL=ALL TARGETDIR="%LocalAppData%\Programs\Python\Python!foldername:~0,2!"
)
popd
echo Installer finished with %ERRORLEVEL% status.
REM Now we should be able to delete the installer and check for py again
del "%TEMP%\pyinstall.!pytype!"
REM If it worked, then we should have python in our PATH
REM this does not get updated right away though - let's try
REM manually updating the local PATH var
