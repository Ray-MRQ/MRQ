if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}

# Uninstall applications if they already exist.
$ProgressPreference = 'SilentlyContinue'
C:\Windows10Upgrade\Windows10UpgraderApp.exe /ForceUninstall > $null 2>&1
Remove-Item C:\Windows10Upgrade\*.* -recurse -force > $null 2>&1
Get-InstalledModule -Name PendingReboot | Uninstall-Module > $null 2>&1
Get-InstalledModule -Name PSWindowsUpdate | Uninstall-Module > $null 2>&1
Get-InstalledModule -Name Nuget | Uninstall-Module > $null 2>&1
$ProgressPreference = 'Continue'
cls

#The below are "functions" so they only act as reference  for the Main menu to run commands. The actual script starts from the bottom and then references everything else above."

$createdby = echo "==================================Created By MQ 08/09/2020================================"
$verifiedby = echo "=================================Verified By XX XX/XX/XXXX================================"
$lastupdatedby = echo "===============================Last Updated By MQ 02/10/2020=============================="

$WindowsVerison = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").ReleaseId
$LatestWindows = '2004' #Current Windows verison
$OldWindows = '1909' #Anything under 1909 or equal to

#Download links.

$OfficeExe = 'https://github.com/Ray-MRQ/MRQ/raw/master/Install%20files/setup.exe'
$OfficeXMLInstall = 'https://github.com/Ray-MRQ/MRQ/raw/master/Regkeys_xmls/configuration-Office365-x86.xml'
$OfficeXMLUninstall = 'https://github.com/Ray-MRQ/MRQ/raw/master/Regkeys_xmls/configruation_uninstall.xml'
$OfficeXMLHomeUninstall = 'https://github.com/Ray-MRQ/MRQ/raw/master/Regkeys_xmls/configuration_uninstall_home.xml'
$OfficeUninstallTool = 'https://outlookdiagnostics.azureedge.net/sarasetup/SetupProd_OffScrub.exe'
$SoftwareSilentInstallFile = 'https://github.com/Ray-MRQ/MRQ/raw/master/Install%20files/ninite-silent.exe'
$SoftwareInstallFile = 'https://github.com/Ray-MRQ/MRQ/raw/master/Install%20files/Ninite%207Zip%20Chrome%20Foxit%20Reader%20Installer.exe'
$SoftwareInstallZoomFile = 'https://github.com/Ray-MRQ/MRQ/raw/master/Install%20files/ZoomInstallerFull.msi' 
$DefaultAppPre1909= 'https://github.com/Ray-MRQ/MRQ/raw/master/Regkeys_xmls/Pre1909DefaultAppAssociations.xml'
$DefaultApp = 'https://github.com/Ray-MRQ/MRQ/raw/master/Regkeys_xmls/2004AppAssociations.xml'
$MimecastInstall = 'https://github.com/Ray-MRQ/MRQ/raw/master/Install%20files/Mimecast%20for%20Outlook%207.0.1740.17532%20(32%20bit).msi'
$GlobalVPNInstall = 'https://github.com/Ray-MRQ/MRQ/raw/master/Install%20files/GVCInstall64.msi'
$NeteXtenderInstall= 'https://github.com/Ray-MRQ/MRQ/raw/master/Install%20files/NetExtender.8.6.265.MSI'
$BloatwareRemoverWin10 = 'https://github.com/Ray-MRQ/MRQ/raw/master/Scripts/Uninstall_windows10_bloatware_apps.ps1'
$HPBloatwareRemover = 'https://github.com/Ray-MRQ/MRQ/raw/master/Scripts/HP-Bloatware-Removal-Auto.bat'
$PhotoviewerInstall = 'https://github.com/Ray-MRQ/MRQ/raw/master/Regkeys_xmls/Restore_Windows_Photo_Viewer_ALL_USERS.reg'
$RunAsAdministratorPS = 'https://github.com/Ray-MRQ/MRQ/raw/master/Regkeys_xmls/Add%20Run%20As%20Adminstrator%20PS.reg'


##############################################################################
	
function main-menu {
""
echo "Option 1: Automated/ineractive install."
echo "Option 2: Manual select install"
echo "Option 3: Exit installer"
""
do { $myInput = (Read-Host 'Type an option').ToLower() } while ($myInput -notin @('1','2','3'))
if ($myinput -eq '1') {start-script}
if ($myinput -eq '2') {manual-script}
if ($myinput -eq '3') {end-script}}

function start-softwareinstall {
echo "Removing & creating directory in C:\temp\scriptdownloads..."
mkdir c:\temp > $null 2>&1
Remove-Item c:\temp\scriptdownloads -recurse -force > $null 2>&1
mkdir c:\temp\scriptdownloads > $null 2>&1
echo "============================================================================="
cl
$createdby
$verifiedby
$lastupdatedby
""
echo "For software, the following will be installed."
echo "Uninstall the ones you do not require as neeeded."
""
""
echo 7Zip Chrome "Foxit Reader (equivlant to Adobe reader but allows editing.)" "Office365 Applications 32Bit" "Zoom (Optional)"  "NeteXtender or GlobalVPN (optional)" "Mimecast for Outlook32Bit (optional)" 
""
echo "Please confirm below."
""
pause
cl
#=====================================================

$uninstallKeys = Get-ChildItem -Path "HKLM:HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
$O365 = "Microsoft 365"
$O365Check = $uninstallKeys | Where-Object { $_.GetValue("DisplayName") -match $O365 }

$uninstallKeysHome = Get-ChildItem -Path "HKLM:HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
$O365Home = "Microsoft Office 365"
$O365CheckHome = $uninstallKeysHome | Where-Object { $_.GetValue("DisplayName") -match $O365Home }

$O365Installed = echo "Office 365 is installed."
$O365NotInstalled = echo "Office 365 is not installed."
if ($O365Check) {
$O365Installed
""
start-officeuninstall
}
if ($O365CheckHome) {
start-officeuninstall
}
else {
$O365NotInstalled
""
start-officeinstall
}
""
echo "Starting download for applications.."
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest $SoftwareSilentInstallFile -outfile c:\temp\scriptdownloads\silentinstall.exe
Invoke-WebRequest $SoftwareInstallFile -outfile c:\temp\scriptdownloads\ninite.exe
$ProgressPreference = 'Continue'
c:\temp\scriptdownloads\silentinstall.exe
""
echo "Installed 7zip, Chrome and Foxit reader silently."
""
Start-Sleep -seconds 30
do { $myInput = (Read-Host 'Would you like to install Zoom?(Y/N)').ToLower() } while ($myInput -notin @('y','n'))
if ($myInput -eq 'y') {
""
echo "Starting Zoom download..."
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest $SoftwareInstallZoomFile -outfile c:\temp\scriptdownloads\ZoomInstaller.msi
$ProgressPreference = 'Continue'
msiexec /i c:\temp\scriptdownloads\ZoomInstaller.msi /qn+ /norestart allusers=2
echo "Wait for a dialogue box to appear then continue."
}}

