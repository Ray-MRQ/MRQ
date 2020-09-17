    $ver = $host | select version
    if ($ver.Version.Major -gt 1)  {$Host.Runspace.ThreadOptions = "ReuseThread"}

    # Verify that user running script is an administrator
    $IsAdmin=[Security.Principal.WindowsIdentity]::GetCurrent()
    If ((New-Object Security.Principal.WindowsPrincipal $IsAdmin).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator) -eq $FALSE)
    {
      "`nERROR: You are NOT an administrator.  Run this script after using Run As administrator."
      pause
        exit
    }
echo "Set time to DC"
$Server = Read-Host -Prompt 'Input server/NTP name. (Add a comma to add multiple servers/NTP)'
net stop w32time
w32tm /config /syncfromflags:manual /manualpeerlist:"$Server"
w32tm /config /reliable:yes
net start w32time
w32tm /query /configuration
w32tm /query /status
w32tm /resync
pause
