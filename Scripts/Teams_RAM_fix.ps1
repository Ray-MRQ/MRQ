echo "Teams RAM fix"
echo "This will kill Teams if it's running."
ps teams -ErrorAction SilentlyContinue | kill -PassThru
del "$env:APPDATA\Microsoft\Teams\Blob_Storage\*.*"
del "$env:APPDATA\Microsoft\Teams\Cache\*.*"
del "$env:APPDATA\Microsoft\Teams\databases\*.*" 
del "$env:APPDATA\Microsoft\Teams\GPUCache\*.*" 
del "env:appdata\Microsoft\Teams\IndexedDB\*.db" 
del "$env:APPDATA\Microsoft\Teams\Local Storage\*.*"
del "$env:APPDATA\Microsoft\Teams\tmp\*.*" 
pause