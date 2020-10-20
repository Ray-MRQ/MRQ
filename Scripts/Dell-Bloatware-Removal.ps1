if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}
Write-Output  "
____  __    _____    __   ____  _    _    __    ____  ____    ____  ____  __  __  _____  _  _  __    __   
(  _ \(  )  (  _  )  /__\ (_  _)( \/\/ )  /__\  (  _ \( ___)  (  _ \( ___)(  \/  )(  _  )( \/ )/__\  (  )  
 ) _ ( )(__  )(_)(  /(__)\  )(   )    (  /(__)\  )   / )__)    )   / )__)  )    (  )(_)(  \  //(__)\  )(__ 
(____/(____)(_____)(__)(__)(__) (__/\__)(__)(__)(_)\_)(____)  (_)\_)(____)(_/\/\_)(_____)  \/(__)(__)(____)"
Write-Output ''
Write-Output "Dell Bloatware Removal Version 2.0"
Write-Output ''

$UWPAppList = "DellInc.DellDigitalDelivery",
    "RivetNetworks.SmartByte",
    "5A894077.McAfeeSecurity",
    "DellInc.DellPowerManager",
    "DellInc.DellSupportAssistforPCs",
    "DellInc.PartnerPromo",
    "ScreenovateTechnologies.DellMobileConnect",
    "DellInc.MyDell",
    "DellInc.DellOptimizer",
    "DellInc.DellCustomerConnect"

$WMICApplist = "Dell Mobile Connect Drivers",
    "Dell SupportAssist Remediation",
    "SmartByte Drivers and Services",
    "Dell Update - SupportAssist Update Plugin",
    "Dell Update - SupportAssist",
    "Dell Digital Delivery Services"

$GUIDApplist = "{18469ED8-8C36-4CF7-BD43-0FC9B1931AF8}",
    "{2D27B76E-8FB1-495B-A61D-FB76349E7E36}", 
    "{75F60BB7-09E9-4555-BFF0-D1B6102A33DE}", 
    "{B336B590-DB14-438C-A473-2ECD4E193BFC}",
    "{4EA9855C-3339-4AE3-977B-6DF8A369469D}",
    "{E27862BD-4371-4245-896A-7EBE989B6F7F}",
    "{1906C253-4035-4CA5-A501-075E691CCEC9}",
    "{57CBE96A-3AA5-4421-A87C-6C6C3B6C5ECA}",
    "{C559D0AB-2D9E-4B59-B2B8-0C2061B3F9BC}",
    "{CC5730C7-C867-43BD-94DA-00BB3836906F}",
    "{CC611DE8-38C7-4650-968E-B973B254E98C}"  

function start-UWP-removal {
ForEach ($App in $UWPAppList) {
 $PackageFullName = (Get-AppxPackage $App -allusers).PackageFullName
 $ProPackageFullName = (Get-AppxProvisionedPackage -online | Where-Object {$_.Displayname -eq $App}).PackageName
 write-host $PackageFullName
 Write-Host $ProPackageFullName
 if ($PackageFullName)
 {
 Write-Host "Removing Package: $App"
 remove-AppxPackage -package $PackageFullName 
 }
 if ($ProPackageFullName)
 {
 Write-Host "Removing Provisioned Package: $ProPackageFullName"
 Remove-AppxProvisionedPackage -online -packagename $ProPackageFullName -allusers
}}
Write-Output "Removed UWP apps."
}

function start-WMIC-removal {
ForEach ($App in $WMICAppList) {
Start-Process -wait WMIC -ArgumentList '/MIN product where name=$App call uninstall /nointeractive'
}            
Write-Output "Removed apps using WMIC."
}

function start-GUID-removal {
ForEach ($App in $GUIDAppList) {
Start-Process msiexec.exe -Wait -ArgumentList '/qn /norestart /x $App'
}            
Write-Output "Removed apps using GUID."
}

############################################################################

function start-main-menu {
do { $myInput = (Read-Host 'Remove Dell bloatware?(Y/N)').ToLower() } while ($myInput -notin @('Y','N'))
if ($myInput -eq 'y') {
start-UWP-removal
Write-Output ''
start-WMIC-removal
Write-Output ''
start-GUID-removal
Write-Output ''
Write-Output "Completed bloatware removal."
pause
}
if ($myinput -eq 'n') {
Write-Output ''
Write-Output "Not removing bloatware removal."
Write-Output ''
pause
}}



#############################################################################

start-main-menu