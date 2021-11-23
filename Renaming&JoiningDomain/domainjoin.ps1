#This will be launched after the restart
$User = "DOMAIN\User1"
$Pass= ConvertTo-SecureString -String "PASS1" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $Pass

Set-Location -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce'
Set-ItemProperty -Path . -Name joinDomain -Value 'C:\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe "Remove-Item -LiteralPath "C:\Domainjoin" -Force -Recurse"'

add-computer –DomainName DOMAIN.INTRA -Credential  $Credential  -restart –force
