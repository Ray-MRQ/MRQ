$File = "https://github.com/Ray-MRQ/MRQ/raw/master/Scripts/HP-Bloatware-removal.ps1"
mkdir c:\temp > $null 2>&1
mkdir c:\temp\scriptdownloads > $null 2>&1

powershell -command Invoke-WebRequest "$File" -outfile c:\temp\HP-Bloatware-Removal.ps1
powershell -command "& {Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force}"
powershell c:\temp\HP-Bloatware-Removal.ps1
powershell -command "& {Set-ExecutionPolicy -ExecutionPolicy Restricted -Force}"
Remove-Item c:\temp\HP-Bloatware-Removal.ps1

Remove-Item c:\temp\scriptdownloads -recurse -force > $null 2>&1
exit