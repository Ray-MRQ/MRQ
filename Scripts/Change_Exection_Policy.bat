@echo off

net file 1>nul 2>nul && goto :run || powershell -ex unrestricted -Command "Start-Process -Verb RunAs -FilePath '%comspec%' -ArgumentList '/c %~fnx0 %*'"
goto :eof
:run


echo Modifying ExectionPolicy for Powershell

echo Select a task:
echo =============
echo 1) Change ExecutionPolicy to unrestricted
echo 2) Change ExecutionPolicy to restricted

echo.
echo.

:choice
set /P c=Choose a option:
if "%op%"=="1" goto op1
if "%op%"=="2" goto op2


:op1 
cls
powershell -command "& {Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force -scope localmachine}"
echo ExecutionPolicy changed to Unrestricted
pause
exit

:op2 
cls
powershell -command "& {Set-ExecutionPolicy -ExecutionPolicy Restricted -Force -scope localmachine}"
echo ExecutionPolicy changed to Restricted
pause
exit