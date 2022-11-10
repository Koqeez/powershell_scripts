[void] [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.VisualBasic")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 

$useip = [System.Windows.Forms.MessageBox]::Show("Do you want to continue?", "FirstPopUp", 3)
if ($useip -eq "Yes") {
    $ipnumber = Read-Host("enter a number");
    [System.Windows.Forms.MessageBox]::Show("$ipnumber", "Your lucky numbers are", 2)
}
$result = [System.Windows.Forms.MessageBox]::Show('Are you sure?' , "Info" , 4)
if ($result -eq 'Yes') {
    Write-Host("Ok")
}