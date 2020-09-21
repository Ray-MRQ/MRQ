Connect-MsolService
$Customer = Read-Host -Prompt 'Enter customerID'
Get-MsolUser -all | where {$_.isLicensed -eq $true} | select UserPrincipalName,@{N="MFA Status"; E={ if( $_.StrongAuthenticationMethods.IsDefault -eq $true) {($_.StrongAuthenticationMethods | Where IsDefault -eq $True).MethodType} else { "Disabled"}}} | Export-CSV -Path "\\onl40fsvm\TechSupport\Engineers\Mo\$Customer-MFAReport.csv"
""
echo "Exported to \\onl40fsvm\TechSupport\Engineers\Mo\$Customer-MFAReport.csv"