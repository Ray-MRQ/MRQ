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
    "DellInc.DellCustomerConnect"

$WMICApplist = "Dell Power Manager Service",
    "Dell Mobile Connect Drivers",
    "Dell SupportAssist Remediation",
    "SmartByte Drivers and Services",
    "Dell Update - SupportAssist Update Plugin",
    "Dell Update - SupportAssist",
    "Dell Digital Delivery Services"

$GUIDApplist = "{18469ED8-8C36-4CF7-BD43-0FC9B1931AF8}", #DellPowerManager
    "{2D27B76E-8FB1-495B-A61D-FB76349E7E36}", #Dell Mobile Connect
    "{75F60BB7-09E9-4555-BFF0-D1B6102A33DE}", #Dell Update Support assist
    "{B336B590-DB14-438C-A473-2ECD4E193BFC}", #Dell Update support assist update plugin
    "{CC611DE8-38C7-4650-968E-B973B254E98C}"  #Dell SupportAssst

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
Start-Process -wait WMIC -ArgumentList '/MIN product where name="Dell Digital Delivery Services" call uninstall /nointeractive'
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