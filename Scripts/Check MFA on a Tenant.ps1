Connect-MsolService
Get-MsolUser -all | where {$_.isLicensed -eq $true} | select UserPrincipalName,@{N="MFA Status"; E={ if( $_.StrongAuthenticationMethods.IsDefault -eq $true) {($_.StrongAuthenticationMethods | Where IsDefault -eq $True).MethodType} else { "Disabled"}}} | Export-CSV -Path C:\Users\$env:USERNAME\Desktop\MFAReport.csv
echo "Exported to C:\Users\$env:USERNAME\Desktop\MFAReport.csv"
pause