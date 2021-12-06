#This will be launched after the restart
# Some Basic Encoding
$User = (Powershell -E IgBEAE8ATwBNAEEASQBOAFwAQQBEAE0ASQBOADIAIgA=)
$Pass= (Powershell -E IgBQAGEAcwB3AHcAbwByAGQAMQAyADMAIgA=)
$Credential = New-Object -TypeName System.Management.Automation.PSCredential.($User, ConvertTo-SecureString -String $Pass -AsPlainText -Force)

$S = $Env:Systemroot
$D = $Env:Systemdrive
$Command = $S + "\System32\WindowsPowerShell\v1.0\powershell.exe " + '"Remove-Item -LiteralPath ' + $D + '\Domainjoin -Force -Recurse"'
Set-Location -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce'
Set-ItemProperty -Path . -Name joinDomain -Value $Command

add-computer –DomainName DOMAIN.INTRA -Credential  $Credential  -restart –force