function start-officeuninstall {
""
do { $myInput = (Read-Host 'Would you like to uninstall Office365?(Y/N)').ToLower() } while ($myInput -notin @('y','n'))
if ($myinput -eq 'y') {
""
echo "Starting uninstall process..."
""
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest $OfficeExe -outfile c:\temp\scriptdownloads\office365setup.exe
Invoke-WebRequest $OfficeXMLUninstall -outfile c:\temp\scriptdownloads\office365uninstall.xml
Invoke-WebRequest $OfficeXMLHomeUninstall -outfile c:\temp\scriptdownloads\office365uninstallhome.xml
$ProgressPreference = 'Continue'
c:\temp\scriptdownloads\office365setup.exe /configure c:\temp\scriptdownloads\office365uninstall.xml
c:\temp\scriptdownloads\office365setup.exe /configure c:\temp\scriptdownloads\office365uninstallhome.xml
echo "Office365 ProPlus should be uninstalled."
echo "If not, use option 12 and use the support tool to uninstall."
""
pause
""
cl
""
start-officeinstall
echo "If you need the shortcuts use option 9."
""
echo "Please continue."
pause
cl
""
}
}

function start-officeinstall {
cl
do { $myInput = (Read-Host 'Would you like to install Office365?(Y/N)').ToLower() } while ($myInput -notin @('y','n'))
if ($myInput -eq 'y') {
""
echo "Starting Office 365 install silently...."
""
echo "Please wait..."
""
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest $OfficeExe -outfile c:\temp\scriptdownloads\office365setup.exe
Invoke-WebRequest $OfficeXMLInstall -outfile c:\temp\scriptdownloads\configuration.xml
$ProgressPreference = 'Continue'
c:\temp\scriptdownloads\office365setup.exe /configure c:\temp\scriptdownloads\configuration.xml
}}

function start-officeuninstalltool {
echo "Office applications uninstall tool, with will open up an app."
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest $OfficeUninstallTool -outfile C:\temp\scriptdownloads\officeuninstall.exe
$ProgressPreference = 'Continue'
""
echo "Downloading Office uninstall tool..."
""
echo "Done, starting Office uninstall tool."
C:\temp\scriptdownloads\officeuninstall.exe
""
echo "Go through the prompts then continue."
pause
cl
}

function start-mimecastinstall {
cl
do { $myInput = (Read-Host 'Would you like to install Mimecast for Outlook 32Bit?(Y/N)').ToLower() } while ($myInput -notin @('y','n'))
if ($myInput -eq 'y') {
""
echo "Downloading & installing Mimecast for Outlook..."
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest $MimecastInstall -outfile c:\temp\scriptdownloads\mimecast32bit.msi
$ProgressPreference = 'Continue'
msiexec /i "c:\temp\scriptdownloads\mimecast32bit.msi" /qn+ /norestart allusers=2
""
echo "Wait for a dialogue box to appear then continue. (If Mimecast for Outlook is already installed it will not appear)."
""
pause
""
netsh advfirewall firewall add rule name="Mimecast.Services.Windows.Personal" dir=in action=allow program="C:\program files (x86)\mimecast\mimecast windows service\msddsk.exe" enable=yes
echo "Adding firewall rule..."
echo "Mimecast for Outlook should now be installed."
} else {
echo "Mimecast for Outlook32Bit will not be installed..."
echo "Please continue."
""
}}

function start-vpninstall {
cl
#Start-Sleep -seconds 120
do { $myInput = (Read-Host 'Would you like to install GlobalVPN or NeteXtender? Or none? (Global/Net/N)').ToLower() } while ($myInput -notin @('global','net','N'))
if ($myInput -eq 'global') {
""
echo "Downloading & installing GlobalVPN..."
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest $GlobalVPNInstall -outfile c:\temp\scriptdownloads\gvcinstall64.msi
$ProgressPreference = 'Continue'
msiexec.exe /i "C:\temp\scriptdownloads\gvcinstall64.msi" /qn+ /norestart allusers=2
""
echo "Wait for a dialogue box to appear then continue."
pause
echo "GlobalVPN should now be installed."
""
echo "Sending GlobalVPN shortcut to desktop..."
""
Copy-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Global VPN Client.lnk" -Destination "C:\Users\Public\Desktop\Global VPN Client.lnk"
""
}
if ($myinput -eq 'net') {
""
echo "Downloading & installing NeteXtender..."
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest $NeteXtenderInstall -outfile c:\temp\scriptdownloads\netextender.msi
$ProgressPreference = 'Continue'
msiexec /i "C:\temp\scriptdownloads\netextender.msi" /qn+ /norestart allusers=2
""
echo "Wait for a dialogue box to appear then continue."
pause
""
echo "NeteXtender should now be installed."
echo "Please continue."
""
}
if ($myinput -eq 'N') {
""
echo "Will not install NeteXtender or Global VPN."
""
echo "Please continue."
""
}}

