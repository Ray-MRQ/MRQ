@echo off

net file 1>nul 2>nul && goto :run || powershell -ex unrestricted -Command "Start-Process -Verb RunAs -FilePath '%comspec%' -ArgumentList '/c %~fnx0 %*'"
goto :eof
:run

bitsadmin /transfer myDownloadJob /download /priority normal "https://onl-my.sharepoint.com/:u:/g/personal/mohammed_quashem_onlinesupport_co_uk/EUdAD4ToqqtOqD8oI6EeEycBZvLTSuK96di0MsuxoCTkvw?e=bDhL5E&download=1" c:\RunAsAdminContextMenupowershell.reg
reg import C:\RunAsAdminContextMenupowershell.reg
del "C:\RunAsAdminContextMenupowershell.reg"
echo "Check now with a .ps1 file and see if it appears in the context menu"
pause