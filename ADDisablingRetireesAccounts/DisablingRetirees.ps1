Import-Module ActiveDirectory
# Copy the file from shared folder to local folder 
# Copy the exported A csvstate to the shared folder
# use val to disable accounts
##########################################################################################
########################### Extracting Valuable Columns to my csv ########################
##    (should be executed everytime HR makes modification on the employee status)       ##

$HRbase = Import-csv C:\fichier.csv -Delimiter ","
$FileState = ($HRbase.CSVState)[0]
$Check = 0
$i = 0
if ($FileState -like 'M0') {

$Val = @()
foreach($Employee in $HRbase)
{

$situation = $Employee.situation
$matricule = $Employee.Matricule
        if (($situation -like "sortie") -or ($situation -like "inactif"))
        {
                  $HRbase[$i].CSVState = 'T'
                  $Val += New-Object -TypeName PSObject -Property @{
                         'matricule' = $matricule
                         'situation' = $situation
                                                                    }
        }
$i += 1
}
$P = "C:\Val.csv" 
$Val | Export-CSV -NoTypeInformation -Path $P -Delimiter ";" 

######### Giving the file Updated flag sign ################

$HRbase[0].CSVState = 'A'
$HRbase | Export-CSV -NoTypeInformation -Path C:\fichier.csv -Delimiter ","
$Check = 1
}
##########################################################################################

if ($FileState -like 'M') {
$Val = @()

foreach($Employee in $HRbase)
{

$situation = $Employee.situation
$matricule = $Employee.Matricule
$traite = $Employee.CSVState
        if ((($situation -like "sortie") -and ($traite -notlike 'T')) -or (($situation -like "inactif") -and ($traite -notlike 'T')))
        {
                  $HRbase[$i].CSVState = 'T'
                  $Val += New-Object -TypeName PSObject -Property @{
                         'matricule' = $matricule
                         'situation' = $situation
                                                                    }
        }
$i += 1
}
$P = "C:\Val.csv" 
$Val | Export-CSV -NoTypeInformation -Path $P -Delimiter ";" 

######### Giving the file Updated flag sign ################

$HRbase[0].CSVState = 'A'
$HRbase | Export-CSV -NoTypeInformation -Path .\fichier.csv -Delimiter ","
$Check = 1
}

##########################################################################################
########################### Disabling Accounts in Valbase.csv ############################
## will get executed just for the first time                                            ##
if ($Check -eq 1) {                                        
$ValBase = Import-csv C:\Val.csv -Delimiter ";"
    foreach($Emp in $ValBase)
    {
        #Set-ADUser -Identity $Emp.matricule -Enabled $false -Verbose
        $Emp.matricule
        echo "Disabled"
    }
}
##########################################################################################




















