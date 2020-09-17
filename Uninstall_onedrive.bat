@echo off

taskkill /f /im OneDrive.exe

:choice
set /P c=Is your PC 32bit or 64bit? (Type in 32 for 32bit and 64 for 64bit)
if /I "%c%" EQU "32" goto :32
if /I "%c%" EQU "64" goto :64
goto :choice


:32

%SystemRoot%\System32\OneDriveSetup.exe /uninstall
echo Onedrive should now be uninstalled
pause
exit

:64

%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
echo Onedrive should now be uninstalled
pause
exit