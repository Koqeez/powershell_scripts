[void] [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.VisualBasic")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 

Start-Process -FilePath "mmc.exe" -ArgumentList "compmgmt.msc"
Start-Sleep -Milliseconds 2500

[Microsoft.VisualBasic.Interaction]::AppActivate("Computer Management")
Start-Sleep -Milliseconds 1000
[System.Windows.Forms.SendKeys]::SendWait("{DOWN 3}")
Start-Sleep -Milliseconds 1000
[System.Windows.Forms.SendKeys]::SendWait("{RIGHT 2}")
Start-Sleep -Milliseconds 1000
[System.Windows.Forms.SendKeys]::SendWait("{DOWN 1}")
Start-Sleep -Milliseconds 1000
[System.Windows.Forms.SendKeys]::SendWait("{RIGHT 1}")
Start-Sleep -Milliseconds 1000
[System.Windows.Forms.SendKeys]::SendWait("{DOWN 2}")