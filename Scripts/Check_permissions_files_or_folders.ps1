
$ShareDrive = Read-Host -Prompt 'Input the shared path you would like to get ACL permissions for'
$FolderPath = dir -Directory -Path $ShareDrive -Recurse -Force
$Report = @()
Foreach ($Folder in $FolderPath) {
    $Acl = Get-Acl -Path $Folder.FullName
    foreach ($Access in $acl.Access)
        {
            $Properties = [ordered]@{'FolderName'=$Folder.FullName;'AD
Group or
User'=$Access.IdentityReference;'Permissions'=$Access.FileSystemRights;'Inherited'=$Access.IsInherited}
            $Report += New-Object -TypeName PSObject -Property $Properties
        }
}
""
$CSVName = Read-Host -Prompt 'Input filename (this will store in c:\temp)'
$Report | Export-Csv -path "C:\temp\$CSVName-FolderPermissions.csv"