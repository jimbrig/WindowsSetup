# Check-Command
function Check-Command ( $cmdname ) {
  return [bool](Get-Command -Name $cmdname -ErrorAction SilentlyContinue)
}

function Get-Directory {
  [CmdletBinding()]
  [OutputType([psobject])]
  param()

  [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
  $OpenDirectoryDialog = New-Object Windows.Forms.FolderBrowserDialog
  $OpenDirectoryDialog.ShowDialog() | Out-Null
  try {
    Get-Item $OpenDirectoryDialog.SelectedPath
  }
  catch {
    Write-Warning 'Open Directory Dialog was closed or cancelled without selecting a Directory'
  }
}

Function Get-File {
  <#
  .SYNOPSIS
      Prompt user to select a file.
  .DESCRIPTION

  .PARAMETER TypeName
      The type of file you're prompting for. This appears in the Open File Dialog and is only used to help the user.
  .PARAMETER TypeExtension
      The extension you're prompting for (e.g. "exe")
  .PARAMETER MultipleExtensions
      Filter by multiple extensions. Comma separated list.
  .PARAMETER MultipleFiles
      Use this to allow the user to select multiple files.
  .PARAMETER InitialDirectory
      Directory the Open File Dialog will start from.
  .PARAMETER Title
      Title that will appear in the Title Bar of the Open File Dialog.

  .INPUTS
      None. You cannot pipe input to this function.
  .OUTPUTS
      System.IO.FileSystemInfo
  .EXAMPLE
      Get-File
      # Prompts the user to select a file of any type
  .EXAMPLE
      Get-File -TypeName 'Setup File' -TypeExtension 'msi' -InitialDirectory 'C:\Temp\Downloads'
      # Prompts the user to select an msi file and begin the prompt in the C:\Temp\Downloads directory
  .EXAMPLE
      Get-File -TypeName 'Log File' -MultipleExtensions 'log', 'txt' -MultipleFiles
      # Prompts the user to select one or more txt or log file
  .NOTES
      Created by Nick Rodriguez
      Version 1.0 - 2/26/16
  #>
  [CmdletBinding(DefaultParameterSetName = 'SingleExtension')]
  [OutputType([psobject[]])]
  param (
    [Parameter(Mandatory = $false, ParameterSetName = 'SingleExtension')]
    [string]
    $TypeName = 'All Files (*.*)',

    [Parameter(Mandatory = $false, ParameterSetName = 'SingleExtension')]
    [string]
    $TypeExtension = '*',

    [Parameter(Mandatory = $false, ParameterSetName = 'MultipleExtensions')]
    [string[]]
    $MultipleExtensions,

    [Parameter(Mandatory = $false)]
    [switch]
    $MultipleFiles,

    [Parameter(Mandatory = $false)]
    [ValidateScript( {
        if (-not (Test-Path $_ )) {
          throw "The path [$_] was not found."
        }
        else { $true }
      })]
    [string[]]
    $InitialDirectory = $PSScriptRoot,

    [Parameter(Mandatory = $false)]
    [string]
    $Title = 'Select a file'
  )

  [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

  $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
  $OpenFileDialog.Title = $Title
  $OpenFileDialog.InitialDirectory = $InitialDirectory

  if ($PSCmdlet.ParameterSetName -eq 'MultipleExtensions' ) {
    foreach ($Extension in $MultipleExtensions) {
      $TypeExtensionName += "*.$Extension, "
      $TypeExtensionFilter += "*.$Extension; "
    }
    $TypeExtensionName = $TypeExtensionName.TrimEnd(', ')
    $TypeExtension = $TypeExtension.TrimEnd('; ')
    $OpenFileDialog.Filter = "$TypeName ($TypeExtensionName)| $TypeExtensionFilter"
  }
  else {
    $OpenFileDialog.Filter = "$TypeName (*.$TypeExtension)| *.$TypeExtension"
  }

  $OpenFileDialog.ShowHelp = $true
  $OpenFileDialog.ShowDialog() | Out-Null

  try {
    if ($MultipleFiles) {
      foreach ($FileName in $OpenFileDialog.FileNames) { Get-Item $FileName }
    }
    else {
      Get-Item $OpenFileDialog.FileName
    }
  }
  catch { } # User closed the window or hit Cancel, return nothing
}


# Give the user an interface to run options
Function Prompt {
  $Title = "Title"
  $Message = "What do you want to do?"
  $Get = New-Object System.Management.Automation.Host.ChoiceDescription "&Get", "Description."
  $Start = New-Object System.Management.Automation.Host.ChoiceDescription "&Start", "Description."
  $Kill = New-Object System.Management.Automation.Host.ChoiceDescription "&Kill", "Description."
  $Exit = New-Object System.Management.Automation.Host.ChoiceDescription "&Exit", "Exits this utility."
  $Options = [System.Management.Automation.Host.ChoiceDescription[]]($Get, $Start, $Kill, $Exit)
  $Result = $Host.UI.PromptForChoice($Title, $Message, $Options, 0)

  Switch ($Result) {
    0 { 'Getting services...'; break }
    1 { 'Starting services...'; break }
    2 { 'Stopping Services...'; break }
    3 { 'Exiting...'; exit }
  }

  Prompt
}

function Read-FolderBrowserDialog {
  $ShellApp = New-Object -ComObject Shell.Application
  $Directory = $ShellApp.BrowseForFolder(0, 'Select a directory', 0, 'C:\')
  if ($Directory) { return $Directory.Self.Path } else { return '' }
}


function Read-YesOrNo {
  param ([string] $Message)

  $Prompt = Read-Host $Message
  while ('yes', 'no' -notcontains $Prompt) { $Prompt = Read-Host "Please enter either 'yes' or 'no'" }
  if ($Prompt -eq 'yes') { $true } else { $false }
}

# Update-Environment / Refresh Environment Variables
function Update-Environment() {
  $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
  Write-Host -ForegroundColor Green "Sucessfully Refreshed Environment Variables For powershell.exe"
}

function Take-Ownership ( $path ) {
  if ((Get-Item $path) -is [System.IO.DirectoryInfo]) {
    sudo takeown /r /d Y /f $path
  }
  else {
    sudo takeown /f $path
  }
}

function Force-Delete ( $path ) {
  Take-Ownership $path
  sudo remove-item -path $path -Force -Recurse -ErrorAction SilentlyContinue
  if (!(Test-Path $path)) {
    Write-Host "✔️ Successfully Removed $path" -ForegroundColor Green
  }
  else {
    Write-Host "❌ Failed to Remove $path" -ForegroundColor Red
  }
}

function Add-PATH ( $addpath ) {
  $environ = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
  $environupdated = $Environment.Insert($Environment.Length, $addpath)
  [System.Environment]::SetEnvironmentVariable("Path", $environupdated, "Machine")
}


