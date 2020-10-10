Write-Output "Check all ADUsers"

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

Import-Module ActiveDirectory Get-ADUsers -Filter * |Select-Object sAMAccountName,givenName|  ConvertTo-Html -Head $css -Body "<h1>$Customer MFA Report</h1>`n<h5>Generated on $(Get-Date)</h5>" | Out-File "C:\temp\ADUsers.html"
""
Write-Output "C:\temp\ADUsers.html"
pause
