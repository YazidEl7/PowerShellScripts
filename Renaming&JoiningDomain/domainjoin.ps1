#This will be launched after the restart
# Some Basic Encoding
$User = (Powershell -E IgBEAE8ATwBNAEEASQBOAFwAQQBEAE0ASQBOADIAIgA=)
$Pass= (Powershell -E IgBQAGEAcwB3AHcAbwByAGQAMQAyADMAIgA=)
$Credential = New-Object -TypeName System.Management.Automation.PSCredential.($User, ConvertTo-SecureString -String $Pass -AsPlainText -Force)

Set-Location -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce'
Set-ItemProperty -Path . -Name joinDomain -Value 'C:\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe "Remove-Item -LiteralPath "C:\Domainjoin" -Force -Recurse"'

add-computer –DomainName DOMAIN.INTRA -Credential  $Credential  -restart –force
