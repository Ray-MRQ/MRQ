mkdir c:\temp > $null 2>&1
Remove-Item c:\temp\scriptdownloads -recurse -force > $null 2>&1
mkdir c:\temp\scriptdownloads > $null 2>&1

$OfficeExe = 'https://github.com/Ray-MRQ/MRQ/raw/master/Install%20files/setup.exe'
$OfficeXMLInstall = 'https://github.com/Ray-MRQ/MRQ/raw/master/Regkeys_xmls/configuration-Office365-x86.xml'
$OfficeXMLUninstall = 'https://github.com/Ray-MRQ/MRQ/raw/master/Regkeys_xmls/configruation_uninstall.xml'
$OfficeXMLHomeUninstall = 'https://github.com/Ray-MRQ/MRQ/raw/master/Regkeys_xmls/configuration_uninstall_home.xml'

function start-officecheck {
$uninstallKeys = Get-ChildItem -Path "HKLM:HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
$O365 = "Microsoft 365"
$O365Check = $uninstallKeys | Where-Object { $_.GetValue("DisplayName") -match $O365 }
    
$uninstallKeysHome = Get-ChildItem -Path "HKLM:HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
$O365Home = "Microsoft Office 365"
$O365CheckHome = $uninstallKeysHome | Where-Object { $_.GetValue("DisplayName") -match $O365Home }
    
$O365Installed = Write-Output "Office 365 installation has been detected."
$O365NotInstalled = Write-Output "Office 365 is not installed."
 
if ($O365Check) {
$O365Installed
start-officeuninstall-pro
start-officeinstall
}
if ($O365CheckHome) {
start-officeuninstall-home
start-officeuninstall-pro
start-officeinstall
}
else {
$O365NotInstalled
Write-Output ''
start-officeinstall
}
}

    
function start-officeuninstall-pro {
Write-Output ''
Write-Output "Starting uninstall process for Pro Version..."
Write-Output ''
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest $OfficeExe -outfile c:\temp\scriptdownloads\office365setup.exe
Invoke-WebRequest $OfficeXMLUninstall -outfile c:\temp\scriptdownloads\office365uninstall.xml
$ProgressPreference = 'Continue'
c:\temp\scriptdownloads\office365setup.exe /configure c:\temp\scriptdownloads\office365uninstall.xml
Write-Output "Office365 ProPlus should be uninstalled."
Write-Output ''
Write-Output ''
}
    
function start-officeuninstall-home {
Write-Output ''
Write-Output ''
Write-Output "Starting uninstall process for Home Version..."
Write-Output ''
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest $OfficeExe -outfile c:\temp\scriptdownloads\office365setup.exe
Invoke-WebRequest $OfficeXMLHomeUninstall -outfile c:\temp\scriptdownloads\office365uninstallhome.xml
$ProgressPreference = 'Continue'
c:\temp\scriptdownloads\office365setup.exe /configure c:\temp\scriptdownloads\office365uninstallhome.xml
Write-Output "Office365 ProPlus should be uninstalled."
Write-Output ''
}
    
function start-officeinstall {
Write-Output ''
Write-Output "Starting Office 365 install silently...."
Write-Output ''
Write-Output "Downloading and installing Office365"
Write-Output ''
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest $OfficeExe -outfile c:\temp\scriptdownloads\office365setup.exe
Invoke-WebRequest $OfficeXMLInstall -outfile c:\temp\scriptdownloads\configuration.xml
$ProgressPreference = 'Continue'
c:\temp\scriptdownloads\office365setup.exe /configure c:\temp\scriptdownloads\configuration.xml
Write-Output "Office365 is now installed."
}

start-officecheck

Remove-Item c:\temp\scriptdownloads -recurse -force > $null 2>&1