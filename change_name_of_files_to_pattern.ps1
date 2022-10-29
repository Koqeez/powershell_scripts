<#
$currentPath = [System.Environment]::CurrentDirectory;
#FOR THIS SCRIPT TO WORK YOU MUST USE join-object MODULE
#install-module join-object
$currentPath = (Get-Item .).FullName;
Get-ChildItem "$currentPath" -Filter *.png;
Get-ChildItem -Path "$currentPath" -Name
#NUMER OF FILES IN THE DIRECTORY
    (Get-ChildItem | Measure-Object).Count
$photo = Get-ChildItem -Path "$currentPath" -Name -Filter "Accent2.png"
    Get-ChildItem -Path "$currentPath" -Name -Filter "Accent2.png" |Select-Object name,@{label = "length";Expression = {$_.name.tostring().Length}}
    Get-ChildItem -Path "$currentPath" -Filter "Accent2.png" |Select-Object name,@{label = "length";Expression = {$_.name.tostring().Length-4}}
$photo.GetType()

function Zip($a1, $a2) {
    while ($a1) {
        $x, $a1 = $a1
        $y, $a2 = $a2
        [tuple]::Create($x, $y)
    }
}
#>

#DEFAULT CURRENT DIRECTORY
param([String]$path=(Get-Item .).FullName)

$FileNames = @();
$Files = @();
$FilesWithNames = @();
#GET ALL ITEM NAMES FROM DIRECTORY TO ONE ARRAY
    foreach($file in Get-ChildItem $path)
    {
    $FileNames += $file | Select-Object name,@{label = "length";Expression = {$_.name.tostring().Length-4}}
    }
#GET ALL OBJECTS FROM DIRECOTORY TO ARRAY
    foreach($file in Get-ChildItem $path)
    {
    $newFile = $file | Select-Object -Property Name, PSPath -ExcludeProperty Length
    $Files += $newFile;
    }
#CONCAT,BUT I'M NOT SURE IF IT IS NEEDED
$FilesWithNames = Join-Object -Left $Files -LeftJoinProperty Name -Right $FileNames -RightJoinProperty Name
#SORTING ARRAY
$FilesWithNames = $FilesWithNames | Sort-Object -Property Length -Descending
#EQUAL NAME
$BiggestFile = $FilesWithNames[0].length;
#$file = $FilesWithNames[5];
foreach($file in $FilesWithNames)
    {
    $value = "";
    if($file.Length -ne $BiggestFile){
        $difference = $BiggestFile - $file.Length;
        for($i = 0;$i -lt $difference;$i++){
            $value = $value + "_";
            }
            $fileName = $file.Name;
            $fileName = $fileName.Remove($fileName.Length-4,4);
            $NewFileName = $fileName + $value;
            $file | Rename-Item -NewName {$_.name -replace $fileName,$NewFileName};
        $print = $file.Length.ToString()+", "+ $BiggestFile.ToString() + ", " + $difference.ToString() +", " + $file.Name.ToString() +", " +$FilesWithNames[0].Name.ToString()+", " +$NewFileName.ToString();
        Write-Output($print);
        }
    }
$FileNames = @();
foreach($file in Get-ChildItem $path)
{
$FileNames += $file | Select-Object name,@{label = "length";Expression = {$_.name.tostring().Length-4}}
}
$FilesNames = $FilesNames | Sort-Object -Property Length -Descending

<#
$Files = Get-ChildItem "$currentPath";

Foreach($File in $Files){
$arrayOfFiles += Select-Object name,@{label = "length";Expression = {$_.name.tostring().Length-4}}
#$arrayOfFiles += New-Object psobject -Property @{'FileName' = $File.name; 'Length' = $File.Length}
}
$FilesNames = Get-ChildItem -Path "$currentPath" -Name;
Foreach($File in $FilesNames){
$Names += @{'FileName' = $File; 'Length' = $File.Length}
}
Get-ChildItem $targetDir -recurse | Select-String -pattern "$pattern" | group path | select name
Rename-Item $arrayOfFiles[0] -NewName "Accent2.png"
$arrayOfFiles[0] | Measure-Object -Character
$max = 0
foreach($photo in $arrayOfFiles){$photo.GetType()}
for($i = 0;$i -le 5; ++$i){}

write-output($fileName.GetType());

$j = 6;
$value = "";
for($i = 0;$i -lt $j;$i++){
    $value = $value + "_";

}

$file = get-childitem ||DIRECTORY||
$file | Rename-Item -NewName  {$_.Name + "______" + $_.Extension} -f $value;
$file | Rename-Item -NewName {$_.name -replace $fileName,$NewFileName};
#>