$File = "https://github.com/Ray-MRQ/MRQ/raw/master/Scripts/Install_Office365Apps.ps1"
mkdir c:\temp > $null 2>&1
mkdir c:\temp\scriptdownloads > $null 2>&1

powershell -command Invoke-WebRequest "$File" -outfile c:\temp\InstallOffice365apps.ps1
powershell -command "& {Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force}"
powershell c:\temp\InstallOffice365apps.ps1
powershell -command "& {Set-ExecutionPolicy -ExecutionPolicy Restricted -Force}"
Remove-Item c:\temp\InstallOffice365apps.ps1

Remove-Item c:\temp\scriptdownloads -recurse -force > $null 2>&1
exit