### Requires NameIT module
Function Initialize-Directories {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][int]$CurrentDepth,
        [Parameter(Mandatory)][int]$MaxDepth
    )
    If ($CurrentDepth -lt $MaxDepth) {
        # Always Generate at least one folder
        New-Item -ItemType Directory -Name $(Invoke-Generate)
        # More folders should be created at shallower depths
        While (Get-Random -Maximum ($MaxDepth - $CurrentDepth)) {
            # Continue generating folders until Get-Random returns 0 (False)
            New-Item -ItemType Directory -Name $(Invoke-Generate)
        }
    }
}