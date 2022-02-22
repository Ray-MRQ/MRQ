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
######### Secrets #########

$credential = New-Object System.Management.Automation.PSCredential($ApplicationId, $ApplicationSecret)

Try{
$aadGraphToken = New-PartnerAccessToken -ApplicationId $ApplicationId -Credential $credential -RefreshToken $refreshToken -Scopes 'https://graph.windows.net/.default' -ServicePrincipal 
$graphToken = New-PartnerAccessToken -ApplicationId $ApplicationId -Credential $credential -RefreshToken $refreshToken -Scopes 'https://graph.microsoft.com/.default'
} catch{
    write-DRRMAlert "Could not get tokens: $($_.Exception.Message)"
    exit 1
}

Connect-MsolService -AdGraphAccessToken $aadGraphToken.AccessToken -MsGraphAccessToken $graphToken.AccessToken
$customers = Get-MsolPartnerContract -All | Where-Object { $_.DefaultDomainName -notin $skiplist }
$DeletedUserlist = foreach ($customer in $customers) {
    write-host "Getting Deleted users for $($Customer.name)" -ForegroundColor Green
    $DeletedUsers = Get-MsolUser -ReturnDeletedUsers -TenantId $($customer.TenantID) | Select-Object DisplayName, UserPrincipalName, SoftDeletionTimestamp
    foreach($User in $DeletedUsers){ "$($user.UserPrincipalName) has been deleted on $($User.SoftDeletionTimestamp)" }
    foreach($User in $DeletedUsers){ $User | Export-CSV c:\temp\deletedusersreport.csv -append -NoTypeInformation}
}

if (!$DeletedUserlist) {
    write-DRRMAlert 'Healthy'
}
else {
    write-DRRMAlert "Unhealthy. Please check diagnostic data"
    write-DRMMDiag $DeletedUserlist
    $Import = Import-Csv -Path c:\temp\deletedusersreport.csv | ConvertTo-Html -Fragment
    $Info = 
@"
O365 Alert - Deleted users in the last 30d report </br>
---------------------------------------------------------------------- </br>
$Import
---------------------------------------------------------------------- </br>
The following tenants has been excluded from this report: $SkipList
"@
    $From = "Centrastage - O365 Alert <O365Alert@onlinesupport.co.uk>" 
    $To = "ITSupport@onlinesupport.co.uk","alerts@onlinesupport.co.uk"
    $Subject = "O365 Alert - Deleted users in the last 30d report"
    Send-MailMessage -From $From -To $To -Subject $Subject -Body $Info -BodyAsHtml -SmtpServer <smtp server>-Port 25 -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "<smtp username>", (ConvertTo-SecureString -String "<smtp password>" -AsPlainText -Force))
     
    Remove-Item c:\temp\deletedusersreport.csv -recurse -force > $null 2>&1
    exit 1
}
 
