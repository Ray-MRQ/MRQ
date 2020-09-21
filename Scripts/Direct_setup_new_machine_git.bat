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
mkdir c:\temp
powershell -command Invoke-WebRequest "https://github.com/Ray-MRQ/MRQ/raw/master/Scripts/Setup_new_machine.ps1" -outfile c:\temp\setup_new_machine.ps1
powershell -command "& {Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force}"
powershell c:\temp\setup_new_machine.ps1
pause
cls
echo Only press enter if you are done.
powershell -command "& {Set-ExecutionPolicy -ExecutionPolicy Restricted -Force}"
pause
del c:\temp\setup_new_machine.ps1
exit

