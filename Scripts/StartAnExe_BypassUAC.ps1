$Username = ''
$Password = ''
$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($Username,$SecurePassword)
 
Start-Process powershell.exe  -Credential $Credential -ArgumentList "(Start-Process -FilePath '\\some\folder\test.exe').ExitCode"