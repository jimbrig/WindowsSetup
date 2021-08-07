function Write-Success ($text) {
  $msg = "✔️ Success: " + $text
  Write-Host $msg -ForegroundColor Green
}

function Write-Begin ($text) {
  $msg = "🕜 Begin: " + $text
  Write-Host $msg -ForegroundColor Cyan
}

function Write-Failure ($text) {
  $msg = "❌ Failure: " + $text
  Write-Host $msg -ForegroundColor Red
}

function Write-Task ($text) {
  $msg = "📝 Task: " + $text
  Write-Host $msg -ForegroundColor Yellow
}

function Write-Info ($text) {
  $msg = "ℹ️ Info: " + $text
  Write-Host $msg -ForegroundColor Cyan
}

function Write-Header ($text ) {
  $out = "*       " + $text + "       *"
  Write-Host "************************************" -ForegroundColor Blue
  Write-Host $out -ForegroundColor Blue
  Write-Host "************************************" -ForegroundColor Blue
}

function Write-Step ( $num, $text ) {
  $out = "💬 STEP " + $num + " : " + $text
  Write-Host $out -ForegroundColor Yellow
}
