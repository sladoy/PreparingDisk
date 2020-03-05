Function Prepare_Disk
{
                # Clean Disk
                Get-Disk $drive | Clear-Disk -RemoveData -Confirm

                # Create New Partition
                New-Partition -DiskNumber $drive -UseMaximumSize -IsActive -DriveLetter 'Z' | Format-Volume -FileSystem NTFS -NewFileSystemLabel SCCM -Force

}

Function Copy_Files
{

        Copy-Item $source -Destination $destination -Recurse


}
#---------------Variables---------------------------------------------------

# From where you should take the files. In the end it should take from the server
$source = "C:\Users\dawid\Desktop\Test\*"

$destination = 'Z:'

# Max_Size is 128 GB converted to Bytes
$Max_Size = 137438953472
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







