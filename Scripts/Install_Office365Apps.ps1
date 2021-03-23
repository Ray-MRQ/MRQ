if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}
mkdir c:\temp > $null 2>&1
mkdir c:\temp\scriptdownloads > $null 2>&1

$OfficeExe = 'https://github.com/Ray-MRQ/MRQ/raw/master/Install%20files/setup.exe'
$OfficeXMLInstall = 'https://github.com/Ray-MRQ/MRQ/raw/master/Regkeys_xmls/configuration-Office365-x86.xml'
$OfficeXMLUninstall = 'https://github.com/Ray-MRQ/MRQ/raw/master/Regkeys_xmls/configruation_uninstall.xml'
$OfficeXMLHomeUninstall = 'https://github.com/Ray-MRQ/MRQ/raw/master/Regkeys_xmls/configuration_uninstall_home.xml'
$OfficeXMLBuisnessUninstall = 'https://github.com/Ray-MRQ/MRQ/raw/master/Regkeys_xmls/configuration_uninstall_buisness.xml'

function start-officecheck {
    start-officeuninstall-pro
    start-officeuninstall-buisness
    start-officeuninstall-home
    start-officeinstall
    }
}
    
function start-officeuninstall-pro {
    Write-Output ''
    do { $myInput = (Read-Host 'Would you like to uninstall Office365?(Y/N)').ToLower() } while ($myInput -notin @('y','n'))
    if ($myinput -eq 'y') {
    Write-Output ''
    Write-Output "Starting uninstall process..."
    Write-Output ''
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest $OfficeExe -outfile c:\temp\scriptdownloads\office365setup.exe
    Invoke-WebRequest $OfficeXMLUninstall -outfile c:\temp\scriptdownloads\office365uninstall.xml
    $ProgressPreference = 'Continue'
    c:\temp\scriptdownloads\office365setup.exe /configure c:\temp\scriptdownloads\office365uninstall.xml
    }
}
 
function start-officeuninstall-buisness {
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest $OfficeExe -outfile c:\temp\scriptdownloads\office365setup.exe
    Invoke-WebRequest $OfficeXMLBuisnessUninstall -outfile c:\temp\scriptdownloads\office365uninstallbuisness.xml
    $ProgressPreference = 'Continue'
    c:\temp\scriptdownloads\office365setup.exe /configure c:\temp\scriptdownloads\office365uninstallbuisness.xml
    Write-Output "Office365 ProPlus should be uninstalled."
    Write-Output ''
    pause
    Write-Output ''
    Clear-Host
    }

function start-officeuninstall-home {
    Write-Output ''
    do { $myInput = (Read-Host 'Would you like to uninstall Office365?(Y/N)').ToLower() } while ($myInput -notin @('y','n'))
    if ($myinput -eq 'y') {
    Write-Output ''
    Write-Output "Starting uninstall process..."
    Write-Output ''
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest $OfficeExe -outfile c:\temp\scriptdownloads\office365setup.exe
    Invoke-WebRequest $OfficeXMLHomeUninstall -outfile c:\temp\scriptdownloads\office365uninstallhome.xml
    $ProgressPreference = 'Continue'
    c:\temp\scriptdownloads\office365setup.exe /configure c:\temp\scriptdownloads\office365uninstallhome.xml
    Write-Output "Office365 ProPlus should be uninstalled."
    Write-Output "If not, use option 12 and use the support tool to uninstall."
    Write-Output ''
    pause
    Write-Output ''
    Clear-Host
    }
}
    
function start-officeinstall {
    Write-Output ''
    do { $myInput = (Read-Host 'Would you like to install Office365?(Y/N)').ToLower() } while ($myInput -notin @('y','n'))
    if ($myInput -eq 'y') {
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
    Write-Output ''
    Write-Output "Office365 is now installed."
    pause
}}

Write-Output "Install Office365 Apps (32Bit only)"
Write-Output "####################"
Write-Output ''
Write-Output "Checking if Office365 is installed...."
start-officecheck
