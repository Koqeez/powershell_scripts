#DEFAULT CURRENT DIRECTORY
param([String]$path = (Get-Item .).FullName)

$FileNames = @();
$Files = @();
$FilesWithNames = @();
#GET ALL ITEM NAMES FROM DIRECTORY TO ONE ARRAY
foreach ($file in Get-ChildItem $path -Filter *.png) {
    $FileNames += $file | Select-Object name, @{label = "length"; Expression = { $_.name.tostring().Length - 4 } }
}
#GET ALL OBJECTS FROM DIRECOTORY TO ARRAY
foreach ($file in Get-ChildItem $path -Filter *.png) {
    $newFile = $file | Select-Object -Property Name, PSPath -ExcludeProperty Length
    $Files += $newFile;
}
#CONCAT,BUT I'M NOT SURE IF IT IS NEEDED
$FilesWithNames = Join-Object -Left $Files -LeftJoinProperty Name -Right $FileNames -RightJoinProperty Name
#SORTING ARRAY
$FilesWithNames = $FilesWithNames | Sort-Object -Property Length -Descending
$i = 0;
$value = "";
foreach ($file in $FilesWithNames) {
    switch ($i) {
        { $i -lt 10 } {
            $value = "00" + $i;
        }
        { $i -lt 100 -and $i -gt 9 } {
            $value = "0" + $i;
        }
        { $i -lt 1000 -and $i -gt 99 } {
            $value = "" + $i;
        }
    }
    $fileName = $file.Name;
    $fileName = $fileName.Remove($fileName.Length - 4, 4);
    $NewFileName = $fileName + $value;
    $file | Rename-Item -NewName { $_.name -replace $fileName, $NewFileName };
    $i++;
}