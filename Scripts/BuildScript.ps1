mkdir c:\temp
powershell -command Invoke-WebRequest "https://github.com/Ray-MRQ/MRQ/raw/master/Scripts/Setup_new_machine.ps1" -outfile c:\temp\setup_new_machine.ps1
powershell -command "& {Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force}"
powershell c:\temp\setup_new_machine.ps1
powershell -command "& {Set-ExecutionPolicy -ExecutionPolicy Restricted -Force}"
Remove-Item c:\temp\setup_new_machine.ps1
exit