[void] [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.VisualBasic")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 

Start-Process -FilePath "notepad.exe"
Start-Sleep -Milliseconds 2500

[Microsoft.VisualBasic.Interaction]::AppActivate("Notepad")
[System.Windows.Forms.SendKeys]::SendWait("+{h}")
[System.Windows.Forms.SendKeys]::SendWait("{e}")
[System.Windows.Forms.SendKeys]::SendWait("{l}")
[System.Windows.Forms.SendKeys]::SendWait("{l}")
[System.Windows.Forms.SendKeys]::SendWait("{o}")

$line = "coscoscoscosocosdosdoasodasodoasdoasodoasdoasod"
foreach($c in $line.GetEnumerator()){
    [System.Windows.Forms.SendKeys]::SendWait("{$c}")
    Start-Sleep -Milliseconds 10
}