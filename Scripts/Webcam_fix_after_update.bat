@echo off

net file 1>nul 2>nul && goto :run || powershell -ex unrestricted -Command "Start-Process -Verb RunAs -FilePath '%comspec%' -ArgumentList '/c %~fnx0 %*'"
goto :eof
:run

echo This will add reg keys to fix webcam not working after update.
pause
cls

REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Media Foundation\Platform" /v EnableFrameServerMode /t REG_DWORD /d 0

echo.

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