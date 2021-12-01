#This will be launched after the restart
# Credentials to be coded later, base64
$User = "DOMAIN\Admin"
$Pass= ConvertTo-SecureString -String "Pass159" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $Pass
#####################################################################################
add-computer –DomainName DOMDAMAN.INTRA -Credential  $Credential –force
#####################################################################################
Set-Location -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce'
Set-ItemProperty -Path . -Name RJDRemoval -Value 'C:\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe "Remove-Item -LiteralPath "C:\RJD" -Force -Recurse"'

#####################################################################################
Restart-Computer -Force
