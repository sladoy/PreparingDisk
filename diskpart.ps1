Import-Module .\Powershell\PreparingDisk\Functions\functions.ps1
#---------------Variables---------------------------------------------------

# From where you should take the files. In the end it should take from the server
$source = "C:\Users\dawid\Desktop\Test\*"

$IniFile = .\Powershell\PreparingDisk\settings.ini

$IniContent = Get-IniValues -filePath $IniFile
#---------------------------------------------------------------------------
Write-Output "Welcome to TOTS Program made in Power(S)Hell
        It will prepare quickly pendrive with current SCCM Package"


# List all USB devices
Write-Output "If you cannot see your drive, check if it has smaller than 128 GB.
                This have been made to prevent accidental formating of wrong pendrive.
                BE CAREFUL WHAT YOU'RE CHOOSING!"



Get-Disk | Where-Object -FilterScript {$_.Bustype -Eq "USB" -and $_.Size -lt $Max_Size} | Format-Table


# Input number of your disk
$drive = Read-Host "Choose drive you want to format"
Write-Host "You selected drive no. "$drive
"
"

$decision = Read-Host "Are you sure? Write Y to confirm"

IF($decision -eq 'Y')
{
        
        Prepare_Disk
        Copy_Files
}
else
{
        # Leaving the Powershell terminal
        Exit-PSHostProcess
}







