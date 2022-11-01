param([String]$path = (Get-Item .).FullName)

$FileNames = @();

foreach ($file in Get-ChildItem $path -Filter *.png) {
    $FileNames += $file | Select-Object name, @{label = "length"; Expression = { $_.name.tostring().Length - 4 } }
}
Write-Output($FileNames);