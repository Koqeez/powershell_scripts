$WarningPreference = 'SilentlyContinue'
for ($i = 79; $i -le 65535; $i++) {
    Get-Process -Id (Get-NetTCPConnection -LocalPort $i).OwningProcess -f
    Write-Output($output);
}
Get-Process -Id (Get-NetUDPEndpoint -LocalPort 8080).OwningProcess
Get-Process -Id (Get-NetTCPConnection -LocalPort 80).OwningProcess 