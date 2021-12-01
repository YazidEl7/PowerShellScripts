Set-Location -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run'
Set-ItemProperty -Path . -Name RT -Value 'C:\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe "C:\RJD\Runs_Test.bat"'