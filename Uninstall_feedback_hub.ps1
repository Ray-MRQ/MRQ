echo "Run as administrator"
Get-AppxPackage Microsoft.WindowsFeedbackHub| Remove-AppxPackage
echo "Windows Feedback Hub is now uninstalled."