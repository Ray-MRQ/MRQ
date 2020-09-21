@echo off
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
bitsadmin /transfer myDownloadJob /download /priority normal "https://onl-my.sharepoint.com/:u:/g/personal/mohammed_quashem_onlinesupport_co_uk/EUdAD4ToqqtOqD8oI6EeEycBZvLTSuK96di0MsuxoCTkvw?e=bDhL5E&download=1" c:\RunAsAdminContextMenupowershell.reg
reg import C:\RunAsAdminContextMenupowershell.reg
del "C:\RunAsAdminContextMenupowershell.reg"
echo "Check now with a .ps1 file and see if it appears in the context menu"
pause