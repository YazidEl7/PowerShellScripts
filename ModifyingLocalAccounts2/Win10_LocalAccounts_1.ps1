Write-Host "############## Modifying win10 local Accounts ######################"
$Account = (Read-Host -Prompt ' Enter the name of the Local Admin Account ').ToString()
$Pass0 = (Read-Host -Prompt ' Enter the password you want to use ').ToString()
$AdminGroup = (Read-Host -Prompt ' Enter the Local Admins group ').ToString()
Write-Host "######################################################################"
Write-Host "##  Unavailable computers will be saved to C:\Not_found.txt  ##"
Write-Host "######################################################################"

$Win10Comp = @( (Get-ADComputer -Filter {OperatingSystem -like '*Windows 10*'} | where {$_.Enabled -eq $True} ).Name )
$CompCount = ($Win10Comp).Count
$i = 0
$Pass= ConvertTo-SecureString -String $Pass0 -AsPlainText -Force
Foreach ($Computer in $Win10Comp) {
########
$i++
Write-Progress -Activity "Modifying local accounts" -Status "In progress…" -PercentComplete ($i/$CompCount*100)
########
$TestConnection = Test-Connection $Computer
        ########################## Available Computer ####################################################
        IF ($TestConnection)
{

         Invoke-Command -ComputerName $Computer -ScriptBlock { 
         
         $LocalUsers = (Get-LocalUser).Name

         $LA = $Using:Account
         echo $LA
         echo $Using:Pass
         echo $USing:AdminGroup
         $Load = Get-ComputerInfo 
         $OsArch = $Load.OsArchitecture
         $OsName = $Load.WindowsProductName

         $Check = 0
         $Check2 = 1

         if ($OsName -ilike "Windows 10 Pro"){
            if ($OsArch -ilike "64-bit") { 
                                ######################################################
                                # Testing the existence of win10 
                                foreach ($User in $LocalUsers) {
                                             if ( $User -ilike $LA ) { 
                                             $Check = 1
                                             } 
                                } # 1st foreach
                                ######################################################
                                # if the account doesn't exist, we gonna create it 
                                if ( $Check -eq 0) {
                                                                               New-LocalUser $LA -Password $Using:Pass
                                                                               Add-LocalGroupMember -Group $USing:AdminGroup -Member $LA
                                        

                                        $Check = 1
                                        $Check2 = 0
                                } #3rd if
                                ######################################################
                                # After Creating the account
                                if ( $Check -eq 1) {
                                foreach ($U in $LocalUsers) {
        
                                             if ( ($U -ilike $LA) -and ($Check2 -eq 1) ) {
                                                                             Set-LocalUser -Name $U -Password $Using:Pass -PasswordNeverExpires 1
                                                                                                         } # 4th if
          
                                                else { Disable-LocalUser -Name $U } 
               

                                } # 2nd foreach 
                                } # 5th if
            } #second if
           } #first if
          } #invoke

  
                   
     
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