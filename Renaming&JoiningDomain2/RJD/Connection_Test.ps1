$Con = Test-Connection domain.intra -Quiet -Count 1
##############################
while (!$Con) {
$con = Test-Connection domain.intra -Quiet -Count 1
Start-Sleep -Seconds 60
}

if ($Con){

# Making sure the policy won't stop the execution
Set-ExecutionPolicy Unrestricted -Force 

# making the directory hidden
attrib +h "C:\RJD"

#.\Runs_Main.bat
#######################################################
$Source = "\\192.168.235.10\partage\db1.csv"
$Dest   = "C:\RJD\"
$Username = "B22018442\FTPtest"
$Password = ConvertTo-SecureString "Pass1234" -AsPlainText -Force
$mycreds = New-Object System.Management.Automation.PSCredential($Username, $Password)
New-PSDrive -Name J -PSProvider FileSystem -Root $Source -Credential $mycreds -Persist
Copy-Item -Path $Source -Destination $Dest
Start-Sleep -Seconds 5
start-process powershell -ArgumentList '-noprofile -file C:\RJD\main.ps1' -verb RunAs 

}

####### Delete the startup batch file and put the connection test in HKLM run #######

# (Get-NetAdapter | where Name -ilike 'Ethernet*').Status -eq 'Up'
