
$Load = Get-ComputerInfo

$HardwareType = $Load.CsPCSystemType
$BSN = $Load.BiosSeralNumber 
$ComputerName = $Load.CsCaption                             #(Get-CimInstance -ClassName Win32_ComputerSystem).Name

$Check = 0
$NewName = ""

########################################################################################################
# We gonna do some basic credentials Encoding, there's other ways to customize it
$User = (Powershell -E IgBEAE8ATwBNAEEASQBOAFwAQQBEAE0ASQBOADIAIgA=)
$Pass= (Powershell -E IgBQAGEAcwB3AHcAbwByAGQAMQAyADMAIgA=)
$Credential = New-Object -TypeName System.Management.Automation.PSCredential.($User, (ConvertTo-SecureString -String $Pass -AsPlainText -Force))

##################### For Desktops #####################################################################
if ( ($HardwareType -ilike "Desktop") -and ($BSN -notlike "INVALID") ) {
    
    # Copying the CSV located in the server to a local path
    $D1 = ($env:SystemDrive) + "\Base1.csv" 
    Copy-Item -Path "****" -Destination $D   # CSV file needed with two headers, INVENTORY and SERIAL, also with Full path 
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
if ($HardwareType -ilike "Laptop") {
    
    # Copying the CSV located in the server to a local path
    $D2 = ($env:SystemDrive) + "\Base2.csv" 
    Copy-Item -Path "****" -Destination $D2   # CSV file needed with two headers, INVENTORY and SERIAL, also with Full path
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














