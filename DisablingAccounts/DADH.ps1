Import-Module ActiveDirectory
$CurrentDate0 = Get-Date -Format "dd-MM-yyyy"
$Fin0 = [DateTime]::Now.Subtract([TimeSpan]::FromDays(1)) | get-date -format "dd-MM-yyyy"
$P0 = "./" + $Fin0 + ".csv"
$ADUsers = Import-csv $P0 -Delimiter ","
$newcsv = @()

foreach($user in $ADUsers)
{
$matricule = $user.matricule
$CurrentDate = Get-Date -Format "dd/MM/yyyy"
$Debut = Get-Date $user.debutconge -Format "dd/MM/yyyy"
$Fin = Get-Date $user.finconge -Format "dd/MM/yyyy"
$Fin1 = [DateTime]::Now.Subtract([TimeSpan]::FromDays(1)) | get-date -format "dd/MM/yyyy"

    if ((($Debut -eq $CurrentDate) -and ($Fin -gt $CurrentDate)) -or (($Debut -lt $CurrentDate) -and ($Fin -gt $CurrentDate)) -or (($Debut -lt $CurrentDate) -and ($Fin -eq $CurrentDate)))
    { 
            Set-ADUser -Identity $user.Matricule -Enabled $false -Verbose
                 $newcsv += New-Object -TypeName PSObject -Property @{
                         'matricule' = $matricule
                         'debutconge' = $Debut
                         'finconge' = $Fin     
                                                                      }
    }
    elseif (($Debut -lt $CurrentDate) -and ($Fin1 -eq $Fin)) 
    {
            Set-ADUser -Identity $user.Matricule -Enabled $true -Verbose

    } 
    else 
    {

    }

}

$P = "./" + $CurrentDate0 + ".csv"
$newcsv | Export-CSV -NoTypeInformation -Path $P -Delimiter "," 
    