

$newcsv = @()
$P = "c:\HN.csv"

#format "192.168.1"
$Subnets = Import-csv "C:\Subnets.csv" -Delimiter ";"


foreach ($Subnet in $Subnets) {
echo $Subnets.AR
    for($i=1; $i -lt 254; $i++){

        $addr = $Subnet.AR + ".$i"
        echo $addr
        $HN = (Resolve-DnsName -Name $addr -Type PTR -ErrorAction SilentlyContinue).NameHost
    
        if ( ($HN).length -gt 0 ) { 

                 $newcsv += New-Object -TypeName PSObject -Property @{
                         'Address' = $addr
                         'Hostname' = $HN    
                                                                      }
         }
     }
}



$newcsv | Export-CSV -NoTypeInformation -Path $P -Delimiter ";" 





########################
#Get-NetIPConfiguration
#Get-DhcpServerInDC