if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}
Clear-Host
$createdby = Write-Output "==================================Created By MQ 08/09/2020================================"
$verifiedby = Write-Output "=================================Verified By XX XX/XX/XXXX================================"
$lastupdatedby = Write-Output "===============================Last Updated By MQ 11/10/2020=============================="

$WindowsVerison = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").ReleaseId
$LatestWindows = '2004' #Current Windows verison
$OldWindows = '1909' #Anything under 1909 or equal to

#Download links.

$OfficeExe = 'https://github.com/Ray-MRQ/MRQ/raw/master/Install%20files/setup.exe'
$OfficeXMLInstall = 'https://github.com/Ray-MRQ/MRQ/raw/master/Regkeys_xmls/configuration-Office365-x86.xml'
$OfficeXMLUninstall = 'https://github.com/Ray-MRQ/MRQ/raw/master/Regkeys_xmls/configruation_uninstall.xml'
$OfficeXMLHomeUninstall = 'https://github.com/Ray-MRQ/MRQ/raw/master/Regkeys_xmls/configuration_uninstall_home.xml'
$OfficeUninstallTool = 'https://outlookdiagnostics.azureedge.net/sarasetup/SetupProd_OffScrub.exe'
$SoftwareInstallChrome = 'https://github.com/Ray-MRQ/MRQ/raw/master/Install%20files/GoogleChromeStandaloneEnterprise64.msi'
$SoftwareInstall7zip = 'https://github.com/Ray-MRQ/MRQ/raw/master/Install%20files/7z1604-x64.msi'
$SoftwareInstallJava = 'https://github.com/Ray-MRQ/MRQ/raw/master/Install%20files/jre1.8.0_26164.msi'
$SoftwareInstallZoomFile = 'https://github.com/Ray-MRQ/MRQ/raw/master/Install%20files/ZoomInstallerFull.msi'
$SoftwareInstallTeams = 'https://github.com/Ray-MRQ/MRQ/raw/master/Install%20files/Teams_windows_x64.msi'
$SoftwareInstallAdobeReader = 'https://onl-my.sharepoint.com/:u:/g/personal/mohammed_quashem_onlinesupport_co_uk/EcRWAKSO321GgevynQeMUzkBpZ-6wm-kHKs7_uScUdfZmw?e=4bhFXR&download=1'
$DefaultAppPre1909= 'https://github.com/Ray-MRQ/MRQ/raw/master/Regkeys_xmls/Pre1909DefaultAppAssociations.xml'
$DefaultApp = 'https://github.com/Ray-MRQ/MRQ/raw/master/Regkeys_xmls/2004AppAssociations.xml'
$MimecastInstall = 'https://github.com/Ray-MRQ/MRQ/raw/master/Install%20files/Mimecast%20for%20Outlook%207.0.1740.17532%20(32%20bit).msi'
$GlobalVPNInstall = 'https://github.com/Ray-MRQ/MRQ/raw/master/Install%20files/GVCInstall64.msi'
$NeteXtenderInstall= 'https://github.com/Ray-MRQ/MRQ/raw/master/Install%20files/NetExtender.8.6.265.MSI'
$BloatwareRemoverWin10 = 'https://github.com/Ray-MRQ/MRQ/raw/master/Scripts/Uninstall_windows10_bloatware.ps1'
$HPBloatwareRemover = 'https://github.com/Ray-MRQ/MRQ/raw/master/Scripts/HP-Bloatware-Removal-Auto.bat'
$DellBloatwareRemover = 'https://github.com/Ray-MRQ/MRQ/raw/master/Scripts/Dell-Bloatware-Removal.bat'
$PhotoviewerInstall = 'https://github.com/Ray-MRQ/MRQ/raw/master/Regkeys_xmls/Restore_Windows_Photo_Viewer_ALL_USERS.reg'
$RunAsAdministratorPS = 'https://github.com/Ray-MRQ/MRQ/raw/master/Regkeys_xmls/Add%20Run%20As%20Adminstrator%20PS.reg'


##############################################################################
	
function start-main-menu {
Write-Output ''
Write-Output "Option 1: Automated/ineractive install."
Write-Output "Option 2: Manual select install"
Write-Output "Option 3: Exit installer"
Write-Output ''
do { $myInput = (Read-Host 'Type an option').ToLower() } while ($myInput -notin @('1','2','3'))
if ($myinput -eq '1') {start-script}
if ($myinput -eq '2') {start-manual-script}
if ($myinput -eq '3') {start-end-script}
}

