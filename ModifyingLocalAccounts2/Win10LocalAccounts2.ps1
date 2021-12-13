$Win10Comp = @( (Get-ADComputer -Filter {OperatingSystem -like '*Windows 10*'} | where {$_.Enabled -eq $True} ).Name )
$Account = "win10-64bit"
$Pass= "Pass1234"
$Group = 'Administrators'
$CompCount = ($Win10Comp).Count
$i = 0

Foreach ($Computer in $Win10Comp) {
########
$i++
Write-Progress -Activity "Modifying local accounts" -Status "In progress…" -PercentComplete ($i/$CompCount*100)
########
$TestConnection = Test-Connection $Computer
        ########################## Available Computer ####################################################
        IF ($TestConnection)
{
        $Check = 0
        $Check2 = 1
        #$EnableUser = 512
        $DisableUser = 2

        # (Get-CimInstance -Class Win32_OperatingSystem -computername BTEST0).OSArchitecture
        #searching for users
       ######################################################                                                         
        $LocalUsers =  @( (Get-CimInstance -ClassName Win32_UserAccount -Filter "LocalAccount = TRUE" -computername $Computer).Name )
                                ######################################################
                                # Testing the existence of win10 
                                foreach ($User in $LocalUsers) {
                                             if ( $User -ilike "win10-64bit" ) { 
                                             $Check = 1
                                             } 
                                } # 1st foreach
                                ######################################################
                                ######################################################
                                # if the account doesn't exist, we gonna create it 
                                if ( $Check -eq 0) { 
                                                                               $objOu = [ADSI]”WinNT://$computer,computer“
                                                                               $objUser = $objOU.Create(“User“, $Account)
                                                                               $objUser.setpassword($Pass)
                                                                               $objUser.SetInfo()
                                                                               #$user.CommitChanges()

                                                                               # add user to group
                                                                               $group = [ADSI]"WinNT://$computer/$Group,group" 
                                                                               $group.add("WinNT://$Account,user")
                                                                               $group.setinfo()

                                        

                                        $Check = 1
                                        $Check2 = 0
                                } 
                                ######################################################
         
         if ( $Check -eq 1) {
         ForEach($U in $LocalUsers){

             ##############################################
             if( ($Account -eq $U) -and ($Check2 -eq 1) ) 
                    {   
                 $user = [adsi]"WinNT://$computer/$U,user"
                 $user.SetPassword($Pass)
                 $user.SetInfo()
                     }
             ##############################################
             else {

                 $user = [adsi]"WinNT://$computer/$U,user"
                 $user.UserFlags=$DisableUser
                 $user.SetInfo()
  
                    }
        }
        }
}
        ############################### Offline Computer ################################################
        ElSE
        {
            
             $Offline = "C:\Not_found.txt"
   
             if (!(Test-Path -path $Offline))
             {
                New-Item $Offline -Type file
             }

          echo $Computer | Out-File "C:\Not_found.txt" -Append -NoClobber 
        }

}

<#   
  $NewUser = $ADSIComp.Create('User',$Username)

$ADSIComp.Delete('User','TestProx')


[ADSI]$Test = "WinNT://$($env:userdomain)/$sam,user"
If ($test.ADSPath) {
    Write-Warning "A user with the account name of $sam already exists"
    #bail out
    Return
}
#>
