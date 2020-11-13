@echo off
cd /d "%~dp0"
echo Confirm if you would like to uninstall old edge
pause
cls
powershell -c "Invoke-Webrequest https://github.com/Ray-MRQ/MRQ/raw/master/Install%20files/install_wim_tweak.exe -outfile .\install_wim_tweak.exe
echo Uninstalling Microsoft Edge...
install_wim_tweak.exe /o /l
install_wim_tweak.exe /o /c Microsoft-Windows-Internet-Browser-Package /r
install_wim_tweak.exe /h /o /l
echo Microsoft Edge should be uninstalled. Please reboot Windows 10.
pause
del .\install_wim_tweak.exe