function start-softwareinstall {
Write-Output "Removing & creating directory in C:\temp\scriptdownloads..."
mkdir c:\temp > $null 2>&1
Remove-Item c:\temp\scriptdownloads -recurse -force > $null 2>&1
mkdir c:\temp\scriptdownloads > $null 2>&1
Write-Output "============================================================================="
Clear-Host
$createdby
$verifiedby
$lastupdatedby
Write-Output ''
Write-Output "For software, the following will be installed."
Write-Output "Uninstall the ones you do not require as neeeded."
Write-Output ''
Write-Output ''
Write-Output 7Zip Chrome Java Teams "Adobe Reader" "Office365 Applications 32Bit" "Zoom (Optional)"  "NeteXtender or GlobalVPN (optional)" "Mimecast for Outlook32Bit (optional)" 
Write-Output ''
Write-Output "Please confirm below."
Write-Output ''
pause
Clear-Host

#Run OfficeUninstall Check
start-officecheck

Write-Output ''
Write-Output "Starting download and install for 7Zip, Java, Teams, Chrome & Adobe Reader..."
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest $SoftwareInstallChrome -outfile c:\temp\scriptdownloads\chrome.msi
Invoke-WebRequest $SoftwareInstall7zip -outfile c:\temp\scriptdownloads\7zip.msi
Invoke-WebRequest $SoftwareInstallJava -outfile c:\temp\scriptdownloads\java.msi
Invoke-WebRequest $SoftwareInstallAdobeReader -outfile c:\temp\scriptdownloads\adobereader.zip
Invoke-WebRequest $SoftwareInstallTeams -outfile c:\temp\scriptdownloads\teams.msi
Expand-Archive -LiteralPath C:\temp\scriptdownloads\adobereader.zip -DestinationPath C:\temp\scriptdownloads\
$ProgressPreference = 'Continue'
Start-Process msiexec.exe -Wait -ArgumentList '/i c:\temp\scriptdownloads\chrome.msi /qn /norestart allusers=2'
Start-Process msiexec.exe -Wait -ArgumentList '/i c:\temp\scriptdownloads\7zip.msi /qn /norestart allusers=2'
Start-Process msiexec.exe -Wait -ArgumentList '/i c:\temp\scriptdownloads\java.msi /qn /norestart allusers=2'
Start-Process msiexec.exe -Wait -ArgumentList '/i c:\temp\scriptdownloads\teams.msi /qn /norestart allusers=2'
Start-Process msiexec.exe -Wait -ArgumentList '/i c:\temp\scriptdownloads\adobereader\acroread.msi /qn /norestart allusers=2'
Write-Output ''
Write-Output "Installed 7zip, Java, Chrome and Adobe reader silently."
Write-Output ''
do { $myInput = (Read-Host 'Would you like to install Zoom?(Y/N)').ToLower() } while ($myInput -notin @('y','n'))
if ($myInput -eq 'y') {
Write-Output ''
Write-Output "Starting Zoom download..."
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest $SoftwareInstallZoomFile -outfile c:\temp\scriptdownloads\ZoomInstaller.msi
$ProgressPreference = 'Continue'
Start-Process msiexec.exe -Wait -ArgumentList '/i c:\temp\scriptdownloads\ZoomInstaller.msi /qn /norestart allusers=2'
}}

function start-officecheck {
$uninstallKeys = Get-ChildItem -Path "HKLM:HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
$O365 = "Microsoft 365"
$O365Check = $uninstallKeys | Where-Object { $_.GetValue("DisplayName") -match $O365 }

$uninstallKeysHome = Get-ChildItem -Path "HKLM:HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
$O365Home = "Microsoft Office 365"
$O365CheckHome = $uninstallKeysHome | Where-Object { $_.GetValue("DisplayName") -match $O365Home }

$O365Installed = Write-Output "Office 365 is installed."
$O365NotInstalled = Write-Output "Office 365 is not installed."
if ($O365Check) {
$O365Installed
Write-Output ''
start-officeuninstall-pro
}
if ($O365CheckHome) {
start-officeuninstall-home
}
else {
$O365NotInstalled
Write-Output ''
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
Write-Output "Office365 ProPlus should be uninstalled."
Write-Output "If not, use option 12 and use the support tool to uninstall."
Write-Output ''
pause
Write-Output ''
Clear-Host
}
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
Clear-Host
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
}}

function start-officeuninstalltool {
Write-Output "Office applications uninstall tool, with will open up an app."
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest $OfficeUninstallTool -outfile C:\temp\scriptdownloads\officeuninstall.exe
$ProgressPreference = 'Continue'
Write-Output ''
Write-Output "Downloading Office uninstall tool..."
Write-Output ''
Write-Output "Done, starting Office uninstall tool."
C:\temp\scriptdownloads\officeuninstall.exe
Write-Output ''
Write-Output "Go through the prompts then continue."
pause
Clear-Host
}

function start-mimecastinstall {
Clear-Host
do { $myInput = (Read-Host 'Would you like to install Mimecast for Outlook 32Bit?(Y/N)').ToLower() } while ($myInput -notin @('y','n'))
if ($myInput -eq 'y') {
Write-Output ''
Write-Output "Downloading & installing Mimecast for Outlook..."
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest $MimecastInstall -outfile c:\temp\scriptdownloads\mimecast32bit.msi
$ProgressPreference = 'Continue'
Start-Process msiexec.exe -Wait -ArgumentList '/i c:\temp\scriptdownloads\mimecast32bit.msi /qn /norestart allusers=2'
Write-Output ''
netsh advfirewall firewall add rule name="Mimecast.Services.Windows.Personal" dir=in action=allow program="C:\program files (x86)\mimecast\mimecast windows service\msddsk.exe" enable=yes
Write-Output "Adding firewall rule..."
Write-Output "Mimecast for Outlook should now be installed."
Write-Output ''
pause
} else {
Write-Output "Mimecast for Outlook32Bit will not be installed..."
Write-Output "Please continue."
Write-Output ''
}}

