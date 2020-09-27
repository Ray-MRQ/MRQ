@echo off

net file 1>nul 2>nul && goto :run || powershell -ex unrestricted -Command "Start-Process -Verb RunAs -FilePath '%comspec%' -ArgumentList '/c %~fnx0 %*'"
goto :eof
:run

echo Modifying UAC.

:begin
echo Select a task:
echo =============
echo -
echo 1) Turn on UAC
echo 2) Use Dimmed UAC
echo 3) Turn off UAC

echo.
echo.

set /P c=Choose a option:

if "%op%"=="1" goto op1
if "%op%"=="2" goto op2
if "%op%"=="3" goto op3


:op1 
cls
reg ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 1 /f
echo May require a restart to take full effect.
pause
cls
goto begin

:op2
cls
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v PromptOnSecureDesktop /t reg_dword /d 0 /f
echo May require a restart to take full effect.
pause
cls
goto begin

:op3
cls
reg ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
echo May require a restart to take full effect.
pause
cls
goto begin

