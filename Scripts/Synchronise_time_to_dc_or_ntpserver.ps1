if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}
Write-Output "Set time to DC"
$Server = Read-Host -Prompt 'Input server/NTP name. (Add a comma to add multiple servers/NTP)'
net stop w32time
w32tm /config /syncfromflags:manual /manualpeerlist:"$Server"
w32tm /config /reliable:yes
net start w32time
w32tm /query /configuration
w32tm /query /status
w32tm /resync
Clear-Hostar-Host
Write-Output "Machine is now synced to $Server"
""
get-date -displayhint datetime
""
pause
