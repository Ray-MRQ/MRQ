﻿Write-Outpute-Output "Make sure you run as administrator + accept any UAC prompts, hit enter to confirm"
pause
get-appxpackage Microsoft.GamingServices | remove-AppxPackage -allusers
Start-Process ms-windows-store://pdp/?productid=9MWPM2CQNLHN
Write-Output "The Microsoft Store should appear with Gaming Services, go through any prompts and it should install on it's own. Hit enter to close this prompt/script."
pause