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



Get-MsolUser -all | Where-Object {$_.isLicensed -eq $true} | Select-Object UserPrincipalName,@{N="MFA Status"; E={ if( $_.StrongAuthenticationMethods.IsDefault -eq $true) {($_.StrongAuthenticationMethods | Where-Object IsDefault -eq $True).MethodType} else { "Disabled"}}} | ConvertTo-Html -Head $css -Body "<h1>$Customer MFA Report</h1>`n<h5>Generated on $(Get-Date)</h5>" | Out-File "c:\Users\env:username\desktop\$Customer-MFAReport.html"
""
Write-Output "c:\Users\env:username\desktop\$Customer-MFAReport.html"
pause