

$LU = (Get-LocalUser).Name
$Pass= ConvertTo-SecureString -String "Pass1234" -AsPlainText -Force



foreach ($U in $LU) {
        
          if (($U -ilike "win10-64bit") -or ($U -ilike "win7-64bit")) {Set-LocalUser -Name $U -Password $Pass -PasswordNeverExpires 1}
          elseif (($U -notlike "Administrateur") -and ($U -notlike "DefaultAccount") -and ($U -notlike "Invit�") -and ($U -notlike "WDAGUtilityAccount") ) 
            { Remove-LocalUser -Name $U } 

}

