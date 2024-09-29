# This script creates a backup of the path and stores it in a destination path
# Additional functionality which allows the script to check if the backup already exists and if so prompts the user whether to update existing backup
Param(
    [string]$Path = './app',
    [string]$DestinationPath = './',
    [Switch]$PathIsWebapp
)

#add condition to check if the current path is Webapp 

if($PathIsWebapp -eq $True)
{
  try{

    $GetContainsWebAppFiles = "$((Get-ChildItem $Path).Extension |sort-Object -Unique)" -match  "\.js|\.html|\.css"
    
    if(-Not $GetContainsWebAppFiles)
    {
        Throw "Not a web app"

    } else
    {
     Write-Host "Source files look good, Continuing"
    }
  } catch
  {
    throw "backup can not be created due to $($_.Exception.Message)"
  }
}

if (-Not (Test-Path $Path)) # checks to ensure the $path exists
{
  Throw "The source directory $Path does not exist, please specify an existing directory"
}

  $date = Get-Date -format "dd-MM-yyyy"
  $backupPath = "$($DestinationPath + 'backup-'+ $date+'.zip')"
  if(Test-Path -LiteralPath $backupPath)
  {
    Write-Host "path already exist"
    $update = Read-Host "do you want to overwrite the existing backup (y/n) [default: n]"
    if(-Not [string]::IsNullOrWhiteSpace($update) -or $update -eq 'y')
    {
      Compress-Archive -Path $Path -CompressionLevel 'Fastest' -update -DestinationPath "$($DestinationPath + 'backup-'+ $date)"
      Write-Host "Updated the backup at $($DestinationPath + 'backup-'+$date+'.zip')"
    }
    else {
      Write-Host "backup not updated"
    }
  } else {
    Compress-Archive -Path $Path -CompressionLevel 'Fastest' -DestinationPath "$($DestinationPath + 'backup-'+ $date)"
    Write-Host "Create backup at $($DestinationPath + 'backup-'+$date+'.zip')"
  }
