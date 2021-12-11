$Win10Comp = @( (Get-ADComputer -Filter {OperatingSystem -like '*Windows 10*'} | where {$_.Enabled -eq $True} ).Name )
$Account = "win10-64bit"
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

         Invoke-Command -ComputerName $Computer -ScriptBlock { 
         
         $LocalUsers = (Get-LocalUser).Name
         $Pass= ConvertTo-SecureString -String "Pass1234" -AsPlainText -Force

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
                                             if ( $User -ilike "win10-64bit" ) { 
                                             $Check = 1
                                             } 
                                } # 1st foreach
                                ######################################################
                                # if the account doesn't exist, we gonna create it 
                                if ( $Check = 0) {
                                                                               New-LocalUser "win10-64bit" -Password $Pass
                                                                               Add-LocalGroupMember -Group "Administrators" -Member "win10-64bit"  
                                        

                                        $Check = 1
                                        $Check2 = 0
                                } #3rd if
                                ######################################################
                                # After Creating the account
                                if ( $Check = 1) {
                                foreach ($U in $LocalUsers) {
        
                                             if ( ($U -ilike "win10-64bit") -and ($Check2 -eq 1) ) {
                                                                             Set-LocalUser -Name $U -Password $Pass -PasswordNeverExpires 1
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

