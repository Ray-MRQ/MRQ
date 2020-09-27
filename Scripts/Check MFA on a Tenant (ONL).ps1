Connect-MsolService
$Customer = Read-Host -Prompt 'Enter customerID'

[string]$CSS= @'
    <style>
    body {font-family:Verdana;
           font-size:8pt; 
           background: 	#ffffff}
    h2 {color:black;
        text-align: left;
        text-decoration:underline;
        font-size:18pt;}
    th { color:black;
         background-Color:CadetBlue; }
    tr {color:black}
    TR:Nth-Child(even) {Background-Color: #F0F8FF;}
    table, tr, td, th {padding: 2px; margin: 0px;text-align: center;vertical-align:top}
    table {margin-left: auto;margin-right: auto;}
    </style>
'@



Get-MsolUser -all | where {$_.isLicensed -eq $true} | select UserPrincipalName,@{N="MFA Status"; E={ if( $_.StrongAuthenticationMethods.IsDefault -eq $true) {($_.StrongAuthenticationMethods | Where IsDefault -eq $True).MethodType} else { "Disabled"}}} | ConvertTo-Html -Head $css -Body "<h1>$Customer MFA Report</h1>`n<h5>Generated on $(Get-Date)</h5>" | Out-File "\\onl40fsvm\TechSupport\Engineers\Mo\$Customer-MFAReport.html"
""
echo "Exported to \\onl40fsvm\TechSupport\Engineers\Mo\$Customer-MFAReport.html"
pause