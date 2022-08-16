#### Import Test Script Functions ####
$Test_Scripts_Path = (Resolve-Path "$PSScriptRoot\Test\Resources\Scripts")
Get-ChildItem $Test_Scripts_Path | ForEach-Object {
    . $($_.FullName)
}


#### Set Variables ####
$Source_Path = 'G:\Source'


#### Initialize Test Data ####
Initialize-RandomData -Path $Source_Path -Depth 5


#### Run Tests ####
# TODO: Write Tests


#### Clean Up Test Data
Get-ChildItem -Path $Source_Path | Remove-Item -Recurse -Force