net file 1>nul 2>nul && goto :run || powershell -ex unrestricted -Command "Start-Process -Verb RunAs -FilePath '%comspec%' -ArgumentList '/c %~fnx0 %*'"
goto :eof
:run

NET STOP CAGSERVICE
NET START CAGSERVICE
NET STOP SplashtopRemoteService
NET START SplashtopRemoteService