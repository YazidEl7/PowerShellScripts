$Con = Test-Connection dom.intra -Quiet -Count 1

while (!$Con) {
$con = Test-Connection dom.intra -Quiet -Count 1
Start-Sleep -Seconds 60
}

if ($Con){

# Making sure the policy won't stop the execution
Set-ExecutionPolicy Unrestricted -Force 

$D = $Env:Systemdrive
$Dest   = $D + "\RJD\"

# making the directory hidden
attrib +h $Dest

$Source = "\\192.168.10.254\partage\db1.csv"


$Username = "DOM\Sharetest"
$Password = ConvertTo-SecureString "Pass1234" -AsPlainText -Force
$mycreds = New-Object System.Management.Automation.PSCredential($Username, $Password)
New-PSDrive -Name J -PSProvider FileSystem -Root $Source -Credential $mycreds -Persist
Copy-Item -Path $Source -Destination $Dest
Start-Sleep -Seconds 5

$Command = "'-noprofile -file " + $D + "\RJD\main.ps1'"
start-process powershell -ArgumentList $Command -verb RunAs 

}

####### Delete the startup batch file and put the connection test in HKLM run #######

# (Get-NetAdapter | where Name -ilike 'Ethernet*').Status -eq 'Up'
