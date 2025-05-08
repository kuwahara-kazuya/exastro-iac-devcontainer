@echo off
:: Enable WinRM service
call winrm quickconfig -force

:: Allow Basic authentication
call winrm set winrm/config/service/Auth @{Basic="true"}

:: Allow unencrypted traffic
call winrm set winrm/config/service @{AllowUnencrypted="true"}

:: Configure WinRM listener for HTTP
call winrm create winrm/config/Listener?Address=*+Transport=HTTP

:: Set firewall rule to allow WinRM traffic
netsh advfirewall firewall add rule name="WinRM HTTP" dir=in action=allow protocol=TCP localport=5985

echo WinRM configuration completed.
