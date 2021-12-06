#######################
Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name RT

#When we buy PCs we like to identify it by our own serial numbers generated from our inventory system 
#not the serial that the vendor alread assigns to the hardware
#we send to the vendor our own serials
#to allocate each one to a PC that got already its own serial number from the manufacturer
#At the end the vendor sends us a file containing two columns (Inventory and Serial)
#########################################################################################
#The following code will get the serial number of the PC 

$SerNum = (Get-ComputerInfo).BiosSeralNumber

#The next code will take the inventory number from the db1.csv (that exists too on the current location)
#that matches the serial number 
#and store it in a file in the current location

$Lien2=($env:SystemDrive) + "\RJD\db1.csv"
$Inventory = ""

$Records = Import-Csv $Lien2 -Delimiter ";"

ForEach ($record in $records)
{
if ( $Record.SERIAL -eq $SerNum ) {
$Inventory = $Record.INVENTORY 
Rename-Computer $Inventory         #Renaming PC to the corresponding Inventory value of its serial number
Break} 

}
##############################################################################
#running the earlier copied domainjoin script after computer restart
$S = $Env:Systemroot
$D = $Env:Systemdrive
$Command = $S + "\System32\WindowsPowerShell\v1.0\powershell.exe " + $D + "\Domainjoin\domainjoin.ps1"

Set-Location -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce'
Set-ItemProperty -Path . -Name joinDomain -Value $Command

#Set-Location -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce'
#Set-ItemProperty -Path . -Name joinDomain -Value 'C:\windows\system32\CMD.exe "C:\RJD\Runs_Domain.bat"'
# Remove startup file
#Set-ItemProperty -Path . -Name SBRemoval -Value 'Remove-Item -LiteralPath "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\Runs_Test.bat" -Force'
#Set-Location -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce'
#Set-ItemProperty -Path . -Name joinDomain -Value 'C:\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe ("cmd.exe /c "C:\RJD\Runs_Domain.bat"")'
Restart-Computer -Force



