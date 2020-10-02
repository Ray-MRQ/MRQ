if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}
$OriginalPref = $ProgressPreference # Default is 'Continue'
$ProgressPreference = "SilentlyContinue"
echo " ____  __    _____    __   ____  _    _    __    ____  ____    ____  ____  __  __  _____  _  _  __    __   
(  _ \(  )  (  _  )  /__\ (_  _)( \/\/ )  /__\  (  _ \( ___)  (  _ \( ___)(  \/  )(  _  )( \/ )/__\  (  )  
 ) _ ( )(__  )(_)(  /(__)\  )(   )    (  /(__)\  )   / )__)    )   / )__)  )    (  )(_)(  \  //(__)\  )(__ 
(____/(____)(_____)(__)(__)(__) (__/\__)(__)(__)(_)\_)(____)  (_)\_)(____)(_/\/\_)(_____)  \/(__)(__)(____)"
""
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
""
echo "Completed."
""
#echo "Word of note, Cortana may not remove on first attempt."
#echo "Re-run the removal tool from the manual install menu using option 4."
""

$ProgressPreference = $OriginalPref
echo "Windows 10 Bloatware apps removed..."
echo "------"