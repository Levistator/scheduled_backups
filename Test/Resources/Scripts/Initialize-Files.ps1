### Requires RandomData module
Function Initialize-Files {
    [CmdletBinding()]
    Param (
        # Should the files contain data?
        [Parameter()][Switch]$GenerateData,
        # How many files to create in current directory.
        [Parameter()][int]$NumFiles = 5
    )
    New-RandomData -NoRandomData:$(-not $GenerateData) -Count $NumFiles
}