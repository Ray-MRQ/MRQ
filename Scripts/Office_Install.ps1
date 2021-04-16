
$OfficeExe = 'https://github.com/Ray-MRQ/MRQ/raw/master/Install%20files/setup.exe'
$OfficeXMLInstall = 'https://github.com/Ray-MRQ/MRQ/raw/master/Regkeys_xmls/configuration-Office365-x86.xml'
$OfficeXMLUninstall = 'https://github.com/Ray-MRQ/MRQ/raw/master/Regkeys_xmls/configruation_uninstall.xml'
$OfficeXMLHomeUninstall = 'https://github.com/Ray-MRQ/MRQ/raw/master/Regkeys_xmls/configuration_uninstall_home.xml'
$OfficeXMLBuisnessUninstall = 'https://github.com/Ray-MRQ/MRQ/raw/master/Regkeys_xmls/configuration_uninstall_buisness.xml'

function start-officecheck {
do { $myInput = (Read-Host 'Would you like to install Office365?(Y/N)').ToLower() } while ($myInput -notin @('y','n'))
if ($myInput -eq 'y') {
start-officeuninstall-pro
start-officeuninstall-buisness
start-officeuninstall-home
start-officeinstall
else {Write-Host "Will not install office."
exit
}}}

function start-officeuninstall-pro {
Write-Output ''
Write-Output "Starting uninstall process for all Office versions..."
Write-Output "Please wait."
Write-Output ''
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest $OfficeExe -outfile c:\temp\downloads\office365setup.exe
Invoke-WebRequest $OfficeXMLUninstall -outfile c:\temp\downloads\office365uninstall.xml
$ProgressPreference = 'Continue'
c:\temp\downloads\office365setup.exe /configure c:\temp\downloads\office365uninstall.xml
Write-Output "Office apps should be uninstalled."
Write-Output ''
}
 
function start-officeuninstall-buisness {
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest $OfficeExe -outfile c:\temp\downloads\office365setup.exe
Invoke-WebRequest $OfficeXMLBuisnessUninstall -outfile c:\temp\downloads\office365uninstallbuisness.xml
$ProgressPreference = 'Continue'
c:\temp\downloads\office365setup.exe /configure c:\temp\downloads\office365uninstallbuisness.xml
}

function start-officeuninstall-home {
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest $OfficeExe -outfile c:\temp\downloads\office365setup.exe
Invoke-WebRequest $OfficeXMLHomeUninstall -outfile c:\temp\downloads\office365uninstallhome.xml
$ProgressPreference = 'Continue'
c:\temp\downloads\office365setup.exe /configure c:\temp\downloads\office365uninstallhome.xml
}
    
function start-officeinstall {
Write-Output "Starting Office 365 install silently...."
Write-Output ''
Write-Output "Downloading and installing Office365"
Write-Output ''
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest $OfficeExe -outfile c:\temp\downloads\office365setup.exe
Invoke-WebRequest $OfficeXMLInstall -outfile c:\temp\downloads\configuration.xml
$ProgressPreference = 'Continue'
c:\temp\downloads\office365setup.exe /configure c:\temp\downloads\configuration.xml
Write-Output "Office365 is now installed."
Copy-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Outlook.lnk" -Destination "C:\Users\Public\Desktop\Outlook.lnk"
Copy-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Excel.lnk" -Destination "C:\Users\Public\Desktop\Excel.lnk"
Copy-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Powerpoint.lnk" -Destination "C:\Users\Public\Desktop\Powerpoint.lnk"
Copy-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Word.lnk" -Destination "C:\Users\Public\Desktop\Word.lnk"
}

start-officecheck