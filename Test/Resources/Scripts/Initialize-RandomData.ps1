<#
    .SYNOPSIS Depth First Random Directory and File Generator
#>
Function Initialize-RandomData {
    [CmdletBinding()]
    param (
        # Path to Generate Data at.
        [Parameter(Mandatory)]
        [System.IO.DirectoryInfo]$Path,

        # Depth of Data [Exclusive] to generate.
        [Parameter()]
        [Int]$Depth = 4
    )
    Begin {
        # Create Threadsafe Stack
        $Structure = [System.Collections.Stack]::Synchronized([System.Collections.Stack]::new())
        # Location to return to after complete.
        $ReturnLocation = Get-Location

        # Create the Path folder if it doesn't exist.
        If (-not (Test-Path $Path)) {
            $Parent = Split-Path -Path $Path -Parent
            $Leaf   = Split-Path -Path $Path -Leaf
            New-Item -Path $Parent -Name $Leaf -ItemType Directory
        }

        # Add Depth to Path object
        $Path | Add-Member -MemberType NoteProperty -Name 'Depth' -Value 1
        # Add Path object to Structure
        $Structure.Push($Path)
    }
    Process {
        while ($Structure.Count -ne 0) {
            $NextLocation = $Structure.Pop()
            Set-Location $NextLocation
            Initialize-Directories -CurrentDepth $NextLocation.Depth -MaxDepth $Depth | `
                Add-Member -MemberType NoteProperty -Name 'Depth' -Value $($($NextLocation.Depth)+1) -PassThru | `
                ForEach-Object {$Structure.Push($_)}
            Initialize-Files -GenerateData -NumFiles $(Get-Random -Maximum 5)
        }
    }
    End {
        Set-Location $ReturnLocation
    }
}