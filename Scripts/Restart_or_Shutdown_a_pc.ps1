Write-Outpute-Output "Restart/Shutdown a PC remotely"
""

$PCName = Read-Host -prompt 'Enter PC name'
""
$User = Read-Host -prompt 'Enter Administrator username for the remote PC in Domain\Username format'

""
do { $myInput = (Read-Host 'Restart or shutdown a remote PC? (restart/shutdown/exit)').ToLower() } while ($myInput -notin @('restart','shutdown','exit'))
if ($myinput -eq 'restart') { 
""
Write-Output "Restarting remote PC if possible..."
""
runas /noprofile /user:$user "powershell shutdown /r /m \\$PCName /t 0"
}
if ($myinput -eq 'shutdown') {
runas /noprofile /user:$user "powershell shutdown /s /m \\$PCName"
}
if ($myinput -eq 'exit') {
exit
}
pause