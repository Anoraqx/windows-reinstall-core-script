@echo off
setlocal

echo Download phase.

:: Start downloads

:: Google Chrome
call :download_file "https://dl.google.com/chrome/install/latest/chrome_installer.exe" "%UserProfile%\Downloads\chrome_installer.exe"

:: Discord
call :download_file "https://discord.com/api/download?platform=win" "%UserProfile%\Downloads\discord_installer.exe"

:: Steam
call :download_file "https://cdn.cloudflare.steamstatic.com/client/installer/SteamSetup.exe" "%UserProfile%\Downloads\steam_installer.exe"

:: Telegram
call :download_file "https://telegram.org/dl/desktop/win64" "%UserProfile%\Downloads\telegram_installer.exe"

:: SteelSeries Engine
call :download_file "https://steelseries.com/gg/downloads/gg/latest/windows" "%UserProfile%\Downloads\steelseries_engine_installer.exe"

:: Dankerino
call :download_file "https://github.com/Mm2PL/dankerino/releases/download/nightly-build/chatterino-windows-x86-64-Qt-6.7.1.zip" "%UserProfile%\Downloads\dankerino.zip"

echo All downloads are complete! 

:: NVidia Drivers
echo Automatic download is not possible due to frequent version change and two different products.
echo Select ONE of two:
echo NVIDIA App - https://www.nvidia.com/en-us/software/nvidia-app/
echo NVIDIA Experience - https://www.nvidia.com/en-us/geforce/geforce-experience/


echo Install phase. God elp.

:: Install Google Chrome
echo Installing Google Chrome...
start /wait "" "%UserProfile%\Downloads\chrome_installer.exe" /silent /install

:: Install Discord
echo Installing Discord...
start /wait "" "%UserProfile%\Downloads\discord_installer.exe" /S

:: Install Telegram
echo Installing Telegram...
start /wait "" "%UserProfile%\Downloads\telegram_installer.exe" /S

:: Install SteelSeries Engine
echo Installing SteelSeries Engine...
start /wait "" "%UserProfile%\Downloads\steelseries_engine_installer.exe" /S

:: Unpack Dankerino directly into C:\
echo Unpacking Dankerino...
powershell -Command "Expand-Archive -Path '%UserProfile%\Downloads\dankerino.zip' -DestinationPath 'C:\' -Force"
if errorlevel 1 (
    echo Error unpacking Dankerino with PowerShell. Please check if the file exists and try again.
    exit /b 1
)

:: Install Steam
echo Installing Steam...
start /wait "" "%UserProfile%\Downloads\steam_installer.exe" /S

echo Automatic installations completed. Steam requires manual installation


exit /b


:: Function to download a file using curl
:download_file
set "url=%~1"
set "output=%~2"
echo ---------------------------------------------------------------------------------------
echo DEBUG: Entering download_file function
echo DEBUG: URL parameter: %url%
echo DEBUG: Output path parameter: %output%

if "%url%"=="" (
    echo ERROR: Missing URL parameter.
    exit /b 1
)

if "%output%"=="" (
    echo ERROR: Missing output path parameter.
    exit /b 1
)

echo Downloading from %url% to %output%...
curl -L "%url%" -o "%output%"
if errorlevel 1 (
    echo FATAL: Error downloading %output%. Please check the URL and try again.
    exit /b 1
)

exit /b