function start-bloatwareremover {
cl
$OriginalPref = $ProgressPreference # Default is 'Continue'
$ProgressPreference = "SilentlyContinue"
#Windows10 Apps bloatware remover
""
echo "Before going ahead, please make sure you choose the correct option."
echo "If you get any errors, (red lines) this may be due to multiple profiles."
echo "Use option user on that profile if that is the case."
echo "Otherwise option y should work fine."
""
do { $myInput = (Read-Host 'Please confirm with (Y/N/User) if you would like to remove Windows10Bloatware apps').ToLower() } while ($myInput -notin @('y','n','user'))
if ($myInput -eq 'y') {
$AppList = "Microsoft.SkypeApp",          
           "Microsoft.ZuneMusic",
           "Microsoft.ZuneVideo",
           "Microsoft.Office.OneNote",
           "Microsoft.BingFinance",
           "Microsoft.BingNews",
           "Microsoft.BingWeather",
           "Microsoft.BingSports",
           "Microsoft.XboxApp",
           "Microsoft.MicrosoftOfficeHub",
		   "Microsoft.Wallet",
		   "Microsoft.OneConnect",
		   "Microsoft.MSPaint",
		   "Microsoft.Print3D",
		   "Microsoft.Messaging",
		   "Microsoft.Microsoft3DViewer",
		   "Microsoft.Windows.Cortana",
		   "Microsoft.3DBuilder",
		   "Microsoft.WindowsAlarms",
		   "Microsoft.windowscommunicationsapps",
		   "Microsoft.Getstarted",
		   "Microsoft.WindowsMaps",
		   "Microsoft.MicrosoftSolitaireCollection",
		   "Microsoft.WindowsFeedbackHub",
		   "Microsoft.MixedReality.Portal",
		   "Microsoft.GetHelp",
		   "Microsoft.People",
		   "Microsoft.549981C3F5F10",
		   "Microsoft.549981cf5f10",
		   "Microsoft.Xbox.TCUI",
		   "Microsoft.XboxSpeechToTextOverlay",
		   "Microsoft.XboxGamingOverlay",
		   "AD2F1837.HPSupportAssistant",
		   "AD2F1837.HPPCHardwareDiagnosticsWindows",
		   "AD2F1837.HPSureShieldAI",
		   "AD2F1837.HPPrivacySettings",
		   "AD2F1837.HPJumpStarts",
		   "AD2F1837.HPPowerManager",
		   "Microsoft.XboxGameOverlay",
		   "SpotifyAB.SpotifyMusic"
ForEach ($App in $AppList)
{
$PackageFullName = (Get-AppxPackage $App -allusers).PackageFullName
$ProPackageFullName = (Get-AppxProvisionedPackage -online | where {$_.Displayname -eq $App}).PackageName
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
}
}
start-bloatware-user-allusers
cl
echo "Completed."
""
#echo "Word of note, Cortana may not remove on first attempt."
#echo "Re-run the removal tool from the manual install menu using option 4."
""
pause
""
cl
$ProgressPreference = $OriginalPref
echo "Windows 10 Bloatware apps removed..."
echo "------"
cl
}
if ($myinput -eq 'user') {
Invoke-WebRequest $BloatwareRemoverWin10 -outfile "C:\temp\scriptdownloads\bloatwareremover.ps1"
start-bloatware-user-allusers
""
echo "This is for removing bloatware in user context instead of administrator."
$User = Read-Host -Prompt 'Enter username (the person who the machine is for)'
""
runas /noprofile /user:$env:computername\$user "powershell C:\temp\scriptdownloads\bloatwareremover.ps1"
""
echo "Please close the prompt once finished."
""
pause
cl
}
if ($myinput -eq 'n') {
echo "windows 10 Bloatware apps will not be removed..."
echo "Please continue."
cl
}
}

function start-bloatware-user-allusers {
    #Stops Cortana from being used as part of your Windows Search Function
    $Search = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
    If (Test-Path $Search) {
        Set-ItemProperty $Search AllowCortana -Value 0 
    }
    #Disables Web Search in Start Menu
    $WebSearch = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" BingSearchEnabled -Value 0 
    If (!(Test-Path $WebSearch)) {
        New-Item $WebSearch
    }
    Set-ItemProperty $WebSearch DisableWebSearch -Value 1 
""
Invoke-Command {reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f}
Invoke-Command {reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f}
Invoke-Command {reg add HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer\ /v DisableSearchBoxSuggestions /t reg_dword /d 1 /f}
Invoke-Command {reg add HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v ShowTaskViewButton /t reg_dword /d 0 /f}
Invoke-Command {reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Search /v SearchboxTaskbarMode /t red_dword /d 0 /f}
Invoke-Command {reg add HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explore /v HidePeopleBar /t reg_dword /d 1 /f}
""
echo "Refreshed screen to apply."
Stop-Process -name explorer -Force
echo "Done."
}

function start-hpbloatwareremoval {
#HP Crapware
cl
do { $myInput = (Read-Host 'Is this a HP workstation/laptop? If so would you like to remove bloatware for this as well? (Y/N)').ToLower() } while ($myInput -notin @('y','n'))
if ($myInput -eq 'y') {
echo "This may take a while..."
Invoke-WebRequest $HPBloatwareRemover -outfile c:\temp\scriptdownloads\hpbloatwareremoval.bat
Invoke-Expression -Command "cmd.exe /c c:\temp\scriptdownloads\hpbloatwareremoval.bat"
""
echo "HP Bloatware has been removed or at least attempted to remove most."
""
echo "If you did come accross some HP crapware that wasn't removed let me know please? (MQ)"
""
pause
} else {
echo 'Not removing Bloatware for HP workstation/laptop...'
}
cl
}

