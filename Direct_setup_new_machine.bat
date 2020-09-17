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
cls
echo Logon as administrator or this will error out.
echo If your having trouble, download the file manually store in c:\temp and then run this again.
echo "https://onl-my.sharepoint.com/:u:/g/personal/mohammed_quashem_onlinesupport_co_uk/EWjxSgJkryRAh3Pe3l8sGlsBqdWV1N1h6URgBhCvkdsmeg?e=0hcgyh&download=1"
pause
mkdir c:\temp
bitsadmin /transfer myDownloadJob /download /priority normal "https://onl-my.sharepoint.com/:u:/g/personal/mohammed_quashem_onlinesupport_co_uk/EWjxSgJkryRAh3Pe3l8sGlsBqdWV1N1h6URgBhCvkdsmeg?e=0hcgyh&download=1" c:\temp\setup_new_machine.ps1
powershell -command "& {Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force}"
powershell c:\temp\setup_new_machine.ps1
cls
echo Only press enter if you are done.
echo (This batch script downloads a ps1 script and then runs it directly.)
echo (Continuning only deletes the .ps1 script).
pause
del c:\temp\setup_new_machine.ps1
exit