function start-vpninstall {
Clear-Host
do { $myInput = (Read-Host 'Would you like to install GlobalVPN or NeteXtender? Or none? (Global/Net/N)').ToLower() } while ($myInput -notin @('global','net','N'))
if ($myInput -eq 'global') {
Write-Output ''
Write-Output "Downloading & installing GlobalVPN..."
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest $GlobalVPNInstall -outfile c:\temp\scriptdownloads\gvcinstall64.msi
$ProgressPreference = 'Continue'
Start-Process msiexec.exe -Wait -ArgumentList '/i C:\temp\scriptdownloads\gvcinstall64.msi /qn /norestart allusers=2'
Write-Output ''
Write-Output "Adding firewall rule for GlobalVPN."
netsh advfirewall firewall add rule name="SonicWall Global VPN Client" dir=in action=allow program="C:\program files\sonicwall\global vpn client\swgvc.exe" enable=yes
Write-Output "GlobalVPN should now be installed."
Copy-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Global VPN Client.lnk" -Destination "C:\Users\Public\Desktop\Global VPN Client.lnk"
Write-Output ''
pause
}
if ($myinput -eq 'net') {
Write-Output ''
Write-Output "Downloading & installing NeteXtender..."
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest $NeteXtenderInstall -outfile c:\temp\scriptdownloads\netextender.msi
$ProgressPreference = 'Continue'
Start-Process msiexec.exe -Wait -ArgumentList '/i C:\temp\scriptdownloads\netextender.msi /qn /norestart allusers=2'
Write-Output ''
Write-Output "NeteXtender should now be installed."
Write-Output ''
pause
Write-Output ''
}
if ($myinput -eq 'N') {
Write-Output ''
Write-Output "Will not install NeteXtender or Global VPN."
Write-Output ''
Write-Output "Please continue."
Write-Output ''
}}

function start-photoviewer {
    #Photoviewer regkey
    Clear-Host
    do { $myInput = (Read-Host 'Would you like to install Photo Viewer? (Windows7 verision) (Y/N)').ToLower() } while ($myInput -notin @('y','n'))
    if ($myInput -eq 'y') {
    Write-Output "Installing photo viewer...."
    Invoke-WebRequest $PhotoviewerInstall -outfile c:\temp\scriptdownloads\Photoviewer.reg
    Invoke-Command {reg import C:\temp\scriptdownloads\Photoviewer.reg *>&1 | Out-Null}
    Remove-Item "c:\temp\scriptdownloads\photoviewer.reg"
    Write-Output "Photoviewer installed..."
    Write-Output "Please confirm if that is installed by checking with a compatible file type and change default photos app to this."
    Write-Output "-"
    Write-Output "Please continue."
    } else {
    Write-Output "Not installing Photoviewer (Windows 7 verision)...."
    Write-Output "Please continue."
    Clear-Host
}}

function start-bloatwareremover {
Clear-Host
$ProgressPreference = "SilentlyContinue"
#Windows10 Apps bloatware remover
Write-Output ''
Write-Output "Before going ahead, please make sure you choose the correct option."
Write-Output "If you get any errors, (red lines) this may be due to multiple profiles."
Write-Output "Use option user on that profile if that is the case."
Write-Output "Otherwise option y should work fine."
Write-Output ''
do { $myInput = (Read-Host 'Please confirm with (Y/N) if you would like to remove Windows10Bloatware apps').ToLower() } while ($myInput -notin @('y','n'))
if ($myInput -eq 'y') {
Invoke-WebRequest $BloatwareRemoverWin10 -outfile c:\temp\scriptdownloads\bloatwareremover.ps1
powershell c:\temp\scriptdownloads\bloatwareremover.ps1
Write-Output "Script complete..."
$ProgressPreference = 'Continue'
Clear-Host
}
if ($myinput -eq 'n') {
Write-Output "windows 10 Bloatware apps will not be removed..."
Write-Output "Please continue."
Clear-Host
}
}

function start-hpbloatwareremoval {
#HP Crapware
Clear-Host
do { $myInput = (Read-Host 'Is this a HP workstation/laptop? If so would you like to remove bloatware for this as well? (Y/N)').ToLower() } while ($myInput -notin @('y','n'))
if ($myInput -eq 'y') {
Write-Output "This may take a while..."
Invoke-WebRequest $HPBloatwareRemover -outfile c:\temp\scriptdownloads\hpbloatwareremoval.bat
Invoke-Expression -Command "cmd.exe /c c:\temp\scriptdownloads\hpbloatwareremoval.bat"
Write-Output ''
Write-Output "HP Bloatware has been removed or at least attempted to remove most."
Write-Output ''
Write-Output "If you did come accross some HP crapware that wasn't removed let me know please? (MQ)"
Write-Output ''
pause
} else {
Write-Output 'Not removing Bloatware for HP workstation/laptop...'
}
Clear-Host
}

