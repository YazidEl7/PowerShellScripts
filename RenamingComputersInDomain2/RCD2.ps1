$Win10Comp = @( (Get-ADComputer -Filter {OperatingSystem -like '*Windows 10*'} | where {$_.Enabled -eq $True} ).Name )
$CompCount = ($Win10Comp).Count
$i = 0
Write-Host "###################################################################"
Write-Host "################# Renaming Computers in domain ####################"
$User = '"' + (Read-Host -Prompt ' Enter domain admin DOMAIN\USER ').ToString() + '"'
$Pass = '"' + (Read-Host -Prompt ' Enter DOMAIN password ').ToString() + '"'
Write-Host " Put the csv File under the system drive"
$P = (Read-Host -Prompt ' Enter the name of the inventory csv file (ex: Base1.csv) ').ToString()
Write-Host "###################################################################"

$Bytes1 = [System.Text.Encoding]::Unicode.GetBytes($User)
$Bytes2 = [System.Text.Encoding]::Unicode.GetBytes($Pass)

$Encoded1 =[Convert]::ToBase64String($Bytes1)
$Encoded2 =[Convert]::ToBase64String($Bytes2)

########################################################################################################
# Basic credentials encoding, we can still do some customization to that later
$User = (Powershell -E $Encoded1)
$Pass= (powershell -E $Encoded2)
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, (ConvertTO-SecureString -String $Pass.ToString() -AsPlainText -Force)
########################################################################################################
Foreach ($Computer in $Win10Comp) {
########
$i++
Write-Progress -Activity "Renaming Computers" -Status "In progress…" -PercentComplete ($i/$CompCount*100)
########
$HardwareType = (Get-CimInstance -ClassName Win32_ComputerSystem -computername $Computer).PCSystemType # 1,3 & 2 for mobile
$BSN = (Get-CimInstance -ClassName Win32_BIOS -computername $Computer).SerialNumber  # gcim win32_bios -computername BTEST0 | select SerialNumber

$Check = 0
$NewName = ""
$TestConnection = Test-Connection $Computer
        ########################## Available Computer ####################################################
        IF ($TestConnection)
{
        ##################### For Desktops #####################################################################
        if ( (($HardwareType -eq 3) -or ($HardwareType -eq 1)) -and ($BSN -notlike "INVALID") ) {
    
        # Copying the CSV located in the server to a local path
        $D1 = ($env:SystemDrive) + "\$P" 
        #Copy-Item -Path "****" -Destination $D   # CSV file needed with two headers, INVENTORY and SERIAL, also with Full path 
        $InvBase = Import-Csv $D1 -Delimiter ";"    

        # Checking if it already been renamed after its own serial number's correspondant inventory value
        ForEach ($InvName in $InvBase) {
        if ( ($InvName.INVENTORY -ilike $ComputerName) -and ($InvName.SERIAL -ilike $BSN) ) {$Check = 1}
        elseif ($InvName.SERIAL -ilike $BSN) { $NewName = $InvName.INVENTORY }
        }
        # If not 
        if ($Check -eq 0) {
        Rename-computer –computername $Computer –newname $NewName -DomainCredential $Credential –force -PassThru –restart  
        }
        }
        ########################################################################################################
        ##################### For Laptops  #####################################################################
        if ($HardwareType -eq 2) {
    
        # Copying the CSV located in the server to a local path
        $D2 = ($env:SystemDrive) + "\$P" 
        #Copy-Item -Path "****" -Destination $D2   # CSV file needed with two headers, INVENTORY and SERIAL, also with Full path
        $InvBase = Import-Csv $D2 -Delimiter ";"    

        # Checking if it already been renamed after its own serial number's correspondant inventory value
        ForEach ($InvName in $InvBase) {
        if ( ($InvName.INVENTORY -ilike $ComputerName) -and ($InvName.SERIAL -ilike $BSN) ) {$Check = 1}
        elseif ($InvName.SERIAL -ilike $BSN) { $NewName = $InvName.INVENTORY }
        }
        # If not 
        if ($Check = 0) {
        Rename-computer –computername $ComputerName –newname $NewName -DomainCredential $Credential –force –restart  
        }
        }
        ########################################################################################################
}
}

