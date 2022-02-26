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
$monitorlist = $ENV:mfamonitorlist -split ',' 
$Exclude = $ENV:mfaSkiplist -split ',' 
$recipient = $env:recipient -split ',' 
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

$AllUSers = Get-MsolPartnerContract -All | Where-Object { $_.DefaultDomainName -in $monitorlist } | Get-MsolUser -all | Where-Object {$_.isLicensed -eq $true} | Select-Object DisplayName, UserPrincipalName, @{N = "MFA Status"; E = { 
        if ( $_.StrongAuthenticationRequirements.State -ne $null) { $_.StrongAuthenticationRequirements.State } else { "Disabled" } }
}

$DisabledUsers = foreach ($User in $allusers | Where-Object {$_.UserPrincipalName -notin $Exclude} | Where-Object { $_.'MFA Status' -eq "Disabled" }) {
    "$($User.UserPrincipalName) Has MFA disabled"
$User | Export-CSV c:\temp\mfareport.csv -append -NoTypeInformation
}


if (!$DisabledUsers) {
    write-DRRMAlert 'Healthy'
}
else {
    write-DRRMAlert "Unhealthy. Please check diagnostic data"
    write-DRMMDiag $DisabledUsers
    $attachment="C:\temp\mfareport.csv"
    $Subject = "O365 Alert - MFA Report"
    $Info = 
@" 
O365 Alert - Customers without MFA Report </br>
---------------------------------------------------------------------- </br>    
Please check $env:hostname on Datto RMM to see the alerts for this email or the CSV attached. </br>
---------------------------------------------------------------------- </br>
The following users has been excluded: $Exclude
"@
Send-MailMessage -From $env:sender -To $recipient -Subject $Subject -Body $Info -BodyAsHtml -Attachment $attachment -SmtpServer $env:smtpaddress -Port 25 -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $env:smtpusername, (ConvertTo-SecureString -String "$env:smtppass" -AsPlainText -Force))

Remove-Item C:\temp\mfareport.csv -recurse -force > $null 2>&1
    exit 1
}
 
