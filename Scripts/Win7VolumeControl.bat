@echo off

net file 1>nul 2>nul && goto :run || powershell -ex unrestricted -Command "Start-Process -Verb RunAs -FilePath '%comspec%' -ArgumentList '/c %~fnx0 %*'"
goto :eof
:run

echo.

:choice
set /P c=Add REG key for Win7 Volume control panel?[Y/N]?
if /I "%c%" EQU "Y" goto :yes
if /I "%c%" EQU "N" goto :no
goto :choice

:yes
cls
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MTCUVC" /v EnableMtcUvc /t REG_DWORD /d 0
echo 64Bit Reg key added, please close the prompt and test the webcam works.
pause
exit

:no
cls
echo REG key will not be added. 
pause
exit