function start-shortcuts-default-apps {
echo "This part of the script is for changing default apps & shortcuts for Office."
""
echo "Default apps only apply to new profiles. If the profile for the new user already exists,"
echo "Change default apps manaully from settings or re-create profile."
""
pause
if ($WindowsVersion -le '1909') { 
Invoke-WebRequest $DefaultAppPre1909 -outfile c:\temp\scriptdownloads\MyDefaultAppAssociations.xml 
dism /online /Import-DefaultAppAssociations:"c:\temp\scriptdownloads\MyDefaultAppAssociations.xml" }
else {
Invoke-WebRequest $DefaultApp -outfile c:\temp\scriptdownloads\MyDefaultAppAssociations.xml
dism /online /Import-DefaultAppAssociations:"c:\temp\scriptdownloads\MyDefaultAppAssociations.xml" }
echo "Sending office shortcuts to desktop..."
#Add any shortcuts needed for the above here. It just copies from Start menu to public desktop.
Remove-Item "C:\Users\Public\Desktop\Foxit Reader.lnk" -force > $null 2>&1
Copy-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Outlook.lnk" -Destination "C:\Users\Public\Desktop\Outlook.lnk"
Copy-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Excel.lnk" -Destination "C:\Users\Public\Desktop\Excel.lnk"
Copy-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Powerpoint.lnk" -Destination "C:\Users\Public\Desktop\Powerpoint.lnk"
Copy-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Word.lnk" -Destination "C:\Users\Public\Desktop\Word.lnk"
echo "Done."
""
}

function start-clearstartmenu {
cl
#Clear start menu
echo "Would you like to remove tiles and taskbar applications on the start menu? "
echo "This will become a default setting for new and current users"
""
do { $myInput = (Read-Host 'Choose an option, (Y/N)').ToLower() } while ($myInput -notin @('y','n'))
if ($myInput -eq 'y') {
echo "Modiying start menu & taskbar settings."
""
$START_MENU_LAYOUT = @"
<LayoutModificationTemplate xmlns:defaultlayout="http://schemas.microsoft.com/Start/2014/FullDefaultLayout" xmlns:start="http://schemas.microsoft.com/Start/2014/StartLayout" Version="1" xmlns:taskbar="http://schemas.microsoft.com/Start/2014/TaskbarLayout" xmlns="http://schemas.microsoft.com/Start/2014/LayoutModification">
    <LayoutOptions StartTileGroupCellWidth="6" />
    <DefaultLayoutOverride>
        <StartLayoutCollection>
            <defaultlayout:StartLayout GroupCellWidth="6" />
        </StartLayoutCollection>
    </DefaultLayoutOverride>
    <CustomTaskbarLayoutCollection PinListPlacement="Replace">
      <defaultlayout:TaskbarLayout>
        <taskbar:TaskbarPinList>
          <taskbar:DesktopApp DesktopApplicationLinkPath="C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Google Chrome.lnk" />
		  <taskbar:DesktopApp DesktopApplicationLinkPath="C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Outlook.lnk" />
		  <taskbar:DesktopApp DesktopApplicationLinkPath="%APPDATA%\Microsoft\Windows\Start Menu\Programs\System Tools\File Explorer.lnk" />
        </taskbar:TaskbarPinList>
      </defaultlayout:TaskbarLayout>
    </CustomTaskbarLayoutCollection>
</LayoutModificationTemplate>
"@

$layoutFile="C:\Windows\StartMenuLayout.xml"

#Delete layout file if it already exists
If(Test-Path $layoutFile)
{
    Remove-Item $layoutFile
}

#Creates the blank layout file
$START_MENU_LAYOUT | Out-File $layoutFile -Encoding ASCII

$regAliases = @("HKLM", "HKCU")

#Assign the start layout and force it to apply with "LockedStartLayout" at both the machine and user level
foreach ($regAlias in $regAliases){
    $basePath = $regAlias + ":\SOFTWARE\Policies\Microsoft\Windows"
    $keyPath = $basePath + "\Explorer" 
    IF(!(Test-Path -Path $keyPath)) { 
        New-Item -Path $basePath -Name "Explorer"
    }
    Set-ItemProperty -Path $keyPath -Name "LockedStartLayout" -Value 1
    Set-ItemProperty -Path $keyPath -Name "StartLayoutFile" -Value $layoutFile
}
echo "==========================================================================="
echo "Complete... restarting proccesses"
echo "==========================================================================="
echo "This will refresh your screen..."
cl
Stop-Process -name explorer -Force
Start-Sleep -s 5
$wshell = New-Object -ComObject wscript.shell; $wshell.SendKeys('^{ESCAPE}')
Start-Sleep -s 5

#Enable the ability to pin items again by disabling "LockedStartLayout"
foreach ($regAlias in $regAliases){
    $basePath = $regAlias + ":\SOFTWARE\Policies\Microsoft\Windows"
    $keyPath = $basePath + "\Explorer" 
    Set-ItemProperty -Path $keyPath -Name "LockedStartLayout" -Value 0
}

#Restart Explorer and delete the layout file
Stop-Process -name explorer -Force

# Uncomment the next line to make clean start menu default for all new users
Import-StartLayout -LayoutPath $layoutFile -MountPath $env:SystemDrive\

Remove-Item $layoutFile
echo "==========================================================================="
echo "Now complete..."
""
echo "Please continue."
""
} else {
echo "Not removing any tiles from the start menu..."
Echo "Please continue."
cl
}}

