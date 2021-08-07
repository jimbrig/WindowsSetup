Function Create-LocalAdminUser($name) {
  sudo cmd.exe net user $name /add
  sudo cmd.exe net localgroup Administrators $name /add
}


