Function Local:Get-GitExecutable {
  Get-Command -Name git-cmd, git -ErrorAction SilentlyContinue |
  ForEach-Object { @{ Parent = ([System.IO.Path]::GetDirectoryName( $_.Path ) ) } } |
  ForEach-Object { Get-ChildItem $_.Parent -File -Filter git.exe -Recurse } |
  Select-Object -ExpandProperty FullName -First 1
}

Function Reset-GitAutoCrLf {
  <#
    .SYNOPSIS
    Removes configurations settings: core.autocrlf.
    Supports:
    - Git for Windows,
    - Git for Windows Portable.
    .PARAMETER CfgFile
    Git configuration file.
    .INPUTS
    FileInfo
#>
  Param ( [Parameter(Mandatory = $true, ValueFromPipeline = $true)] [System.IO.FileInfo] $CfgFile,
    [String] $GitExe = ( Get-GitExecutable ) )

  Start-Process -FilePath $GitExe `
    -ArgumentList "config --file `"$($CfgFile.FullName)`" --unset core.autocrlf" `
    -NoNewWindow `
    -Wait
}

Function Invoke-GitConfig {
  <#
    .SYNOPSIS
    Applies local configuration for git repository.
    .PARAMETER Json
    A piece of the JSON file.
    .PARAMETER RepositoryFolder
    Git repository folder.
    .INPUTS
    PSCustomObject (Json object)
#>
  Param ( [Parameter(Mandatory = $true)][String] $RepositoryFolder,
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)] $Json,
    [String] $GitExe = ( Get-GitExecutable ) )

  Process {
    $Json.psobject.Properties |
    ForEach-Object {
      $key = $_.Name.Replace( "-", ".")
      Start-Process -FilePath $GitExe `
        -ArgumentList "-C $RepositoryFolder config $key `"$($_.Value)`"" `
        -WorkingDirectory $RepositoryFolder `
        -NoNewWindow `
        -Wait
    }
  }
}

Function Copy-GitRepositories {
  <#
    .SYNOPSIS
    This function clones git respositories enumerated in configuration file.
    .DESCRIPTION
    This function in details:
    * creates destination folder if it not exists,
    * takes a repositores list to clone from configuration file,
    * skips repositories marked as disabled,
    * clones each repository left,
    * uses a git that should be already provisioned and accessible,
    * supports Git for Windows and Git for Windows Portable
    * clones the repositories into specified destination folder,
    * initializes submodules within repositories.
    .PARAMETER CfgFile
    Configuration file.
    .PARAMETER KeyFile
    Encryption key file. If you don't have it, please see New-EncryptionKey.
    .PARAMETER DestinationFolder
    Destination folder for cloned repositories.
    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/docs/Copy-GitRepositories.md
    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/docs/New-EncryptionKey.md
    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/docs/Protect-Config.md
    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/modules/git-clone.psm1
#>
  Param (
    [Parameter(Mandatory = $true)][String] $CfgFile,
    [Parameter(Mandatory = $true)] [String] $KeyFile,
    [String] $DestinationFolder = ( Join-Path $env:UserProfile 'MyProjects' ),
    [String] $GitExe = ( Get-GitExecutable ) )

  if ((Test-Path $DestinationFolder) -eq 0) {
    New-Item -Path $DestinationFolder -ItemType Directory
  }

  ( Get-Content $CfgFile | ConvertFrom-Json ).repos |
  Where-Object { -Not $_.disabled } |
  ForEach-Object {
    Start-Process -FilePath $GitExe `
      -ArgumentList "clone -q --recursive $($_.url)" `
      -WorkingDirectory $DestinationFolder `
      -NoNewWindow `
      -Wait

    If ( $_.secret ) {
      $_.secret | Decrypt $KeyFile
      $subdir = $_.url.Split('/') | select -Last 1 | % { $_.TrimEnd(".git") }
      $_.secret | Invoke-GitConfig ( Join-Path $DestinationFolder $subdir )
    }
  }
}
