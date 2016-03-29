﻿# Parameters
#   All parameters are optional. They need to be provided if this is run at developers' local environment.
#   If they are not provided, the environment variables from AppVeyor will be used as default.
#
#   $Config: Name of configuration. eg) Debug, Release
Param(
    [string] [Parameter(Mandatory=$false)] $Config
)

$configuration = "Debug"

if (![string]::IsNullOrWhiteSpace($Config))
{
    $configuration = $Config
}

$project = "Aliencube.EntityContextLibrary"

# Display project name
Write-Host "`nPublish the $project project to as a NuGet package`n" -ForegroundColor Green

dnu restore -f https://www.myget.org/F/aspnet-contrib/api/v3/index.json

dnu pack .\src\$project --out .\artifacts\bin\$project --configuration $Config

Get-ChildItem *.nupkg -Recurse

if ($LASTEXITCODE -ne 0) {
    $host.SetShouldExit($exitCode)
}
