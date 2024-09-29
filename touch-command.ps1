<# touch command which supports multiple files 

eg :
    touch file1 
    touch file1 file2 ..

 [Optional]  add this function to your profile to use globally (inside Microsoft.PowerShell_profile)
 . path of the powershell script file 
 eg:
 . D:\powershell-scripts\touch-command.ps1
 

#>
function touch {
    Param(
        [Parameter(Mandatory=$true, ValueFromRemainingArguments=$true)]
        [string[]]$Paths
    )

    foreach ($Path in $Paths) {
        if (Test-Path -LiteralPath $Path) {
            (Get-Item -Path $Path).LastWriteTime = Get-Date
        } else {
            New-Item -Type File -Path $Path | Out-Null
        }
    }
}