function start-photoviewer {
#Photoviewer regkey
cl
do { $myInput = (Read-Host 'Would you like to install Photo Viewer? (Windows7 verision) (Y/N)').ToLower() } while ($myInput -notin @('y','n'))
if ($myInput -eq 'y') {
echo "Installing photo viewer...."
Invoke-WebRequest $PhotoviewerInstall -outfile c:\temp\scriptdownloads\Photoviewer.reg
Invoke-Command {reg import C:\temp\scriptdownloads\Photoviewer.reg *>&1 | Out-Null}
Remove-Item "c:\temp\scriptdownloads\photoviewer.reg"
echo "Photoviewer installed..."
echo "Please confirm if that is installed by checking with a compatible file type and change default photos app to this."
echo "-"
echo "Please continue."
} else {
echo "Not installing Photoviewer (Windows 7 verision)...."
echo "Please continue."
cl
}}

function start-uac {
cl
#Dimm or turn off UAC
do { $myInput = (Read-Host 'Would you like to modify UAC? (Dim/Off/N)').ToLower() } while ($myInput -notin @('dim','off','N'))
if ($myInput -eq 'dim') {
Invoke-Command {reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v PromptOnSecureDesktop /t reg_dword /d 0 /f}
}
if ($myInput -eq 'off') {
Invoke-Command {reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f}
}
if ($myInput -eq 'N') {
echo "Not modying UAC..."
echo "Please continue. (may require a restart but not always needed)"
cl
}}

function start-addrunasps1 { 
Invoke-WebRequest $RunAsAdministratorPS -outfile c:\temp\RunAsAdminContextMenupowershell.reg
Invoke-Command {reg import C:\temp\RunAsAdminContextMenupowershell.reg *>&1 | Out-Null}
remove-item "C:\temp\RunAsAdminContextMenupowershell.reg"}

function start-bitlocker {
cl
do { $myInput = (Read-Host 'Would you like to enable Bitlocker? (Y/N)').ToLower() } while ($myInput -notin @('Y','N'))
if ($myinput -eq 'Y') {
$localmachine = $env:computername
echo "Staring encryption..."
""
manage-bde -protectors -add C: -RecoveryPassword > C:\temp\$localmachine.RecoveryPassword.txt
manage-bde -protectors -add C: -tpm > C:\temp\$localmachine.RecoveryPassword.txt
manage-bde -protectors -get C: > C:\temp\$localmachine.RecoveryPassword.txt
manage-bde -on C:
""
""
""
$BitLocker = Get-BitLockerVolume -MountPoint $env:SystemDrive
$RecoveryProtector = $BitLocker.KeyProtector | Where-Object { $_.KeyProtectorType -eq 'RecoveryPassword' }

Backup-BitLockerKeyProtector -MountPoint $env:SystemDrive -KeyProtectorId $RecoveryProtector.KeyProtectorID
BackupToAAD-BitLockerKeyProtector -MountPoint $env:SystemDrive -KeyProtectorId $RecoveryProtector.KeyProtectorID

echo "If you get an error this is regarding GPO it's an automatic command to push to AD. (This will need to be re-run from manual install)"
echo "If you get an error regarding BackUptoAAD this is for AzureActive Directory so it can be safely ignored."
echo "Stored recovery key in C:\temp\"
""
""
echo "If bitlocker recovery is not in AD you use option 11 from the manual select menu."
echo "Make sure to restart for it to start bitlocker encryption."
""
echo "Make sure to restart this before applying windows update."
pause
cl
}

if ($myinput -eq 'n') {
""
echo "Bitlocker will not be setup..."
""
echo "Please continue."
cl
}}

function start-bitlocker-updaterecovery {
cl
""
echo "Updating Bitlocker recovery key to AD..."
""
$BitLocker = Get-BitLockerVolume -MountPoint $env:SystemDrive
$RecoveryProtector = $BitLocker.KeyProtector | Where-Object { $_.KeyProtectorType -eq 'RecoveryPassword' }

Backup-BitLockerKeyProtector -MountPoint $env:SystemDrive -KeyProtectorId $RecoveryProtector.KeyProtectorID
BackupToAAD-BitLockerKeyProtector -MountPoint $env:SystemDrive -KeyProtectorId $RecoveryProtector.KeyProtectorID
""
echo "Done."
""
echo "If you get an error regarding BackUptoAAD this is for AzureActive Directory so it can be safely ignored."
echo "Check that the recoverykey/password matches the one in the c:\temp if it is, remove the one in c:\temp and continue."
echo "Please confirm the recovery key is in AD."
pause
}

function start-disablefirewall-domain {
cl
do { $myInput = (Read-Host 'Disable Windows Firewall on Domain Network? (Y/N)').ToLower() } while ($myInput -notin @('Y','N'))
if ($myinput -eq 'Y') {
""
Invoke-Command {reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /v HideSystray /t reg_dword /d 1 /f} > $null 2>&1 # Removes Windows Defender from taskbar
""
Set-NetFirewallProfile -Profile Domain -Enabled False
echo "Windows Firewall disabled for Domain network."
}
else {echo "Windows Firewall for Domain network not disabled."
echo "Please continue."
}}

function start-rename-computer {
cl
do { $myInput = (Read-Host 'Would you like to re-name this computer? (Y/N)').ToLower() } while ($myInput -notin @('Y','N'))
if ($myinput -eq 'Y') {
""
$ComputerName = Read-Host -Prompt 'Enter the PC name you would like to rename to'
Rename-Computer -NewName "$ComputerName" -passthru
""
pause
}
else {
echo "Will not rename computer..."
cl
}}

