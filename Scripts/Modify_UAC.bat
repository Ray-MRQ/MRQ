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
echo Modifying UAC.

:begin
echo Select a task:
echo =============
echo -
echo 1) Turn on UAC
echo 2) Use Dimmed UAC
echo 3) Turn off UAC

if "%op%"=="1" goto op1
if "%op%"=="2" goto op2
if "%op%"=="3" goto op3

echo Please pick a task
goto begin

:op1 

reg ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 1 /f
echo May require a restart to take full effect.
pause
cls
goto begin

:op2

reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v PromptOnSecureDesktop /t reg_dword /d 0 /f
echo May require a restart to take full effect.
pause
cls
goto begin

:op3

reg ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
echo May require a restart to take full effect.
pause
cls
goto begin

