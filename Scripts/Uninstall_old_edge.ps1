if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}
Clear-Host
Write-Output "Confirm if you would like to uninstall old edge"
pause
Clear-Host
Invoke-Webrequest https://github.com/Ray-MRQ/MRQ/raw/master/Install%20files/install_wim_tweak.exe -outfile .\install_wim_tweak.exe
Write-Output Uninstalling Microsoft Edge...
install_wim_tweak.exe /o /l
install_wim_tweak.exe /o /c Microsoft-Windows-Internet-Browser-Package /r
install_wim_tweak.exe /h /o /l
Write-Output "Microsoft Edge should be uninstalled. Please reboot Windows 10."
pause
Remove-Item .\install_wim_tweak.exe