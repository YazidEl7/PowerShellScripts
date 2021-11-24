

$LocalUsers = (Get-LocalUser).Name
$Pass= ConvertTo-SecureString -String "Pass1234" -AsPlainText -Force

$Check = 0
$Check2 = 1

$Load = Get-ComputerInfo
$OsArch = $Load.OsArchitecture
$OsName = $Load.WindowsProductName               #Or use this (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name ProductName).ProductName
############# For 64 bit ###############################################################
if ($OsArch -ilike "64-bit") { 
                                # Testing the existence of win10 or win7 account
                                foreach ($User in $LocalUsers) {
                                             if ( (($User -ilike "win10-64bit") -and ($OsName -ilike "Windows 10 Pro")) -or (($User -ilike "win7-64bit") -and ($OsName -ilike "Windows 7 Pro")) ) { 
                                             $Check = 1
                                             } 
                                }
                                # if the account doesn't exist, we gonna create it first
                                if ( $Check = 0) {
                                        if($OsName -ilike "Windows 10 Pro") {
                                                                               New-LocalUser "win10-64bit" -Password $Pass
                                                                               Add-LocalGroupMember -Group "Administrators" -Member "win10-64bit"  
                                        }
                                        if($OsName -ilike "Windows 7 Pro") {
                                                                               New-LocalUser "win7-64bit" -Password $Pass
                                                                               Add-LocalGroupMember -Group "Administrators" -Member "win7-64bit"  
                                        }
                                        $Check = 1
                                        $Check2 = 0
                                }
                                # After Creating the account
                                if ( $Check = 1) {
                                foreach ($U in $LocalUsers) {
        
                                             if (((($U -ilike "win10-64bit") -and ($OsName -ilike "Windows 10 Pro") ) -or (($U -ilike "win7-64bit") -and ($OsName -ilike "Windows 7 Pro") )) -and ($Check2 -eq 1) ) {
                                                                             Set-LocalUser -Name $U -Password $Pass -PasswordNeverExpires 1
                                                                                                         }
          
                                                elseif (($U -notlike "Administrateur") -and ($U -notlike "DefaultAccount") -and ($U -notlike "Invité") -and ($U -notlike "WDAGUtilityAccount") ) 
                                                                                 { Remove-LocalUser -Name $U } 
               

                                }
                                }
}

########################################################################################
############# For 32 bit ###############################################################

if ($OsArch -ilike "32-bit") { 
                                # Testing the existence of win10 or win7 account
                                foreach ($User in $LocalUsers) {
                                             if ( (($User -ilike "win10-32bit") -and ($OsName -ilike "Windows 10 Pro")) -or (($User -ilike "win7-32bit") -and ($OsName -ilike "Windows 7 Pro")) ) { 
                                             $Check = 1
                                             } 
                                }
                                # if the account doesn't exist, we gonna create it first
                                if ( $Check = 0) {
                                        if($OsName -ilike "Windows 10 Pro") {
                                                                               New-LocalUser "win10-32bit" -Password $Pass
                                                                               Add-LocalGroupMember -Group "Administrators" -Member "win10-32bit"  
                                        }
                                        if($OsName -ilike "Windows 7 Pro") {
                                                                               New-LocalUser "win7-32bit" -Password $Pass
                                                                               Add-LocalGroupMember -Group "Administrators" -Member "win7-32bit"  
                                        }
                                        $Check = 1
                                        $Check2 = 0
                                }
                                # After Creating the account
                                if ( $Check = 1) {
                                foreach ($U in $LocalUsers) {
        
                                             if (((($U -ilike "win10-32bit") -and ($OsName -ilike "Windows 10 Pro") ) -or (($U -ilike "win7-32bit") -and ($OsName -ilike "Windows 7 Pro") )) -and ($Check2 -eq 1) ) {
                                                                             Set-LocalUser -Name $U -Password $Pass -PasswordNeverExpires 1
                                                                                                         }
          
                                                elseif (($U -notlike "Administrateur") -and ($U -notlike "DefaultAccount") -and ($U -notlike "Invité") -and ($U -notlike "WDAGUtilityAccount") ) 
                                                                                 { Remove-LocalUser -Name $U } 
               

                                }
                                }
}
