Write-Output "Run as administrator"
Get-AppxPackage Microsoft.WindowsFeedbackHub| Remove-AppxPackage
Write-Output "Windows Feedback Hub is now uninstalled."