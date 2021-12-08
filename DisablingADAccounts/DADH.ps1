Import-Module ActiveDirectory
$CurrentDate0 = Get-Date -Format "dd-MM-yyyy"
$Fin0 = [DateTime]::Now.Subtract([TimeSpan]::FromDays(1)) | get-date -format "dd-MM-yyyy"
$P0 = "c:\" + $Fin0 + ".csv"
$ADUsers = Import-csv $P0 -Delimiter ";"
$newcsv = @()

foreach($user in $ADUsers)
{
$matricule = $user.matricule
#Write-Host $matricule
$CurrentDate = Get-Date -Format "dd/MM/yyyy"
#write-host $CurrentDate
$Debut = Get-Date $user.debutconge -Format "dd/MM/yyyy"
#write-host $Debut
$Fin = Get-Date $user.finconge -Format "dd/MM/yyyy"
#Write-Host $Fin
#Write-Host "######################################################"
$Fin1 = [DateTime]::Now.Subtract([TimeSpan]::FromDays(1)) | get-date -format "dd/MM/yyyy"

    if ((($Debut -eq $CurrentDate) -and ($Fin -gt $CurrentDate)) -or (($Debut -lt $CurrentDate) -and ($Fin -gt $CurrentDate)) -or (($Debut -lt $CurrentDate) -and ($Fin -eq $CurrentDate)))
    { 
            Set-ADUser -Identity $user.matricule -Enabled $false -Verbose 
            write-host "disable"
                 $newcsv += New-Object -TypeName PSObject -Property @{
                         'matricule' = $matricule
                         'debutconge' = $Debut
                         'finconge' = $Fin     
                                                                      }
    }
    elseif (($Debut -lt $CurrentDate) -and ($Fin1 -eq $Fin)) 
    {
            Set-ADUser -Identity $user.matricule -Enabled $true -Verbose
            write-host "enable"

    } 
    else 
    {
             Set-ADUser -Identity $user.matricule -Enabled $true -Verbose
             write-host "enable2"
    }

}

$P = "C:\" + $CurrentDate0 + ".csv"
$newcsv | Export-CSV -NoTypeInformation -Path $P -Delimiter ";" 
    