function start-joindomain {
cl
do { $myInput = (Read-Host 'Would you like to join this PC to a domain? (Y/N)').ToLower() } while ($myInput -notin @('Y','N'))
if ($myinput -eq 'Y') {
""
$DomainName = Read-Host -Prompt 'Enter the domain name to join this PC'
""
echo "Use domain credentials to join the PC to domain. With the Domain at the start e.g. Domain\Administrator"
""
sleep 5
add-computer –domainname "$DomainName" -PassThru -Options JoinWithNewName,AccountCreate
""
echo "The above may not be accurate. (Because a restart is required to update the information)."
""
echo "Just to be sure..."
echo "Providing Hostname & Domain output..."
""
hostname
systeminfo | findstr /B "Domain"
""
echo "Please check if the above information is correct and then continue."
pause
}
else {
echo "PC Will not be joined to the domain."
echo "Please continue."
cl
}}

function start-power-config {
cl
""
echo "Set power options."
""
echo "Laptop: Hiberate on power button and do nothing when the lid closes. Show Hibernate button on start menu."
echo "Desktop: Show hibernate button on start menu. Disable sleep."
""
do { $myInput = (Read-Host 'Change power settings?(laptop/desktop/N)').ToLower() } while ($myInput -notin @('laptop','desktop','N'))
if ($myinput -eq 'laptop') {
""
echo "Modifying Power settings for laptop..."
""
powercfg -setdcvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 2
powercfg -setacvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 2
powercfg -setacvalueindex SCHEME_CURRENT sub_buttons lidaction 0
powercfg -setdcvalueindex SCHEME_CURRENT sub_buttons lidaction 0
Invoke-Command {reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings /v ShowHibernateOption /t reg_dword /d 1 /f}
""
echo "Done."
echo "Please continue."
""
pause
cl
}
if ($myinput -eq 'desktop') { 
""
echo "Modifying Power settings for Desktop..."
""
Invoke-Command {reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings /v ShowHibernateOption /t reg_dword /d 1 /f}
powercfg -change -standby-timeout-dc 0
powercfg -change -standby-timeout-ac 0
""
echo "Done."
echo "Please continue."
""
pause
cl
}
if ($myinput -eq 'N') {
""
echo "Not modifying power settings..."
pause
cl
}}

function start-disable-defrag {
cl
echo "This is for disabiling disk defrag for SSD."
""
echo "Providing output for current drives on the machine."
""
Get-PhysicalDisk | Format-Table -AutoSize
""
do { $myInput = (Read-Host 'Disable disk frag? (Y/N)').ToLower() } while ($myInput -notin @('Y','N'))
if ($myinput -eq 'Y') {
schtasks /Delete /TN "\Microsoft\Windows\Defrag\ScheduledDefrag"  /f
""
echo "Please continue."
""
pause
cl
}
else {
""
echo "Not modifying Disk defrag."
""
pause
cl
}}

function start-systemrestorepoint {
cl
do { $myInput = (Read-Host 'Enable System Restore point? (Y/N)').ToLower() } while ($myInput -notin @('Y','N'))
if ($myinput -eq 'Y') {
""
Enable-ComputerRestore -Drive "C:\"
""
echo "If you get an empty output, it's enabled but double check from settings."
""
pause
cl
}
else {
""
echo "Not modifying System Restore Point"
""
pause
}}

#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<If you want to add additonal features, start adding from above. Then add to manual-script and start-script.>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

function start-windows-update {
cl
""
echo "Run this last, if you have an old verison of windows and a feature update is applicable it will not move from the status checker until it restarts."
echo "If you enabled bitlocker and still haven't restart, do it now and then use manual select option 50 to come back here."
""
Install-PackageProvider -Name NuGet -Force -MinimumVersion 2.8.5.201 > $null 2>&1
Install-Module -Name PendingReboot -Force > $null 2>&1
""
Echo "Checking if this PC requires a reboot..."
echo "If you get an empty output it means no restarts are required."
""
Test-PendingReboot -SkipConfigurationManagerClientCheck
""
pause
cl
""
cl
do { $myInput = (Read-Host 'Start Windows updates? (If applicable it will also apply feature updates.) (Y/N)').ToLower() } while ($myInput -notin @('Y','N'))
if ($myinput -eq 'Y') {
""
if ($WindowsVerison -le $OldWindows) { 
#Removes the Upgrader app if it's installed.
C:\Windows10Upgrade\Windows10UpgraderApp.exe /ForceUninstall > $null 2>&1
Remove-Item C:\Windows10Upgrade\*.* -recurse -force > $null 2>&1
#
echo "Starting windows updates..."
echo "Please wait..."
$dir = 'C:\temp\scriptdownloads\packages'
Remove-Item $dir -recurse -force > $null 2>&1
mkdir $dir > $null 2>&1
$webClient = New-Object System.Net.WebClient
$url = 'https://go.microsoft.com/fwlink/?LinkID=799445'
$file = "$($dir)\Win10Upgrade.exe"
$webClient.DownloadFile($url,$file)
Start-Process -FilePath $file -ArgumentList '/skipeula /auto upgrade /copylogs $dir'
""
#start-windows-update-running-checker <may not be needed.
echo "Please re-run the bloatware remover after restarting as doing a feature update may add new bloatware back in."
""
echo "The script is setup to exit after hitting enter."
""
pause
""
pause
""
exit
}
if ($LatestWindows -match $LatestWindows) {
""
echo "This is the latest Windows feature update."
echo "Starting normal windows update instead..."
start-windows-update-nofeature
}}}

function start-windows-update-nofeature {
cl
do { $myInput = (Read-Host 'Continue with updates? (This is already latest Windows Version only applying normal updates) (Y/N)').ToLower() } while ($myInput -notin @('Y','N'))
if ($myinput -eq 'Y') {
""
echo "Starting windows updates..."
echo "Please wait..."
""
Install-PackageProvider -Name NuGet -Force -MinimumVersion 2.8.5.201 > $null 2>&1
Install-Module -Name PSWindowsUpdate -Force > $null 2>&1
""
echo "Checking windows update status..."
Install-WindowsUpdate -AcceptAll -Install -MicrosoftUpdate -Verbose | Out-File "c:\temp\$(get-date -f dd-MM-yyyy-HH-mm)-WindowsUpdate.log" -force
""
echo "Stored windows update log in c:\temp it goes from dd-MM-yyyy-HH-mm-windowsupdate.log"
echo "Restart the PC if it prompts, then try run the updates again to confirm it's completed."
""
echo "Here is the current update history for this computer."
get-wmiobject -class win32_quickfixengineering
""
""
pause
}
else {
""
echo "Not installing windows updates..."
""
pause
cl
}}

