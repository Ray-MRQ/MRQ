echo " ____  __    _____    __   ____  _    _    __    ____  ____    ____  ____  __  __  _____  _  _  __    __   
(  _ \(  )  (  _  )  /__\ (_  _)( \/\/ )  /__\  (  _ \( ___)  (  _ \( ___)(  \/  )(  _  )( \/ )/__\  (  )  
 ) _ ( )(__  )(_)(  /(__)\  )(   )    (  /(__)\  )   / )__)    )   / )__)  )    (  )(_)(  \  //(__)\  )(__ 
(____/(____)(_____)(__)(__)(__) (__/\__)(__)(__)(_)\_)(____)  (_)\_)(____)(_/\/\_)(_____)  \/(__)(__)(____)"
""
echo "Start script? If you want to exit close the prompt, this is only for per user basis."
pause
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
		   "Microsoft.XboxGameOverlay"
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
echo "Please confirm it has removed applications."
pause
exit
