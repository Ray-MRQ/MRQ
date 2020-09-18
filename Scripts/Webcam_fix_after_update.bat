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
echo This will add reg keys to fix webcam not working after update.
pause
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Media Foundation\Platform" /v EnableFrameServerMode /t REG_DWORD /d 0

:choice
set /P c=The second reg key is for 64Bit machines, would you like to apply this?[Y/N]?
if /I "%c%" EQU "Y" goto :yes
if /I "%c%" EQU "N" goto :no
goto :choice


:yes
cls
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows Media Foundation\Platform" /v EnableFrameServerMode /t REG_DWORD /d 0
echo 64Bit Reg key added, please close the prompt and test the webcam works.
pause
exit

:no
cls
echo 64Bit reg key will not be added, only the 32Bit key has been added, please close prompt. 
pause
exit