# Function not in use.
function start-windows-update-running-checker {
Start-Sleep -seconds 30
echo "Checking status of updater..."
$ProcessList = @(
    "Windows10UpgraderApp" #or whatever you want to monitor
)
Do {  
    $ProcessesFound = Get-Process | ? {$ProcessList -contains $_.Name} | Select-Object -ExpandProperty Name
    If ($ProcessesFound) {
		cl
        Write-Host "Still running: $($ProcessesFound)"
		Write-Host "This will refresh every couple of seconds."
		Write-Host "When the update is complete Windows10Assistant will appear."
		Write-Host "Make sure to click restart now on the assisant applicaiton (when it appears) or you will not be able to continue with the script."
		""
		Write-Host "Current time output."
		Get-Date
        Start-Sleep 10
    }
} Until (!$ProcessesFound)
}
# Function not in use.

#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<This section above is to be used for only functions that need to run last.>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

function start-script {
start-addrunasps1
start-softwareinstall
start-mimecastinstall
start-vpninstall 
start-bloatwareremover
start-hpbloatwareremoval
start-shortcuts-default-apps
start-clearstartmenu
start-photoviewer
start-uac
start-addrunasps1
start-bitlocker
start-disablefirewall-domain
start-rename-computer
start-joindomain
start-power-config
start-disable-defrag
start-systemrestorepoint
start-windows-update # MAKE SURE THIS IS THE LAST ONE ON THE LSIT
cl
echo "This will now return to main menu, if you wish to exit, exit from the menu."
echo "If you would like to re-run a install that didn't work, use option 1 from the menu."
main-menu
}

function manual-script {
cl
$createdby
$verifiedby
$lastupdatedby
""
echo "Removing & creating directory in C:\temp\scriptdownloads..."
mkdir c:\temp > $null 2>&1
Remove-Item c:\temp\scriptdownloads -recurse -force > $null 2>&1
mkdir c:\temp\scriptdownloads > $null 2>&1
echo "Done."
""
echo "Manual install has been selected, please choose what you would like to install selectively."
""
echo "Option 1: Software install."
echo "Option 2: VPN Install (NeteXtender/GlobalVPN)."
echo "Option 3: Mimecast install for Outlook."
echo "Option 4: Windows10 Bloatware removal."
echo "Option 5: HP Bloatware removal."
echo "Option 6: Clear start menu and apply taskbar applications."
echo "Option 7: Install Photoviewer."
echo "Option 8: Modify UAC."
echo "Option 9: Reapply shortcuts & default apps."
echo "Option 10: Enable Bitlocker."
echo "Option 11: Update Bitlocker recovery password to AD."
echo "Option 12: Office uninstall tool. (Only use this if you can't use option 13)"
echo "Option 13: Uninstall Office using script."
echo "Option 14: Add run as administrator on ps1 context menu."
echo "Option 15: Disable Windows Firewall on Domain network."
echo "Option 16: Join PC to domain"
echo "Option 17: Rename PC"
echo "Option 18: Set power config (Laptop/Desktop"
echo "Option 19: Disable disk defrag (For SSD)."
echo "Option 20: Enable SystemRestore Point"


#last options
echo "Option 50: Start windows updates (Includes feature update)"
""
echo "Option MainMenu: Re-directs to main menu"
echo "Option Exit: Exits launcher from sub-menu."
""
do { $myInput = (Read-Host 'Choose from the above option').ToLower() } while ($myInput -notin @('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','50','exit','mainmenu'))
if ($myInput -eq '1') {start-softwareinstall}
if ($myInput -eq '2') {start-vpninstall}
if ($myinput -eq '3') {start-mimecastinstall}
if ($myinput -eq '4') {start-bloatwareremover}
if ($myinput -eq '5') {start-hpbloatwareremoval}
if ($myinput -eq '6') {start-clearstartmenu}
if ($myinput -eq '7') {start-photoviewer}
if ($myinput -eq '8') {start-uac}
if ($myinput -eq '9') {start-shortcuts-default-apps}
if ($myinput -eq '10') {start-bitlocker}
if ($myinput -eq '11') {start-bitlocker-updaterecovery}
if ($myinput -eq '12') {start-officeuninstalltool}
if ($myinput -eq '13') {start-officeuninstall}
if ($myinput -eq '14') {start-addrunasps1}
if ($myinput -eq '15') {start-disablefirewall-domain}
if ($myinput -eq '16') {start-joindomain}
if ($myinput -eq '17') {start-rename-computer}
if ($myinput -eq '18') {start-power-config}
if ($myinput -eq '19') {start-disable-defrag}
if ($myinput -eq '20') {start-systemrestorepoint}

if ($myinput -eq '50') {start-windows-update}
if ($myinput -eq 'mainmenu') {main-menu}
if ($myinput -eq 'exit') {end-script}
manual-script
}

function end-script {
cl
$createdby
$verifiedby
$lastupdatedby
echo "End of script."
""
echo "Clearing c:\temps\scriptdownloads."
Remove-item c:\temp\scriptdownloads -recurse -force > $null 2>&1
echo "Done..."
""
echo "Please press any key."
pause
exit
}

function clWorkaround {
    clear-host
    Write-Output "$([char]27)[2J$([char]27)[3J"
}
Set-Alias -Name cl -Value clWorkaround -Scope "Local"

#Start of the script.

$createdby
$verifiedby
$lastupdatedby

