using namespace System.Management.Automation.Host

function New-Menu {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$Title,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$Question
  )

  $red = [ChoiceDescription]::new('&Red', 'Favorite color: Red')
  $blue = [ChoiceDescription]::new('&Blue', 'Favorite color: Blue')
  $yellow = [ChoiceDescription]::new('&Yellow', 'Favorite color: Yellow')

  $options = [ChoiceDescription[]]($red, $blue, $yellow)

  $result = $host.ui.PromptForChoice($Title, $Question, $options, 0)

  switch ($result) {
    0 { 'Your favorite color is Red' }
    1 { 'Your favorite color is Blue' }
    2 { 'Your favorite color is Yellow' }
  }
}

function New-BinaryMenu {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$Title,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$Question
  )

  $yes = [ChoiceDescription]::new('&Yes', 'Yes')
  $no = [ChoiceDescription]::new('&No', 'No')

  $options = [ChoiceDescription[]]($yes, $no)

  $result = $host.ui.PromptForChoice($Title, $Question, $options, 0)

  switch ($result) {
    0 { return $true }
    1 { return $false }
  }
}

# function Show-Menu {
#     param (
#         [string]$Title = 'My Menu'
#     )
#     Clear-Host
#     Write-Host "================ $Title ================"

#     Write-Host "1: Press '1' for this option."
#     Write-Host "2: Press '2' for this option."
#     Write-Host "3: Press '3' for this option."
#     Write-Host "Q: Press 'Q' to quit."
# }

# New-BinaryMenu -Title 'Something' -Question 'Do you want to install X?'
