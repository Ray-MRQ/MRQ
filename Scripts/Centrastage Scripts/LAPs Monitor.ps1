#DATTO VARIABLES  ---------------------------------------------------------------------------

$varLocalHost = Hostname
$varAdminAccount = $env:username
$MinPassLength = "12"
$MaxPassLength = "16"
$IncludeSymbol = "true"
$UDFSelection = $env:custom
$RunOnServer = "true"

#FUNCTIONS START ---------------------------------------------------------------------------

function write-DRRMAlert ($message) {
    write-host '<-Start Result->'
    write-host "Alert=$message"
    write-host '<-End Result->'
}

function Get-RandomCharacters($length, $characters) {
    $random = 1..$length | ForEach-Object { Get-Random -Maximum $characters.length }
    $private:ofs=""
    return [String]$characters[$random]
}

function Scramble-String([string]$inputString){
    $characterArray = $inputString.ToCharArray()
    $scrambledStringArray = $characterArray | Get-Random -Count $characterArray.Length
    $outputString = -join $scrambledStringArray
    return $outputString
}

#SCRIPT START ---------------------------------------------------------------------------

if ($RunOnServer -eq $false){
$OSCheck = (Get-WmiObject -Class Win32_OperatingSystem).ProductType

#Checks OS is not a Windows Server or Domain Controller
if($OSCheck -eq 2) {
    write-host "ERROR: Running on a Domain Controller, aborting!"
    exit 1
}elseif($OSCheck -eq 3) {
    write-host "ERROR: Running on a Server, aborting!"
    exit 1
}}

if ($RunOnServer -eq $true) {write-host "Run on DC and Server flag set to true"}

#Removes 3 or 4 to make password the desired length after adding complexity requirements
if ($IncludeSymbol -eq $true){
$MinPassLength = $MinPassLength - 4
$MaxPassLength= $MaxPassLength - 3
$varCharList = "abcdefghijkmnopqrstuvwxzyABCEEFGHJKLMNOPQRSTUVWXYZ1234567890!£%*()_-"
} else {
$MinPassLength = $MinPassLength - 3
$MaxPassLength = $MaxPassLength - 2
$varCharList = "abcdefghijkmnopqrstuvwxzyABCEEFGHJKLMNOPQRSTUVWXYZ1234567890"
}

#Generate Random Number between $MinPassLength and $MaxPassLength
$varPassLength = Get-Random -Minimum $MinPassLength -Maximum $MaxPassLength

#Uses random length and adds 4 extra characters (To make sure it has 1 upper case, 1 lower case, 1 number and a symbol)
$varPassword = Get-RandomCharacters -length $varPassLength -characters $varCharList
$varPassword += Get-RandomCharacters -length 1 -characters 'abcdefghikmnoprstuvwxyz'
$varPassword += Get-RandomCharacters -length 1 -characters 'ABCDEFGHKLMNOPRSTUVWXYZ'
$varPassword += Get-RandomCharacters -length 1 -characters '1234567890'
if ($IncludeSymbol -eq $true){$varPassword += Get-RandomCharacters -length 1 -characters '!£%*()_-'}

$varPassword = Scramble-String $varPassword

$varUserAccount = gwmi -class Win32_UserAccount | Where Domain -eq $varLocalHost | Where Name -eq $varAdminAccount
if ($varUserAccount.Name -eq $varAdminAccount) {
    net user $varAdminAccount $varPassword | Out-Null
    net user $varAdminAccount /Active:YES | Out-Null
    net user $varAdminAccount /expires:never | Out-Null
    net user $varAdminAccount /fullname:$varAdminAccount | Out-Null
    net localgroup administrators $varAdminAccount /add | Out-Null
    }
    else{
    net user $varAdminAccount $varPassword /add /Y | Out-Null
    net user $varAdminAccount /Active:YES | Out-Null
    net user $varAdminAccount /expires:never | Out-Null
    net user $varAdminAccount /fullname:$varAdminAccount | Out-Null
    net localgroup administrators $varAdminAccount /add | Out-Null

    }


$D = Date -Format F
$SD = "Last updated on:"
$RD = "$VARPASSWORD" + " " + $SD + " " + $D

write-DRRMAlert "Healthy: Password set."
Set-ItemProperty -Path HKLM:\SOFTWARE\CentraStage -Name $UDFSelection -Type String -Value "$RD" -Force | Out-Null
Start-Sleep -s 60
Remove-Item "C:\Program Files (x86)\CentraStage\log.txt" -force
