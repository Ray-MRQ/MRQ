set-timezone -id "GMT Standard Time" -passthru
Get-Date -Format “dddd MM/dd/yyyy HH:mm K”
Rename-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\00000409" -NewName "00000409-disabled"
Set-WinDefaultInputMethodOverride -InputTip "0809:00000809"