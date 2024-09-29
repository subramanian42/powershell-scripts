Param(
    [Parameter(Mandatory, HelpMessage="Please enter a valid path")]
    [string]$Path
)
  New-Item $Path # Creates a new file at $Path
  Write-Host "File $Path was created"

