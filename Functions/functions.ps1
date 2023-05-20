Function Prepare_Disk {
    # Clean Disk
    Get-Disk $drive | Clear-Disk -RemoveData -Confirm

    # Create New Partition
    New-Partition -DiskNumber $drive -UseMaximumSize -IsActive -DriveLetter 'Z' | Format-Volume -FileSystem NTFS -NewFileSystemLabel SCCM -Force

}

Function Copy_Files {

    Copy-Item $source -Destination $destination -Recurse


}

# Function to retrieve values from an INI file
function Get-IniValues ($filePath) {
    $iniContent = @{}       # Initialize an empty hashtable to store the INI values
    $section = "General"       # Default section name is "Root"
    $lines = Get-Content -Path $filePath    # Read the content of the INI file
    foreach ($line in $lines) {
        $trimmedLine = $line.Trim()    # Remove leading and trailing whitespace from the line

        # Skip empty lines and comments
        if (-not [string]::IsNullOrWhiteSpace($trimmedLine) -and -not $trimmedLine.StartsWith(";")) {

            # Check for section header
            if ($trimmedLine.StartsWith("[") -and $trimmedLine.EndsWith("]")) {
                # Extract the section name
                $section = $trimmedLine.Substring(1, $trimmedLine.Length - 2).Trim()
                $iniContent[$section] = @{}    # Create a new hashtable for the section
            }
            else {
                # Parse key-value pairs
                $splitLine = $trimmedLine -split "=", 2    # Split the line into key-value pair
                if ($splitLine.Length -eq 2) {
                    $key = $splitLine[0].Trim()    # Extract the key
                    $value = $splitLine[1].Trim()  # Extract the value
                    $iniContent[$section][$key] = $value    # Store the key-value pair in the section hashtable
                }
            }
        }
    }

    return $iniContent    # Return the hashtable containing the INI values
}
