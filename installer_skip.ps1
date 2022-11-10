[void] [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.VisualBasic")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 

Start-Process powershell.exe -ArgumentList "C:\xampp\htdocs\powershell_scripts\installer.ps1"
Start-Sleep -Milliseconds 2500
[Microsoft.VisualBasic.Interaction]::AppActivate("FirstPopUp")
Start-Sleep -Milliseconds 1000
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
Start-Sleep -Milliseconds 1000
$line = "1,2,3,4,5,6,7,8,9"
foreach ($c in $line.GetEnumerator()) {
    [System.Windows.Forms.SendKeys]::SendWait("{$c}")
    Start-Sleep -Milliseconds 10
}
Start-Sleep -Milliseconds 1000
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
Start-Sleep -Milliseconds 1000
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
Start-Sleep -Milliseconds 1000
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
