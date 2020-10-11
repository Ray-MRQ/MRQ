Write-Output "Teams RAM fix"
Write-Output "This will kill Teams if it's running."
Get-Process teams -ErrorAction SilentlyContinue | Stop-Process -PassThru
Remove-Item "$env:APPDATA\Microsoft\Teams\Blob_Storage\*.*"
Remove-Itemove-Item "$env:APPDATA\Microsoft\Teams\Cache\*.*"
Remove-Item "$env:APPDATA\Microsoft\Teams\databases\*.*" 
Remove-Item "$env:APPDATA\Microsoft\Teams\GPUCache\*.*" 
Remove-Item "env:appdata\Microsoft\Teams\IndexedDB\*.db" 
Remove-Item "$env:APPDATA\Microsoft\Teams\Local Storage\*.*"
Remove-Item "$env:APPDATA\Microsoft\Teams\tmp\*.*" 
pause