function start-dellbloatwareremoval {
#Dell Crapware
Clear-Host
do { $myInput = (Read-Host 'Is this a Dell workstation/laptop? If so would you like to remove bloatware for this as well? (Y/N)').ToLower() } while ($myInput -notin @('y','n'))
if ($myInput -eq 'y') {
Write-Output "This may take a while..."
Invoke-WebRequest $DellBloatwareRemover -outfile c:\temp\scriptdownloads\dellbloatwareremoval.bat
Invoke-Expression -Command "cmd.exe /c c:\temp\scriptdownloads\dellbloatwareremoval.bat"
Write-Output ''
Write-Output "Dell Bloatware has been removed or at least attempted to remove most."
Write-Output ''
Write-Output "If you did come accross some Dell crapware that wasn't removed let me know please? (MQ)"
Write-Output ''
pause
} else {
Write-Output 'Not removing Bloatware for Dell workstation/laptop...'
}
Clear-Host
}

function start-shortcuts-default-apps {
Write-Output "This part of the script is for changing default apps & shortcuts for Office."
Write-Output ''
Write-Output "Default apps only apply to new profiles. If the profile for the new user already exists,"
Write-Output "Change default apps manaully from settings or re-create profile."
Write-Output ''
do { $myInput = (Read-Host 'Add shortcuts & default apps?(Y/N)').ToLower() } while ($myInput -notin @('y','n'))
if ($myInput -eq 'y') {
if ($WindowsVersion -le '1909') { 
Invoke-WebRequest $DefaultAppPre1909 -outfile c:\temp\scriptdownloads\MyDefaultAppAssociations.xml 
dism /online /Import-DefaultAppAssociations:"c:\temp\scriptdownloads\MyDefaultAppAssociations.xml" }
else {
Invoke-WebRequest $DefaultApp -outfile c:\temp\scriptdownloads\MyDefaultAppAssociations.xml
dism /online /Import-DefaultAppAssociations:"c:\temp\scriptdownloads\MyDefaultAppAssociations.xml" }
Write-Output "Sending office shortcuts to desktop..."
#Add any shortcuts needed for the above here. It just copies from Start menu to public desktop.
Copy-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Outlook.lnk" -Destination "C:\Users\Public\Desktop\Outlook.lnk"
Copy-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Excel.lnk" -Destination "C:\Users\Public\Desktop\Excel.lnk"
Copy-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Powerpoint.lnk" -Destination "C:\Users\Public\Desktop\Powerpoint.lnk"
Copy-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Word.lnk" -Destination "C:\Users\Public\Desktop\Word.lnk"
Write-Output "Done."
Write-Output ''
}
if ($myinput -eq 'n') {
Write-Output ''
Write-Output "Not adding shortcuts/default apps."
Write-Output ''
}
}

function start-clearstartmenu {
Clear-Host
#Clear start menu
Write-Output "Would you like to remove tiles and taskbar applications on the start menu? "
Write-Output "This will become a default setting for new and current users"
Write-Output ''
do { $myInput = (Read-Host 'Choose an option, (Y/N)').ToLower() } while ($myInput -notin @('y','n'))
if ($myInput -eq 'y') {
Write-Output "Modiying start menu & taskbar settings."
Write-Output ''
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
Write-Output "==========================================================================="
Write-Output "Complete... restarting proccesses"
Write-Output "==========================================================================="
Write-Output "This will refresh your screen..."
Clear-Host
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
Write-Output "==========================================================================="
Write-Output "Now complete..."
Write-Output ''
Write-Output "Please continue."
Write-Output ''
} else {
Write-Output "Not removing any tiles from the start menu..."
Write-Output "Please continue."
Clear-Host
}}

function start-uac {
Clear-Host
#Dimm or turn off UAC
do { $myInput = (Read-Host 'Would you like to modify UAC? (Dim/Off/N)').ToLower() } while ($myInput -notin @('dim','off','N'))
if ($myInput -eq 'dim') {
Invoke-Command {reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v PromptOnSecureDesktop /t reg_dword /d 0 /f}
}
if ($myInput -eq 'off') {
Invoke-Command {reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f}
}
if ($myInput -eq 'N') {
Write-Output "Not modying UAC..."
Write-Output "Please continue. (may require a restart but not always needed)"
Clear-Host
}}

function start-addrunasps1 { 
Invoke-WebRequest $RunAsAdministratorPS -outfile c:\temp\RunAsAdminContextMenupowershell.reg
Invoke-Command {reg import C:\temp\RunAsAdminContextMenupowershell.reg *>&1 | Out-Null}
remove-item "C:\temp\RunAsAdminContextMenupowershell.reg"
}

