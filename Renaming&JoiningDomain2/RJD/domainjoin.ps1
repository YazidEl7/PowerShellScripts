#This will be launched after the restart
# Credentials to be coded later, base64
$User = (Powershell -E IgBEAE8ATwBNAEEASQBOAFwAQQBEAE0ASQBOADIAIgA=)
$Pass= (Powershell -E IgBQAGEAcwB3AHcAbwByAGQAMQAyADMAIgA=)
$Credential = New-Object -TypeName System.Management.Automation.PSCredential.($User, ConvertTo-SecureString -String $Pass -AsPlainText -Force)
#####################################################################################
add-computer –DomainName DOMDAMAN.INTRA -Credential  $Credential –force
#####################################################################################
#Set-Location -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce'
#Set-ItemProperty -Path . -Name RJDRemoval -Value '$env:systemdrive\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe "Remove-Item -LiteralPath "$env:systemdrive\RJD" -Force -Recurse"'

$D = $Env:Systemdrive
$P = $D + "\RJD"
Remove-Item -LiteralPath $P -Force -Recurse 
#####################################################################################
Restart-Computer -Force
