# File1 should have the headers we gonna use upon creation, LastName, FirstName, CIN, UPN

$Users = Import-CSV -Path "C:\File1.csv" -Delimiter ";"

foreach ($U in $Users) {

New-ADUser -GivenName $U.FirstName -Surname $U.LastName -Path "OU=OU3,OU=OU2,OU=OU3,OU=Utilisateurs,DC=dom,DC=intra" -Name (($U.Firstname)+" "+($U.LastName)) -DisplayName (($U.Firstname)+" "+($U.LastName)) -SamAccountName $U.UPN -UserPrincipalName (($U.UPN)+"@dom.intra") -Description ("CIN : "+($U.CIN)) -Accountpassword $(ConvertTo-SecureString "123456789" -AsPlainText -Force) -Enabled $true -PasswordNeverExpires $true -Confirm $false

}