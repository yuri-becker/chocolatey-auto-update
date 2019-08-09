$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$Home\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\chocolatey-auto-update.lnk")
$Shortcut.TargetPath = "start"
$Shortcut.Arguments = "/min cmd /c $((Split-Path -parent $PSCommandPath))\chocolatey-auto-update.cmd"
$Shortcut.WorkingDirectory = $(Split-Path -parent $PSCommandPath)
$Shortcut.WindowStyle = 7
$Shortcut.Save()