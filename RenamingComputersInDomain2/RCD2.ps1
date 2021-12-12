$Win10Comp = @( (Get-ADComputer -Filter {OperatingSystem -like '*Windows 10*'} | where {$_.Enabled -eq $True} ).Name )
$CompCount = ($Win10Comp).Count
$i = 0

########################################################################################################
# Basic credentials encoding, we can still do some customization to that later
$User = (Powershell -E IgBEAE8ATwBNAEEASQBOAFwAQQBEAE0ASQBOADIAIgA=)
$Pass= (powershell -E IgBQAGEAcwB3AHcAbwByAGQAMQAyADMAIgA=)
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
        $D1 = ($env:SystemDrive) + "\Base1.csv" 
        #Copy-Item -Path "****" -Destination $D   # CSV file needed with two headers, INVENTORY and SERIAL, also with Full path 
        $InvBase = Import-Csv "C:\Base1.csv" -Delimiter ";"    

        # Checking if it already been renamed after its own serial number's correspondant inventory value
        ForEach ($InvName in $InvBase) {
        if ( ($InvName.INVENTORY -ilike $ComputerName) -and ($InvName.SERIAL -ilike $BSN) ) {$Check = 1}
        elseif ($InvName.SERIAL -ilike $BSN) { $NewName = $InvName.INVENTORY }
        }
        # If not 
        if ($Check -eq 0) {
        Rename-computer –computername $ComputerName –newname $NewName -DomainCredential $Credential –force –restart  
        }
        }
        ########################################################################################################
        ##################### For Laptops  #####################################################################
        if ($HardwareType -eq 2) {
    
        # Copying the CSV located in the server to a local path
        $D2 = ($env:SystemDrive) + "\Base2.csv" 
        #Copy-Item -Path "****" -Destination $D2   # CSV file needed with two headers, INVENTORY and SERIAL, also with Full path
        $InvBase = Import-Csv "C:\Base2.csv" -Delimiter ";"    

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


<# 
# $cred = Get-Credential domain\admin01
# Rename-Computer -ComputerName "Srv01" -NewName "Server001" -LocalCredential Srv01\Admin01 -DomainCredential $cred -Force -PassThru -Restart#>
