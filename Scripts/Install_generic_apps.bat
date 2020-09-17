@echo off
echo Before you start, this will only work if the admin account you are trying to use is logged in, or this script will fail.
pause
goto check_Permissions

:check_Permissions
    echo Administrative permissions required. 
	echo -----------------------------------------
	echo Detecting permissions...
    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
		echo -------------------------------------
    ) else (
        echo Failure: Current permissions inadequate.
		echo -------------------------------------
		echo Run as administrator and try again.
		pause
		exit
    )
cls
echo This script is for installing some generic apps, feel free to add to the script if you'd like.
echo -
REM bitsadmin is a built-in all windows and doesn't require anything else additonal
REM The downloads are pulled straight from my onedrive share and then runs the .exe directly, then the installer handles the application install/download.
REM Some are ninite installers so should install for all users + you don't need to go through any prompts etc.
REM Feel free to add anything that ise useful, none of these are client specfic so should be fine to install.
mkdir c:\temp
:begin
echo Select a task:
echo =============
echo -
echo 1) 7zip
echo 2) Chrome
echo 3) Firefox
echo 4) Zoom
echo 5) Office365 apps 32Bit (Recommended)
echo 6) Office365 apps 64bit (Not recommmended as it causes issues)
echo 7) SonicWALL NeteXtender
echo 8) Mimecast for Outlook 32Bit
echo 9) GlobalVPN 64Bit
echo 50) Exit
echo =============
echo If your install got stuck by ninite/installer for whatever reason, check if windows installer is open on task manager, force it to close, then try again, if your still having issues, just run the exe directly from C:\whateverfile.exe
echo -
echo -
set /p op=Type option:
if "%op%"=="1" goto op1
if "%op%"=="2" goto op2
if "%op%"=="3" goto op3
if "%op%"=="4" goto op4
if "%op%"=="5" goto op5
if "%op%"=="6" goto op6
if "%op%"=="7" goto op7
if "%op%"=="8" goto op8
if "%op%"=="9" goto op9
if "%op%"=="50" goto op50
echo Please Pick an option:
goto begin


:op1
echo You picked 7zip to install
bitsadmin /transfer myDownloadJob /download /priority normal "https://onl-my.sharepoint.com/:u:/g/personal/mohammed_quashem_onlinesupport_co_uk/EelcjJGC2iJCvzkLf6HcexcBNSIroVOg4C1TUWYl_gPEdA?e=rCHixh&download=1" c:\temp\7zip.exe
c:\temp\7zip.exe
echo 7zip should now be installed.
echo Make sure to exit script properly from the task menu when all your installs are finished.
pause
cls
goto begin

:op2
echo You picked Chrome to install
bitsadmin /transfer myDownloadJob /download /priority normal "https://onl-my.sharepoint.com/:u:/g/personal/mohammed_quashem_onlinesupport_co_uk/EVs5aWd2s4pHmxM84QAn-0gBWyPNa2ceV2oMV3EX_qoHdw?e=FenBua&download=1" c:\temp\chrome.exe
c:\temp\chrome.exe 
echo Chrome should now be installed.
echo Make sure to exit script properly from the task menu when all your installs are finished.
pause
cls
goto begin

:op3
echo You picked Firefox to install
bitsadmin /transfer myDownloadJob /download /priority normal "https://onl-my.sharepoint.com/:u:/g/personal/mohammed_quashem_onlinesupport_co_uk/EdxEtnZPGExNvytS0enrNrcB20LVWtfouSkln7nHeNhhsQ?e=nWLSgJ&download=1" c:\temp\firefox.exe
c:\temp\firefox.exe 
echo Firefox should now be installed.
echo Make sure to exit script properly from the task menu when all your installs are finished.
pause
cls
goto begin

:op4
echo You picked Zoom to install
bitsadmin /transfer myDownloadJob /download /priority normal "https://zoom.us/client/latest/ZoomInstallerFull.msi" c:\temp\zoom.msi
c:\temp\zoom.msi
echo Zoom should now be installed.
echo Make sure to exit script properly from the task menu when all your installs are finished.
pause
cls
goto begin

:op5 
echo You picked Office 365 32Bit applications to install.
bitsadmin /transfer myDownloadJob /download /priority normal "https://onl-my.sharepoint.com/:u:/g/personal/mohammed_quashem_onlinesupport_co_uk/EZDouWC-DwBMkZLEpN_jwt8BcR7TOP4Lu6cZ3aupTLI85Q?e=H9Fn6C&download=1" c:\temp\office36532bit.exe
c:\temp\office36532bit.exe
echo Office365 32Bit should now be installed.
echo Make sure to exit script properly from the task menu when all your installs are finished.
pause
cls
goto begin

:op6
echo You picked Office 365 64Bit applications to install.
bitsadmin /transfer myDownloadJob /download /priority normal "https://onl-my.sharepoint.com/:u:/g/personal/mohammed_quashem_onlinesupport_co_uk/EcMz8PLiIbVGnrRx3qXH84cBeAle7L1MHvznYDGR0OdZfw?e=S2esid&download=1" c:\temp\office36564bit.exe
c:\temp\office36564bit.exe
echo Office365 64Bit should now be installed.
echo Make sure to exit script properly from the task menu when all your installs are finished.
pause
cls
goto begin

:op7
echo You picked SonicWALL NeteXtender to install.
bitsadmin /transfer myDownloadJob /download /priority normal "https://onl-my.sharepoint.com/:u:/g/personal/mohammed_quashem_onlinesupport_co_uk/EdZ4uMDO5y1JjqKCOOqNC0kBkjOHeF3Pg0_vVNXHfyJjBw?e=rcydPz&download=1" c:\temp\netextender.msi
c:\temp\netextender.msi
echo SonicWALL NeteXtender should now be installed.
echo Make sure to exit script properly from the task menu when all your installs are finished.
pause
cls
goto begin

:op8
echo You picked Mimecast for Outlook 32Bit to install.
bitsadmin /transfer myDownloadJob /download /priority normal "https://onl-my.sharepoint.com/:u:/g/personal/mohammed_quashem_onlinesupport_co_uk/EarIZeb9QQxHsU_eMdOJXtABDNQFUBIOBwxS73Gr-sDhjQ?e=PcpQDx&download=1" c:\temp\mimecast.msi
c:\temp\mimecast.msi
echo Mimecast for Outlook 32Bit should now be installed.
echo Make sure to exit script properly from the task menu when all your installs are finished.
pause
cls
goto begin

:op9
echo You picked GlobalVPN 64Bit to install.
bitsadmin /transfer myDownloadJob /download /priority normal "https://onl-my.sharepoint.com/:u:/g/personal/mohammed_quashem_onlinesupport_co_uk/EYgqBflNMCdNkZkJfgQEcoEBa3PBcoxpM-Edspuyhkgv3A?e=sSyBVV&download=1" c:\temp\globalvpn.msi
c:\temp\globalvpn.msi
echo GlobalVPN should now be installed.
echo Make sure to exit script properly from the task menu when all your installs are finished.
pause
cls
goto begin

:op50
cls
echo You've picked to close script, please confirm all installs are finished as this will clear any remaining exes that was used to complete it.
del c:\temp\7zip.exe
del c:\temp\chrome.exe
del c:\temp\firefox.exe
del c:\temp\zoom.msi
del c:\temp\office36532bit.exe
del c:\temp\office36564bit.exe
del c:\temp\netextender.msi
del c:\temp\mimecast.msi
del c:\temp\globalvpn.msi
cls
echo Cleanup should be done, close the prompt :D
pause
exit

:exit
@exit