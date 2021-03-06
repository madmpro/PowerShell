<#
 # Tom's custom profile
 # 
 # Poached mightly from "scottmuc/poshfiles" on GitHub
 # https://github.com/scottmuc/poshfiles
 #
 # Revision History:
 # <0>  30-Aug-2014 Birthday
 # <1>  31-Aug-2014 Still working
 # <2>  01-Sep-2014 Up and running, just updates from now on
 # <3>  26-Sep-2014 Prompt suddenly broke, do explicit imports
 #                  Add aliases for AeroGlassTheme on/off
 # <4>  12-Oct-2014 Add "jobs" function for running procs
 # <5>  21-Dec-2014 Add "Priv-Explore" for admin File Explorer
 #                  Add "sudo" for one-time, one-command invocation
 #>

# Who's your daddy?
$here = Split-Path -Parent $MyInvocation.MyCommand.Path

# Function loader
#
# To add functions, drop scripts in the Functions folder, or insert
# them inline in this file (which skips testing)
Resolve-Path $here\Functions\*.ps1 |
  Where-Object { -not ($_.ProviderPath.Contains(".Tests")) } |
  Foreach-Object { . $_.ProviderPath }

# Import posh-git explicitly (it suddenly quit working, and
# messed up the Prompt)
Import-Module posh-git

<#
# Set the "global" script repo (pslib)
New-PSDrive -name pslib -PSProvider Filesystem -Root \\SEAGATE-3F3BF2\Public\Scripts | Out-Null
#Set-Location pslib:
#>

# Inline Aliases, Functions, and Variables
# Convenience cmdlet aliases
Set-Alias GUI-Command Show-Command
Set-Alias mob Measure-Object
Set-Alias ton Enable-AeroGlassTheme
Set-Alias toff Disable-AeroGlassTheme

# Simple functions
#Function Get-Music { New-PSDrive -Name music -PSProvider Filesystem -Root \\SEAGATE-3F3BF2\Public\Music }
Function cd... { Set-Location ..\\.. }
function Clip-History { (Get-History).CommandLine | clip }
Function home  { Set-Location $env:homedrive\$env:homepath }
Function jobs  { Get-Process | Measure-Object | grep "Count" }
Function ld    { Get-Childitem -Attributes D }
Function lf    { Get-Childitem -File }
Function lsp   { Get-Childitem | More }
Function music { Set-Location \\SEAGATE-3F3BF2\Public\Music }
Function open ($thing) { Start-Process .\$thing }
function p     { $Env:Path -Split ";" }
Function Priv-Explore { Start-Process explorer -verb runAs }
function Show-Function ($func) { (Get-Command $func).ScriptBlock }
Function su    { Start-Process PowerShell -verb runAs }
Function sudo ($cmd) { Start-Process $cmd -verb runAs }
Function tab   { Start-Process PowerShell }
Function which ($app) { Get-Command $app | Format-Table Path }

# Tweak the PATH
$paths = @(
  "C:\Users\Tom\bin",
  "C:\Users\Tom\Documents\WindowsPowerShell\Scripts",
  $($Env:Path)
)

$env:Path = [String]::Join(";", $paths)