function start-bitlocker {
Clear-Host
do { $myInput = (Read-Host 'Would you like to enable Bitlocker? (Y/N)').ToLower() } while ($myInput -notin @('Y','N'))
if ($myinput -eq 'Y') {
$localmachine = $env:computername
Write-Output "Staring encryption..."
Write-Output ''
manage-bde -protectors -add C: -RecoveryPassword > C:\temp\$localmachine.RecoveryPassword.txt
manage-bde -protectors -add C: -tpm > C:\temp\$localmachine.RecoveryPassword.txt
manage-bde -protectors -get C: > C:\temp\$localmachine.RecoveryPassword.txt
manage-bde -on C:
Write-Output ''
Write-Output ''
Write-Output ''
$BitLocker = Get-BitLockerVolume -MountPoint $env:SystemDrive
$RecoveryProtector = $BitLocker.KeyProtector | Where-Object { $_.KeyProtectorType -eq 'RecoveryPassword' }

Backup-BitLockerKeyProtector -MountPoint $env:SystemDrive -KeyProtectorId $RecoveryProtector.KeyProtectorID
BackupToAAD-BitLockerKeyProtector -MountPoint $env:SystemDrive -KeyProtectorId $RecoveryProtector.KeyProtectorID

Write-Output "If you get an error this is regarding GPO it's an automatic command to push to AD. (This will need to be re-run from manual install)"
Write-Output "If you get an error regarding BackUptoAAD this is for AzureActive Directory so it can be safely ignored."
Write-Output "Stored recovery key in C:\temp\"
Write-Output ''
Write-Output ''
Write-Output "If bitlocker recovery is not in AD you use option 11 from the manual select menu."
Write-Output "Make sure to restart for it to start bitlocker encryption."
Write-Output ''
Write-Output "Make sure to restart this before applying windows update."
pause
Clear-Host
}

if ($myinput -eq 'n') {
Write-Output ''
Write-Output "Bitlocker will not be setup..."
Write-Output ''
Write-Output "Please continue."
Clear-Host
}}

function start-bitlocker-updaterecovery {
Clear-Host
Write-Output ''
Write-Output "Updating Bitlocker recovery key to AD..."
Write-Output ''
$BitLocker = Get-BitLockerVolume -MountPoint $env:SystemDrive
$RecoveryProtector = $BitLocker.KeyProtector | Where-Object { $_.KeyProtectorType -eq 'RecoveryPassword' }

Backup-BitLockerKeyProtector -MountPoint $env:SystemDrive -KeyProtectorId $RecoveryProtector.KeyProtectorID
BackupToAAD-BitLockerKeyProtector -MountPoint $env:SystemDrive -KeyProtectorId $RecoveryProtector.KeyProtectorID
Write-Output ''
Write-Output "Done."
Write-Output ''
Write-Output "If you get an error regarding BackUptoAAD this is for AzureActive Directory so it can be safely ignored."
Write-Output "Check that the recoverykey/password matches the one in the c:\temp if it is, remove the one in c:\temp and continue."
Write-Output "Please confirm the recovery key is in AD."
pause
}

function start-disablefirewall-domain {
Clear-Host
do { $myInput = (Read-Host 'Disable Windows Firewall on Domain Network? (Y/N)').ToLower() } while ($myInput -notin @('Y','N'))
if ($myinput -eq 'Y') {
Write-Output ''
Invoke-Command {reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /v HideSystray /t reg_dword /d 1 /f} > $null 2>&1 # Removes Windows Defender from taskbar
Write-Output ''
Set-NetFirewallProfile -Profile Domain -Enabled False
Write-Output "Windows Firewall disabled for Domain network."
}
else {Write-Output "Windows Firewall for Domain network not disabled."
Write-Output "Please continue."
}}

function start-rename-computer {
Clear-Host
do { $myInput = (Read-Host 'Would you like to re-name this computer? (Y/N)').ToLower() } while ($myInput -notin @('Y','N'))
if ($myinput -eq 'Y') {
Write-Output ''
$ComputerName = Read-Host -Prompt 'Enter the PC name you would like to rename to'
Rename-Computer -NewName "$ComputerName" -passthru
Write-Output ''
pause
}
else {
Write-Output "Will not rename computer..."
Clear-Host
}}

function start-joindomain {
Clear-Host
do { $myInput = (Read-Host 'Would you like to join this PC to a domain? (Y/N)').ToLower() } while ($myInput -notin @('Y','N'))
if ($myinput -eq 'Y') {
Write-Output ''
$DomainName = Read-Host -Prompt 'Enter the domain name to join this PC'
Write-Output ''
Write-Output "Use domain credentials to join the PC to domain. With the Domain at the start e.g. Domain\Administrator"
Write-Output ''
Start-Sleep 5
add-computer –domainname "$DomainName" -PassThru -Options JoinWithNewName,AccountCreate
Write-Output ''
Write-Output "The above may not be accurate. (Because a restart is required to update the information)."
Write-Output ''
Write-Output "Just to be sure..."
Write-Output "Providing Hostname & Domain output..."
Write-Output ''
hostname
systeminfo | findstr /B "Domain"
Write-Output ''
Write-Output "Please check if the above information is correct and then continue."
pause
}
else {
Write-Output "PC Will not be joined to the domain."
Write-Output "Please continue."
Clear-Host
}}

