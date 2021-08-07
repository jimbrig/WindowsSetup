Function Write-Success {
  <#
    .SYNOPSIS
    Writes success message to console host.
    .PARAMETER text
    text to display
    .LINK
    https://github.com/jimbrig/Scripts/blob/main/PowerShell/Functions/feedback-helpers.ps1
  #>
  Param (
    [Parameter(Mandatory = $true)][String] $text
  )
  $msg = "✔️ Success: " + $text
  Write-Host $msg -ForegroundColor Green
}

Function Write-Failure {
  <#
    .SYNOPSIS
    Writes failure message to console host.
    .PARAMETER text
    text to display
    .LINK
    https://github.com/jimbrig/Scripts/blob/main/PowerShell/Functions/feedback-helpers.ps1
  #>
  Param (
    [Parameter(Mandatory = $true)][String] $text
  )
  $msg = "❌ Failure: " + $text
  Write-Host $msg -ForegroundColor Red
}

Function Write-Info {
  <#
    .SYNOPSIS
    Writes information message to console host.
    .PARAMETER text
    text to display
    .LINK
    https://github.com/jimbrig/Scripts/blob/main/PowerShell/Functions/feedback-helpers.ps1
  #>
  Param (
    [Parameter(Mandatory = $true)][String] $text
  )
  $msg = "ℹ️ Info: " + $text
  Write-Host $msg -ForegroundColor Cyan
}

Function Write-Begin {
  <#
    .SYNOPSIS
    Writes begin message to console host.
    .PARAMETER text
    text to display
    .LINK
    https://github.com/jimbrig/Scripts/blob/main/PowerShell/Functions/feedback-helpers.ps1
  #>
  Param (
    [Parameter(Mandatory = $true)][String] $text
  )
  $msg = "🕜 Begin: " + $text
  Write-Host $msg -ForegroundColor Cyan
}

Function Write-Task {
  <#
    .SYNOPSIS
    Writes task/todo message to console host.
    .PARAMETER text
    text to display
    .LINK
    https://github.com/jimbrig/Scripts/blob/main/PowerShell/Functions/feedback-helpers.ps1
  #>
  Param (
    [Parameter(Mandatory = $true)][String] $text
  )
  $msg = "📝 Task: " + $text
  Write-Host $msg -ForegroundColor Yellow
}

Function Write-Header {
  <#
    .SYNOPSIS
    Writes header message to console host.
    .PARAMETER text
    text to display
    .LINK
    https://github.com/jimbrig/Scripts/blob/main/PowerShell/Functions/feedback-helpers.ps1
  #>
  Param (
    [Parameter(Mandatory = $true)][String] $text
  )
  $out = "*       " + $text + "       *"
  Write-Host "************************************" -ForegroundColor Blue
  Write-Host $out -ForegroundColor Blue
  Write-Host "************************************" -ForegroundColor Blue
}

Function Write-Step {
  <#
    .SYNOPSIS
    Writes numeric valued step message to console host.
    .PARAMETER num
    Number to display
    .PARAMETER text
    text to display
    .LINK
    https://github.com/jimbrig/Scripts/blob/main/PowerShell/Functions/feedback-helpers.ps1
  #>
  Param (
    [Parameter(Mandatory = $true)][String] $num,
    [Parameter(Mandatory = $true)][String] $text
  )
  $out = "💬 STEP " + $num + " : " + $text
  Write-Host $out -ForegroundColor Yellow
}

Function Write-FunctionCallLog {
  <#
  .SYNOPSIS
  Writes function call as a debug message.
  .INPUTS
  None
  .OUTPUTS
  None
  .PARAMETER Invocation
  The invocation of the function (`$MyInvocation`)
  .PARAMETER Parameters
  The parameters passed to the function (`$PSBoundParameters`)
  .PARAMETER IgnoredArguments
  Allows splatting with arguments that do not apply. Do not use directly.
  .EXAMPLE
  >
  # This is how this function should always be called
  Write-FunctionCallLog -Invocation $MyInvocation -Parameters $PSBoundParameters
  #>
  param(
    $invocation,
    $parameters,
    [parameter(ValueFromRemainingArguments = $true)][Object[]] $ignoredArguments
  )

  $argumentsPassed = ''
  foreach ($param in $parameters.GetEnumerator()) {
    if ($param.Key -eq 'ignoredArguments') { continue; }
    $paramValue = $param.Value -Join ' '
    if ($param.Key -eq 'sensitiveStatements' -or $param.Key -eq 'password') {
      $paramValue = '[REDACTED]'
    }
    $argumentsPassed += "-$($param.Key) '$paramValue' "
  }

  Write-Debug "Running $($invocation.InvocationName) $argumentsPassed"

}


