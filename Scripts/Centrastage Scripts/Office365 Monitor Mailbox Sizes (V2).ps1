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
$mailboxmonitor = $ENV:mailboxmonitor -split ','
$recipient = $ENV:recipient -split ','
######### Secrets #########

$Threshold = "90"

$credential = New-Object System.Management.Automation.PSCredential($ApplicationId, $ApplicationSecret)
$aadGraphToken = New-PartnerAccessToken -ApplicationId $ApplicationId -Credential $credential -RefreshToken $refreshToken -Scopes 'https://graph.windows.net/.default' -ServicePrincipal -Tenant $tenantID 
$graphToken = New-PartnerAccessToken -ApplicationId $ApplicationId -Credential $credential -RefreshToken $refreshToken -Scopes 'https://graph.microsoft.com/.default' -ServicePrincipal -Tenant $tenantID 
Connect-MsolService -AdGraphAccessToken $aadGraphToken.AccessToken -MsGraphAccessToken $graphToken.AccessToken
$customers = Get-MsolPartnerContract -All | Where-Object { $_.DefaultDomainName -in $mailboxmonitor }

foreach ($customer in $customers) {
    write-host "Getting started for $($Customer.name)" -foregroundcolor green
    $token = New-PartnerAccessToken -ApplicationId 'a0c73c16-a7e3-4564-9a95-2bdf47383716'-RefreshToken $ExchangeRefreshToken -Scopes 'https://outlook.office365.com/.default' -Tenant $customer.TenantId
    $tokenValue = ConvertTo-SecureString "Bearer $($token.AccessToken)" -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential($upn, $tokenValue)
    $customerId = $customer.DefaultDomainName
    $session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https://ps.outlook.com/powershell-liveid?DelegatedOrg=$($customerId)&amp;BasicAuthToOAuthConversion=true" -Credential $credential -Authentication Basic -AllowRedirection
    Import-PSSession $session -allowclobber -Disablenamechecking


Write-Host "Finding mailboxes..."
$Mbx = Get-Mailbox -ResultSize Unlimited | Select DisplayName, ProhibitSendReceiveQuota, DistinguishedName
$Report = [System.Collections.Generic.List[Object]]::new()
ForEach ($M in $Mbx) {
    # Find current usage
    Write-Host "Processing" $M.DisplayName
    $Mailbox = $M.DisplayName
    $ErrorText = $Null
    $MbxStats = Get-MailboxStatistics -Identity $M.DistinguishedName | Select ItemCount, TotalItemSize
    # Return byte count of quota used
    [INT64]$QuotaUsed = [convert]::ToInt64(((($MbxStats.TotalItemSize.ToString().split("(")[-1]).split(")")[0]).split(" ")[0]-replace '[,]',''))
    # Byte count for mailbox quota
    [INT64]$MbxQuota = [convert]::ToInt64(((($M.ProhibitSendReceiveQuota.ToString().split("(")[-1]).split(")")[0]).split(" ")[0]-replace '[,]',''))
    $MbxQuotaGB = [math]::Round(($MbxQuota/1GB),2)
    $QuotaPercentUsed = [math]::Round(($QuotaUsed/$MbxQuota)*100,2)
    $QuotaUsedGB = [math]::Round(($QuotaUsed/1GB),2)
    If ($QuotaPercentUsed -gt $Threshold) {
       Write-Host $M.DisplayName "current mailbox use is above threshold at" $QuotaPercentUsed -Foregroundcolor Red
       $ErrorText = "Mailbox quota over threshold" 
       $ReportLine = [PSCustomObject]@{ 
        Mailbox          = $M.DisplayName 
        MbxQuotaGB       = $MbxQuotaGB
        MbxSizeGB        = $QuotaUsedGB
        QuotaPercentUsed = $QuotaPercentUsed
        ErrorText        = $ErrorText} 
   $Report.Add($ReportLine)
   
}}}

Remove-PSSession $session
$Report | Sort Mailbox | Export-csv -NoTypeInformation c:\temp\MailboxQuotaReport.csv

$FileCheck = test-path c:\temp\MailboxQuotaReport.csv

if ($FileCheck) {
    write-DRRMAlert "Unhealthy. Please check email report"
    $Import = Import-Csv -Path c:\temp\MailboxQuotaReport.csv | ConvertTo-Html -Fragment

$Body = @"
O365 Alert - Mailbox near quota report
----------------------------------------------------------------------
$Import
"@ 

    $Subject = "O365 Alert - Mailbox near quota reportt"
    Send-MailMessage -From $env:sender -To $recipient -Subject $Subject -Body $body -BodyAsHtml -SmtpServer $env:smtpaddress -Port 25 -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $env:smtpusername, (ConvertTo-SecureString -String "$env:smtppass" -AsPlainText -Force))
    Remove-Item c:\temp\MailboxQuotaReport.csv -recurse -force > $null 2>&1
    exit 1
}
else {
    write-DRRMAlert 'Healthy'
    Exit 0
}