function start-power-config {
Clear-Host
Write-Output ''
Write-Output "Set power options."
Write-Output ''
Write-Output "Laptop: Hiberate on power button and do nothing when the lid closes. Show Hibernate button on start menu."
Write-Output "Desktop: Show hibernate button on start menu. Disable sleep."
Write-Output ''
do { $myInput = (Read-Host 'Change power settings?(laptop/desktop/N)').ToLower() } while ($myInput -notin @('laptop','desktop','N'))
if ($myinput -eq 'laptop') {
Write-Output ''
Write-Output "Modifying Power settings for laptop..."
Write-Output ''
powercfg -setdcvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 2
powercfg -setacvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 2
powercfg -setacvalueindex SCHEME_CURRENT sub_buttons lidaction 0
powercfg -setdcvalueindex SCHEME_CURRENT sub_buttons lidaction 0
Invoke-Command {reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings /v ShowHibernateOption /t reg_dword /d 1 /f}
Write-Output ''
Write-Output "Done."
Write-Output "Please continue."
Write-Output ''
pause
Clear-Host
}
if ($myinput -eq 'desktop') { 
Write-Output ''
Write-Output "Modifying Power settings for Desktop..."
Write-Output ''
Invoke-Command {reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings /v ShowHibernateOption /t reg_dword /d 1 /f}
powercfg -change -standby-timeout-dc 0
powercfg -change -standby-timeout-ac 0
Write-Output ''
Write-Output "Done."
Write-Output "Please continue."
Write-Output ''
pause
Clear-Host
}
if ($myinput -eq 'N') {
Write-Output ''
Write-Output "Not modifying power settings..."
pause
Clear-Host
}}

function start-disable-defrag {
Clear-Host
Write-Output "This is for disabiling disk defrag for SSD."
Write-Output ''
Write-Output "Providing output for current drives on the machine."
Write-Output ''
Get-PhysicalDisk | Format-Table -AutoSize
Write-Output ''
do { $myInput = (Read-Host 'Disable disk frag? (Y/N)').ToLower() } while ($myInput -notin @('Y','N'))
if ($myinput -eq 'Y') {
schtasks /Delete /TN "\Microsoft\Windows\Defrag\ScheduledDefrag"  /f
Write-Output ''
Write-Output "Please continue."
Write-Output ''
pause
Clear-Host
}
else {
Write-Output ''
Write-Output "Not modifying Disk defrag."
Write-Output ''
pause
Clear-Host
}}

function start-systemrestorepoint {
Clear-Host
do { $myInput = (Read-Host 'Enable System Restore point? (Y/N)').ToLower() } while ($myInput -notin @('Y','N'))
if ($myinput -eq 'Y') {
Write-Output ''
Enable-ComputerRestore -Drive "C:\"
Write-Output ''
Write-Output "If you get an empty output, it's enabled but double check from settings."
Write-Output ''
pause
Clear-Host
}
else {
Write-Output ''
Write-Output "Not modifying System Restore Point"
Write-Output ''
pause
}}

function start-removewindows10updateassistant {
Clear-Host
do { $myInput = (Read-Host 'Remove Windows10 Upadte assistant? (Y/N)').ToLower() } while ($myInput -notin @('Y','N'))
if ($myinput -eq 'Y') {
Write-Output ''
C:\Windows10Upgrade\Windows10UpgraderApp.exe /ForceUninstall
Remove-Item C:\Windows10Upgrade\*.* -recurse -force > $null 2>&1
Write-Output ''
Write-Output "Removed Windows10 Update assistant..."
}
else {
Write-Output ''
Write-Output "Not removing Windows10 Update assistant..."
}}
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<If you want to add additonal features, start adding from above. Then add to start-manual-script and start-script.>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

