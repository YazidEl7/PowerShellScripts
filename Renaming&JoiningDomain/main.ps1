#When we buy PCs we like to identify it by our own serial numbers generated from our inventory system 
#not the serial that the vendor alread assigns to the hardware
#we send to a vendor our own serials
#to allocate each one to a PC that got already its own serial number from the manufacturer
#At the end the vendor sends us a file containing two columns (Inventory and Serial)
#The following code will get the serial number of the PC then store it in a file in the current location
#So that we rename the pc later with its inventory number
$Lien=".\sernum.txt"
wmic bios get serialnumber | Out-File -FilePath $Lien -nonewline
$File = $Lien
$FileContent = Get-Content $File
$FileContent.Remove(0,14) > $File
$FileContent = Get-Content $File
#The next code will take the inventory number from the db1.csv, that exists too on the current location,
#that matches the serial number 
#and store it in a file in the current location
$Lien2=".\db1.csv"
$Lien3=".\inventory.txt"
$Records = Import-Csv $Lien2 -Delimiter ";"
$SerNum=$FileContent
ForEach ($record in $records)
{
if ( $Record.SERIAL -eq $SerNum ) {Break} 
$Record.INVENTORY > $Lien3
}
#the next to lines gonna copy the other domainjoin script to c:\
$Lien4 =".\domainjoin.ps1"
Copy-Item -Path $Lien4 -Destination C:\
#Renaming PC to the corresponding Inventory value of its serial number
$Hostname = Get-Content $Lien3
Rename-Computer $Hostname
#running the earlier copied domainjoin script after computer restart
Set-Location -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce'
Set-ItemProperty -Path . -Name joinDomain -Value 'C:\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe "C:\domainjoin.ps1"'

Restart-Computer
