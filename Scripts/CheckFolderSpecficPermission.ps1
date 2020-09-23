while($true){
$ShareDrive = Read-Host -Prompt 'Input the shared path you would like to get ACL permissions for'
$ExportfileName= Read-Host -Prompt 'Enter File export name'
get-acl $ShareDrive | Format-Table | Export-Csv -path "C:\temp\$ExportfileName-FolderPermissions.csv"
echo "Exit as needed from the prompt."
}