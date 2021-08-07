Function Add-WindowsDefenderExclusions {
  <#
    .SYNOPSIS
    This function add Windows defender exclusions.
    .DESCRIPTION
    This function in details adds exclusions for:
    * specified processes,
    * specified folders,
    * specified files,
    * specified extensions.
    The primary aim is to improve developer machine performance.
    .PARAMETER ProcessesPaths
    Paths where specified processess should be search for.
    .PARAMETER ProcessesList
    Processess to exclude within Windows Defender.
    .PARAMETER FoldersPaths
    Paths where specified folders should be search for.
    .PARAMETER FoldersList
    Folders to exclude within Windows Defender.
    .PARAMETER FilesList
    Files to exclude within Windows Defender.
    .PARAMETER ExtensionsList
    File extensions to exclude within Windows Defender.
    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/docs/Add-WindowsDefenderExclusions.md
    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/modules/defender.psm1
#>
  Param ( [String[]] $ProcessesPaths = ( ${env:ProgramFiles(x86)}, $env:ProgramW6432 )
    , [String[]] $ProcessesList = ( 'msbuild.exe', 'devenv.exe', 'sqlcmd.exe', 'sqllocaldb.exe', 'sqlservr.exe', 'sqlwriter.exe')
    , [String[]] $FoldersPaths = ( $env:USERPROFILE )
    , [String[]] $FoldersList = ( 'MyProjects', '.nuget', '.babun' )
    , [String[]] $FilesList = ( 'C:\pagefile.sys' )
    , [String[]] $ExtensionsList = ( 'config', 'cs' , 'ldf', 'lnk', 'mdf', 'ttf', 'txt', 'xml', 'log' ) )

  Get-ChildItem -Path $ProcessesPaths -Include $ProcessesList -File -Recurse |
  ForEach-Object { Add-MpPreference -ExclusionProcess $_.FullName }

  Get-ChildItem -Path $FoldersPaths -Include $FoldersList -Directory -Recurse |
  ForEach-Object { Add-MpPreference -ExclusionPath $_.FullName }

  Add-MpPreference -ExclusionPath $FilesList -ExclusionExtension $ExtensionsList
}
