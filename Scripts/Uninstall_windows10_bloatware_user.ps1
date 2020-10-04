$OriginalPref = $ProgressPreference # Default is 'Continue'
$ProgressPreference = "SilentlyContinue"
echo " ____  __    _____    __   ____  _    _    __    ____  ____    ____  ____  __  __  _____  _  _  __    __   
(  _ \(  )  (  _  )  /__\ (_  _)( \/\/ )  /__\  (  _ \( ___)  (  _ \( ___)(  \/  )(  _  )( \/ )/__\  (  )  
 ) _ ( )(__  )(_)(  /(__)\  )(   )    (  /(__)\  )   / )__)    )   / )__)  )    (  )(_)(  \  //(__)\  )(__ 
(____/(____)(_____)(__)(__)(__) (__/\__)(__)(__)(_)\_)(____)  (_)\_)(____)(_/\/\_)(_____)  \/(__)(__)(____)"
""
#AllUsersNoXbox

$AppListNoXbox = "Microsoft.SkypeApp",          
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

#AllUsers

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
		   "AD2F1837.HPSupportAssistant",
		   "AD2F1837.HPPCHardwareDiagnosticsWindows",
		   "AD2F1837.HPSureShieldAI",
		   "AD2F1837.HPPrivacySettings",
		   "AD2F1837.HPJumpStarts",
		   "AD2F1837.HPPowerManager",
		   "SpotifyAB.SpotifyMusic"
#

function main-menu {
	do { $myInput = (Read-Host 'Would you like to remove Xbox applications as well?(Y/N)').ToLower() } while ($myInput -notin @('Y','N'))
    if ($myInput -eq 'y') {
	start-user-bloatware-noxbox
	start-basic-bloatware-remover
	pause
	$ProgressPreference = $OriginalPref
	exit
	}
	if ($myinput -eq 'n') {
	start-user-bloatware
	start-basic-bloatware-remover
	pause
	$ProgressPreference = $OriginalPref
	exit
}}

function start-user-bloatware {
ForEach ($App in $AppList)
 {
 $PackageFullName = (Get-AppxPackage $App).PackageFullName
 if ($PackageFullName)
 {
 Write-Host "Removing Package: $App"
 remove-AppxPackage -package $PackageFullName 
 }
 }
cls
""
echo "Complete."
""
}

function start-user-bloatware-noxbox {

ForEach ($App in $AppListNoXbox)
 {
 $PackageFullName = (Get-AppxPackage $App).PackageFullName
 if ($PackageFullName)
 {
 Write-Host "Removing Package: $App"
 remove-AppxPackage -package $PackageFullName 
 }
 }
cls
""
echo "Complete."
""
}

function start-basic-bloatware-remover {

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
cls
echo "Refreshed screen to apply."
echo "Completed."
Stop-Process -name explorer -Force
}

main-menu