$S = $Env:Systemroot
$D = $Env:Systemdrive
$Command = $S + "\System32\WindowsPowerShell\v1.0\powershell.exe " + $D + "\RJD\Runs_Test.bat"
Set-Location -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run'
Set-ItemProperty -Path . -Name RT -Value $Command
