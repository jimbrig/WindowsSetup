function Write-Success ($text) {
  $msg = "âī¸ Success: " + $text
  Write-Host $msg -ForegroundColor Green
}

function Write-Begin ($text) {
  $msg = "đ Begin: " + $text
  Write-Host $msg -ForegroundColor Cyan
}

function Write-Failure ($text) {
  $msg = "â Failure: " + $text
  Write-Host $msg -ForegroundColor Red
}

function Write-Task ($text) {
  $msg = "đ Task: " + $text
  Write-Host $msg -ForegroundColor Yellow
}

function Write-Info ($text) {
  $msg = "âšī¸ Info: " + $text
  Write-Host $msg -ForegroundColor Cyan
}

function Write-Header ($text ) {
  $out = "*       " + $text + "       *"
  Write-Host "************************************" -ForegroundColor Blue
  Write-Host $out -ForegroundColor Blue
  Write-Host "************************************" -ForegroundColor Blue
}

function Write-Step ( $num, $text ) {
  $out = "đŦ STEP " + $num + " : " + $text
  Write-Host $out -ForegroundColor Yellow
}