function start-windows-update {
Clear-Host
Write-Output ''
Write-Output "Run this last, if you have an old verison of windows and a feature update is applicable it will not move from the status checker until it restarts."
Write-Output "If you enabled bitlocker and still haven't restart, do it now and then use manual select option 50 to come back here."
Write-Output ''
Write-Output "Checking if this PC requires a reboot..."
Write-Output ''
$RebootFlags = [pscustomobject]@{
    
    Component_Based_Servicing = (Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending' -ErrorAction SilentlyContinue )

    Auto_Update = (Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired' -ErrorAction SilentlyContinue )

    Session_Manager = ( 
                        $null -NE ( 
                            Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager'  -ErrorAction SilentlyContinue |
                            Select-Object -ExpandProperty 'PendingFileRenameOperations' -ErrorAction SilentlyContinue 
                        )
                          
                      )

    Pending_System_Renames = (!
                                ((Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName'  -ErrorAction SilentlyContinue |
                                Select-Object -ExpandProperty 'ComputerName' -ErrorAction SilentlyContinue) `
                                -EQ `
                                 (Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName'  -ErrorAction SilentlyContinue |
                                Select-Object -ExpandProperty 'ComputerName' -ErrorAction SilentlyContinue))
                            )

    UpdateExeVolatile = (
                            [int](Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Updates' -ErrorAction SilentlyContinue|
                            Select-Object -ExpandProperty 'UpdateExeVolatile' -ErrorAction SilentlyContinue ) `
                         -ne 0)

    WMI_DetermineIfRebootPending =   (Invoke-WmiMethod -ComputerName 'localhost' -Namespace root\ccm\clientsdk -Class CCM_ClientUtilities -Name DetermineIfRebootPending  -ErrorAction SilentlyContinue ).RebootPending
}

$RebootFlags
$Reboot_Required = $False

if( $RebootFlags.PSObject.Properties | ForEach-Object {if ($_.value) {$True} } ) # if any of the flags is true, a reboot is needed
    {
        $Reboot_Required = $true
    }

$Reboot_Required

Write-Output ''
Write-Host "If there is true anywhere above a restart is required, restart before going ahead."
Write-Output ''
pause
Clear-Host
Write-Output ''
do { $myInput = (Read-Host 'Start Windows updates? (If applicable it will also apply feature updates.) (Y/N)').ToLower() } while ($myInput -notin @('Y','N'))
if ($myinput -eq 'Y') {
Write-Output ''
if ($WindowsVerison -le $OldWindows) { 
#Removes the Upgrader app if it's installed.
C:\Windows10Upgrade\Windows10UpgraderApp.exe /ForceUninstall > $null 2>&1
Remove-Item C:\Windows10Upgrade\*.* -recurse -force > $null 2>&1
Clear-Host
#
Write-Output "Starting windows updates..."
Write-Output "Please wait..."
$dir = 'C:\temp\scriptdownloads\packages'
Remove-Item $dir -recurse -force > $null 2>&1
mkdir $dir > $null 2>&1
$webClient = New-Object System.Net.WebClient
$url = 'https://go.microsoft.com/fwlink/?LinkID=799445'
$file = "$($dir)\Win10Upgrade.exe"
$webClient.DownloadFile($url,$file)
Start-Process -FilePath $file -ArgumentList '/skipeula /auto upgrade /copylogs $dir'
Write-Output ''
#start-windows-update-running-checker <may not be needed.
Write-Output "Please re-run the bloatware remover after restarting as doing a feature update may add new bloatware back in."
Write-Output ''
Write-Output "The script is setup to exit after hitting enter."
Write-Output ''
start-end-script
}
if ($LatestWindows -match $LatestWindows) {
Write-Output ''
Write-Output "This is the latest Windows feature update."
Write-Output "Starting normal windows update instead..."
start-windows-update-nofeature
}}}

function start-windows-update-nofeature {
Clear-Host
do { $myInput = (Read-Host 'Continue with updates? (This is already latest Windows Version only applying normal updates) (Y/N)').ToLower() } while ($myInput -notin @('Y','N'))
if ($myinput -eq 'Y') {
Write-Output ''
Write-Output "Starting windows updates..."
Write-Output "Please wait..."
Write-Output ''
Install-PackageProvider -Name NuGet -Force -MinimumVersion 2.8.5.201 > $null 2>&1
Install-Module -Name PSWindowsUpdate -Force > $null 2>&1
Write-Output ''
Write-Output "Checking windows update status..."
Install-WindowsUpdate -AcceptAll -Install -MicrosoftUpdate -Verbose | Out-File "c:\temp\$(get-date -f dd-MM-yyyy-HH-mm)-WindowsUpdate.log" -force
Write-Output ''
Write-Output "Stored windows update log in c:\temp it goes from dd-MM-yyyy-HH-mm-windowsupdate.log"
Write-Output "Restart the PC if it prompts, then try run the updates again to confirm it's completed."
Write-Output ''
Write-Output "Here is the current update history for this computer."
get-wmiobject -class win32_quickfixengineering
Write-Output ''
Write-Output ''
pause
}
else {
Write-Output ''
Write-Output "Not installing windows updates..."
Write-Output ''
pause
Clear-Host
}}

# Function not in use.
function start-windows-update-running-checker {
Start-Sleep -seconds 30
Write-Output "Checking status of updater..."
$ProcessList = @(
    "Windows10UpgraderApp" #or whatever you want to monitor
)
Do {  
    $ProcessesFound = Get-Process | Where-Object {$ProcessList -contains $_.Name} | Select-Object -ExpandProperty Name
    If ($ProcessesFound) {
		Clear-Host
        Write-Host "Still running: $($ProcessesFound)"
		Write-Host "This will refresh every couple of seconds."
		Write-Host "When the update is complete Windows10Assistant will appear."
		Write-Host "Make sure to click restart now on the assisant applicaiton (when it appears) or you will not be able to continue with the script."
		Write-Output ''
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
start-photoviewer 
start-bloatwareremover
start-hpbloatwareremoval
start-dellbloatwareremoval
start-shortcuts-default-apps
start-clearstartmenu
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
Clear-Host
Write-Output "This will now return to main menu, if you wish to exit, exit from the menu."
Write-Output "If you would like to re-run a install that didn't work, use option 1 from the menu."
start-main-menu
}

function start-manual-script {
Clear-Host
$createdby
$verifiedby
$lastupdatedby
Write-Output ''
Write-Output "Removing & creating directory in C:\temp\scriptdownloads..."
mkdir c:\temp > $null 2>&1
Remove-Item c:\temp\scriptdownloads -recurse -force > $null 2>&1
mkdir c:\temp\scriptdownloads > $null 2>&1
Write-Output "Done."
Write-Output ''
Write-Output "Manual install has been selected, please choose what you would like to install selectively."
Write-Output ''
Write-Output "Option 1: Software install."
Write-Output "Option 2: VPN Install (NeteXtender/GlobalVPN)."
Write-Output "Option 3: Mimecast install for Outlook."
Write-Output "Option 4: Windows10 Bloatware removal."
Write-Output "Option 5: HP Bloatware removal."
Write-Output "Option 6: Clear start menu and apply taskbar applications."
Write-Output "Option 7: Install Photoviewer."
Write-Output "Option 8: Modify UAC."
Write-Output "Option 9: Reapply shortcuts & default apps."
Write-Output "Option 10: Enable Bitlocker."
Write-Output "Option 11: Update Bitlocker recovery password to AD."
Write-Output "Option 12: Office uninstall tool. (Only use this if you can't use option 13)"
Write-Output "Option 13: Uninstall Office using script."
Write-Output "Option 14: Add run as administrator on ps1 context menu."
Write-Output "Option 15: Disable Windows Firewall on Domain network."
Write-Output "Option 16: Join PC to domain"
Write-Output "Option 17: Rename PC"
Write-Output "Option 18: Set power config (Laptop/Desktop)"
Write-Output "Option 19: Disable disk defrag (For SSD)."
Write-Output "Option 20: Enable SystemRestore Point"
Write-Output "Option 21: Dell Bloatware removal"
Write-Output "Option 22: Remove Windows10 Update Assistant"

#last options
Write-Output "Option 50: Start windows updates (Includes feature update)"
Write-Output ''
Write-Output "Option MainMenu: Re-directs to main menu"
Write-Output "Option Exit: Exits launcher from sub-menu."
Write-Output ''
do { $myInput = (Read-Host 'Choose from the above option').ToLower() } while ($myInput -notin @('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','50','exit','mainmenu'))
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
if ($myinput -eq '13') {start-officecheck}
if ($myinput -eq '14') {start-addrunasps1}
if ($myinput -eq '15') {start-disablefirewall-domain}
if ($myinput -eq '16') {start-joindomain}
if ($myinput -eq '17') {start-rename-computer}
if ($myinput -eq '18') {start-power-config}
if ($myinput -eq '19') {start-disable-defrag}
if ($myinput -eq '20') {start-systemrestorepoint}
if ($myinput -eq '21') {start-dellbloatwareremoval}
if ($myinput -eq '22') {start-removewindows10updateassistant}

if ($myinput -eq '50') {start-windows-update}
if ($myinput -eq 'mainmenu') {start-main-menu}
if ($myinput -eq 'exit') {start-end-script}
start-manual-script
}

function start-end-script {
Clear-Host
$createdby
$verifiedby
$lastupdatedby
Write-Output "End of script."
Write-Output ''
Write-Output "Clearing c:\temps\scriptdownloads."
Remove-item c:\temp\scriptdownloads -recurse -force > $null 2>&1
Write-Output "Done..."
Write-Output ''
Write-Output "Please press any key."
pause
exit
}

function clWorkaround {
    clear-host
    Write-Output "$([char]27)[2J$([char]27)[3J"
}
#Set-Alias -Name Clear-Host -Value clWorkaround -Scope "Local"

#Start of the script.

$createdby
$verifiedby
$lastupdatedby

Write-Output "Important! It is recommended that this is run before creating any user accounts/logging into them."
Write-Output "Meaning there should only be one account setup a this current time."
Write-Output "This is because default settings only apply before user creation"
Write-Output ''
Write-Output "=============================================================================="
Write-Output "This is is a generic script for setting up new machines."
Write-Output "=============================================================================="
Write-Output ''
Write-Output "The following options will be given during the script."
Write-Output ''
Write-Output ")Install 7zip, Chrome, Adobe reader, Java, Teams, GlobalVPN/NeteXtender, Mimecast for Outlook, Office365 Apps."
Write-Output ")Sending key applications shortcuts to desktop."
Write-Output ")Set default apps, Outlook & chrome."
Write-Output ")Removing Windows 10 Store apps."
Write-Output ")HP Bloatware remover." 
Write-Output ")Removing pinned tiles from start menu (and creates a default for new/current users)." 
Write-Output ")Pin & remove taskbar applications."
Write-Output ")Removing web search from search bar."
Write-Output ")Disabling cortana & removing taskview from taskbar."
Write-Output ")Add run administrators on .ps1 context menu."
Write-Output ")Installing photoviewer. (Not Microsoft Photos)." 
Write-Output ")Disable or use Dimmed UAC." 
Write-Output ")Enable bitlocker."
Write-Output ")Update Bitlocker recovery key to AD."
Write-Output ")Uninstall Office365 tool."
Write-Output ")Disable Windows firewall on Domain network."
Write-Output ")Join PC to Domain"
Write-Output ")Rename PC"
Write-Output ")Set power config (Laptop/Desktop)"
Write-Output ")Disable defrag for SSDs"
Write-Output ")Windows Updates. (Includes feature updates)"
Write-Output ")Enable SystemRestore Point"
Write-Output ")Dell Bloatware-Removal"
Write-Output ''
start-main-menu

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