echo "Important! It is recommended that this is run before creating any user accounts/logging into them."
echo "Meaning there should only be one account setup a this current time."
echo "This is because default settings only apply before user creation"
""
echo "=============================================================================="
echo "This is is a generic script for setting up new machines."
echo "=============================================================================="
""
echo "The following options will be given during the script."
""
echo ")Install 7zip, Chrome, Foxit reader, GlobalVPN/NeteXtender, Mimecast for Outlook, Office365 Apps."
echo ")Sending key applications shortcuts to desktop."
echo ")Set default apps, Outlook & chrome."
echo ")Removing Windows 10 Store apps."
echo ")HP Bloatware remover." 
echo ")Removing pinned tiles from start menu (and creates a default for new/current users)." 
echo ")Pin & remove taskbar applications."
echo ")Removing web search from search bar."
echo ")Disabling cortana & removing taskview from taskbar."
echo ")Add run administrators on .ps1 context menu."
echo ")Installing photoviewer. (Not Microsoft Photos)." 
echo ")Disable or use Dimmed UAC." 
echo ")Enable bitlocker."
echo ")Update Bitlocker recovery key to AD."
echo ")Uninstall Office365 tool."
echo ")Disable Windows firewall on Domain network."
echo ")Join PC to Domain"
echo ")Rename PC"
echo ")Set power config (Laptop/Desktop)"
echo ")Disable defrag for SSDs"
echo ")Windows Updates. (Includes feature updates)"
echo ")Enable SystemRestore Point"
""
main-menu

# SIG # Begin signature block
# MIIFdQYJKoZIhvcNAQcCoIIFZjCCBWICAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUVRDmhuWRBUmGnZNuk5odDKhA
# eg2gggMVMIIDETCCAfmgAwIBAgIQVhOR9PCld55K0eL7v5x/hDANBgkqhkiG9w0B
# AQsFADAVMRMwEQYDVQQDDApNb2hhbW1lZFJRMB4XDTIwMDkxNTE5NTMwMVoXDTIx
# MDkxNTIwMTMwMVowFTETMBEGA1UEAwwKTW9oYW1tZWRSUTCCASIwDQYJKoZIhvcN
# AQEBBQADggEPADCCAQoCggEBAMb9d6KoKjormPOMW/yUR9i8auOCBZNRxDAaDgJq
# Utx5aRugHWyESPPFYbnKrqCmunFXBzKhvDWX9b1qMwo5oFX7AUAMCd6P2VB59jIJ
# qPF/N/HvnuGvK08+IwcJ96yg4FZJPTi8BNYUTZZxnuwv3hHQtVfmg1HpUO1UyJII
# DTtyzZKz6SdcEHL5W0OqiffHp44ZbAktJyWO1SYfN7J2AbdN34yUR2iCE5+hB97c
# 3mVoKkLjzRBPmsDVUy8bsMIxUReQtgREJgR7VlZI7UxrYN1eT7nl8i/lVEiFtIXr
# 6msI3FRrrygh+l4+FnpvGYFGBVrvGrYEXtcPT3UDYeG5ADUCAwEAAaNdMFswDgYD
# VR0PAQH/BAQDAgeAMBMGA1UdJQQMMAoGCCsGAQUFBwMDMBUGA1UdEQQOMAyCCk1v
# aGFtbWVkUlEwHQYDVR0OBBYEFMwK7mMAt1iN0ehfHdJ3FrpyA3dDMA0GCSqGSIb3
# DQEBCwUAA4IBAQB/2cfhmZpeYnX8+0vrI8GrbgwLkFxcP0+hvBZQYiQSg/s3m2Rv
# iBOkMQbjx8NwmzxSsyO44Q/nq/xtXuyXNWtKMjjx36E1ke1WyEMf6ozFVJ3dw+va
# VDd9wj0gNPZoJkeLWsXSBKjwMDdsS0wI6l/N+9oPBoa3kDMjWCJ1BLmwp3WF97sz
# XVO4Nhp4egicI2c5wpKu3cY3Su/WCOheU5Qg9jTI0TEB/LYKte5fRTX8h1VzyTwC
# BAxruLb5D10XegbBJChl3LBiFXgVVvhaK12lqwM8eAOwdPwTO92ZdIMYqYjRhKI+
# 15K0TsSmp5eLdBt0bG3+NmnwKPmLOdnDnaMpMYIByjCCAcYCAQEwKTAVMRMwEQYD
# VQQDDApNb2hhbW1lZFJRAhBWE5H08KV3nkrR4vu/nH+EMAkGBSsOAwIaBQCgeDAY
# BgorBgEEAYI3AgEMMQowCKACgAChAoAAMBkGCSqGSIb3DQEJAzEMBgorBgEEAYI3
# AgEEMBwGCisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMCMGCSqGSIb3DQEJBDEW
# BBQVRGgv8Yp9uk8XqN0jvd/tlbRxlDANBgkqhkiG9w0BAQEFAASCAQBxsPqFD9Ny
# HMGrIWnIYx5o7ncrtValZMF8qttZEWe1BChe9tH/C3GdqXrqyZ6frS5qsgbo/fFI
# MmZaImrD1dB5GCyHBcm1kWRG7tvaDB2c4uTIHZkpPQiHfaEf8EXvb2NWCIhy0kN9
# T/vj//+mUQAP/utnmkanb5uNInm6WW47hjyq7CPOfV+sXmnmum1XDLpB2cotn122
# bHDz8vf6AipwVr6+TZFGSG98OWBpaUvnS3t7BVCZjZtmU/IEWGUQ7G+adQbPxmT3
# 5PxcXplYfOlzVDaKiNskNXY8xauPScGH2MrpZLoAK8Rtpxb95Ez2IXy60DuCEdN/
# /6lXTuOZ/uCz
# SIG # End signature block
