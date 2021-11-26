$User = '"DOOMAIN\ADMIN2"'
$Pass= '"Paswword123"'


$Bytes1 = [System.Text.Encoding]::Unicode.GetBytes($User)
$Bytes2 = [System.Text.Encoding]::Unicode.GetBytes($Pass)

$Encoded1 =[Convert]::ToBase64String($Bytes1)
$Encoded2 =[Convert]::ToBase64String($Bytes2)

echo "************************************************"
# This is the encoded strings we have to put in the other file
echo $Encoded1
echo $Encoded2
echo "************************************************"
# Verifying what u have encoded
Powershell -E $Encoded1
Powershell -E $Encoded2