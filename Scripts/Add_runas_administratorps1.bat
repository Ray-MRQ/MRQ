@echo off

net file 1>nul 2>nul && goto :run || powershell -ex unrestricted -Command "Start-Process -Verb RunAs -FilePath '%comspec%' -ArgumentList '/c %~fnx0 %*'"
goto :eof
:run

powershell -noprofile -command "Invoke-Webrequest https://github.com/Ray-MRQ/MRQ/raw/master/Regkeys_xmls/Add%20Run%20As%20Adminstrator%20PS.reg -outfile .\RunAsAdminContextMenupowershell.reg"
reg import .\RunAsAdminContextMenupowershell.reg
del ".\RunAsAdminContextMenupowershell.reg"
echo "Check now with a .ps1 file and see if it appears in the context menu"
pause