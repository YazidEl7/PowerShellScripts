#This will be launched after the restart
$User = "DOMAIN\User1"
$Pass= ConvertTo-SecureString -String "PASS1" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $Pass
add-computer –DomainName DOMAIN.INTRA -Credential  $Credential  -restart –force
