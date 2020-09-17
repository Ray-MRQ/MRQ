    $ver = $host | select version
    if ($ver.Version.Major -gt 1)  {$Host.Runspace.ThreadOptions = "ReuseThread"}

    # Verify that user running script is an administrator
    $IsAdmin=[Security.Principal.WindowsIdentity]::GetCurrent()
    If ((New-Object Security.Principal.WindowsPrincipal $IsAdmin).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator) -eq $FALSE)
    {
      "`nERROR: You are NOT an administrator.  Run this script after using Run As administrator account."
      pause
        exit
    }
Invoke-WebRequest "https://onl-my.sharepoint.com/:u:/g/personal/mohammed_quashem_onlinesupport_co_uk/ESAYxk0w24ZDssEcyxe7CQcBncnMBOFVrC6KncyDvZUB-w?e=gixpBi&download=1" -outfile c:\temp\Photoviewer.reg
Invoke-Command {reg import C:\temp\Photoviewer.reg *>&1 | Out-Null}
Remove-Item "c:\temp\photoviewer.reg"
echo "Recommended to restart after running the script, check the photo viewer is installed via open with on a compataible image file. Make sure to change default app to this."
pause