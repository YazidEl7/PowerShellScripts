
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
    
    # the inventory csv file has two headers INVENTORY and SERIAL
    # Copy the Desktop Inventory csv from the server to the local machine where this script gonna be executed
    Copy-Item -Path "***\base1.csv" -Destination "C:\" 
    $Base = "C:\base1.csv"
    $InvBase = Import-Csv $Base -Delimiter ";"

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
    
    # the inventory csv file has two headers INVENTORY and SERIAL
    # Copy the Laptop Inventory csv from the server to the local machine where this script gonna be executed
    Copy-Item -Path "***\base2.csv" -Destination "C:\" 
    $Base = "C:\base2.csv"
    $InvBase = Import-Csv $Base -Delimiter ";"

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














