function write-DRMMDiag ($messages) {
    write-host  '<-Start Diagnostic->'
    foreach ($Message in $Messages) { $Message }
    write-host '<-End Diagnostic->'
} 

function write-DRRMAlert ($message) {
    write-host '<-Start Result->'
    write-host "Alert=$message"
    write-host '<-End Result->'
}

######### Secrets #########
$ApplicationId = $ENV:O365ApplicationID
$ApplicationSecret = ConvertTo-SecureString $($ENV:O365ApplicationSecret) -Force -AsPlainText
$TenantID = $ENV:O365TenantID
$RefreshToken = $ENV:O365RefreshToken
$ExchangeRefreshToken = $ENV:O365ExchangeRefreshToken
$UPN = $ENV:O365UPN
$Skiplist = $ENV:Skiplist -split ','
$Recipient = $env:recipient -split ','
######### Secrets #########


$credential = New-Object System.Management.Automation.PSCredential($ApplicationId, $ApplicationSecret)

Try {
    $aadGraphToken = New-PartnerAccessToken -ApplicationId $ApplicationId -Credential $credential -RefreshToken $refreshToken -Scopes 'https://graph.windows.net/.default' -ServicePrincipal 
    $graphToken = New-PartnerAccessToken -ApplicationId $ApplicationId -Credential $credential -RefreshToken $refreshToken -Scopes 'https://graph.microsoft.com/.default'
}
catch {
    write-DRRMAlert "Could not get tokens: $($_.Exception.Message)"
    exit 1
}


Connect-MsolService -AdGraphAccessToken $aadGraphToken.AccessToken -MsGraphAccessToken $graphToken.AccessToken

$LastDay = (get-date).AddDays(-1)
$customers = Get-MsolPartnerContract -All | Where-Object { $_.DefaultDomainName -notin $skiplist }
$ChangedUsers = foreach ($customer in $customers) {
    write-host "getting users for $($Customer.Name)"
    try {
        $adminemails = Get-MsolRoleMember -TenantId $customer.tenantid -RoleObjectId (Get-MsolRole -RoleName "Company Administrator").ObjectId
        $Users = $adminemails | get-msoluser -TenantId $customer.TenantId | Select-Object DisplayName, UserPrincipalName, LastPasswordChangeTimestamp
        foreach ($User in $Users) {
            if ($User.LastPasswordChangeTimestamp -gt $LastDay) { "$($User.UserPrincipalName) has changed his password in the last 24 hours." }
            if ($User.LastPasswordChangeTimestamp -gt $LastDay) { $User | Export-CSV c:\temp\passwordchangereport.csv -append -NoTypeInformation}
        }
    }
    catch {
        continue
    }
}

if (!$ChangedUsers) {
    write-DRRMAlert 'Healthy'
}
else {
    write-DRRMAlert "Unhealthy. Please check diagnostic data"
    write-DRMMDiag $ChangedUsers
    $Import = Import-Csv -Path C:\temp\passwordchangereport.csv | ConvertTo-Html -Fragment
    $Info = 
@"
O365 Alert - Global Admin Password Change Report </br>
---------------------------------------------------------------------- </br>
$Import
"@
    $Subject = "O365 Alert - Global Admin Password Change Report"
    Send-MailMessage -From $env:sender -To $recipient -Subject $Subject -Body $Info -BodyAsHtml -SmtpServer $env:smtpaddress -Port 25 -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $env:smtpusername, (ConvertTo-SecureString -String "$env:smtppass" -AsPlainText -Force))
                         
    Remove-Item C:\temp\passwordchangereport.csv -recurse -force > $null 2>&1
    exit 1
}