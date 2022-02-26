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
gci ENV:



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

$customers = Get-MsolPartnerContract -All | Where-Object { $_.DefaultDomainName -notin $skiplist }
$AlertingTime = (Get-Date).AddHours(-2)

$SyncState = foreach ($client in $customers) { 
    Write-host "Getting dirsync information for $($client.Name)"
$SyncTimes = Get-MsolCompanyInformation -TenantId $client.TenantId

if($SyncTimes.LastPasswordSyncTime -le $AlertingTime -and $null -ne $SyncTimes.LastPasswordSyncTime) { "$($client.Name): Passwords have not been synced for 2 hours or more." | add-content c:\temp\adsyncreport.txt} 
if($SyncTimes.LastDirSyncTime -le $AlertingTime -and $null -ne $SyncTimes.LastPasswordSyncTime) { "$($client.Name): Directory has not been synced for 2 hours or more."  | add-content c:\temp\adsyncreport.txt}
}
   

$FileCheck = test-path c:\temp\adsyncreport.txt

if ($FileCheck) {
    write-DRRMAlert "Unhealthy. Please check diagnostic data"
    write-DRMMDiag $SyncState
    
    [string]$content = "" 
    $logs = Get-Content c:\temp\adsyncreport.txt 

foreach ($log in $logs) { $content = $content + $log + " `r`n"}
$Body = @"
O365 Alert - Failed AD Sync Status Report
----------------------------------------------------------------------
$content
"@ 

    $Subject = "O365 Alert - Failed AD Sync Status Report"
    Send-MailMessage -From $env:sender -To $recipient -Subject $Subject -Body $body -SmtpServer $env:smtpaddress -Port 25 -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $env:smtpusername, (ConvertTo-SecureString -String "$env:smtppass" -AsPlainText -Force))
    Remove-Item c:\temp\adsyncreport.txt -recurse -force > $null 2>&1
    exit 1
}
else {
    write-DRRMAlert 'Healthy'
    Exit 0
}