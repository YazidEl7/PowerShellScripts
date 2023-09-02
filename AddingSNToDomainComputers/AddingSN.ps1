$Computers=(Get-ADComputer -SearchBase "OU=Computers,DC=domdaman,DC=intra" -Filter *).Name

echo "##########################################################################################################################################################"
echo "Loop 1" 
Foreach ($Computer in $Computers) 
{
     echo "**********************"
     echo $Computer
     $Ind = (Get-ADComputer $Computer -Properties *).Location
     if ( ($Ind -ne "1") -and ((Test-Connection $Computer -Count 1 -Quiet) -ilike "True") ) {
        
        $SN = Invoke-Command -computername $Computer -ScriptBlock {((wmic bios get serialnumber | where {$_ -inotlike "Serial*"}) -join ' ').replace(" ","")} 
        if ($SN.length -ne 0){
            $OD = (Get-ADComputer $Computer -Properties *).description
            $ND = "SN : "+ $SN + "/" +$OD
            Set-ADComputer $Computer -Description $ND
            Set-ADComputer $Computer -Location "1"
            echo "Done"
        }
        else {echo "WinRM problem"}
      }
     else {echo "Not connected"}

}


