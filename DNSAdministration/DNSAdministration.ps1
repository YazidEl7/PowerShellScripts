echo " "
echo " "
Write-Host "*****************************************************************************************************************" -ForegroundColor Red
Write-Host "***********************                         DNS                                 *****************************" -ForegroundColor Red
Write-Host "*****************************************************************************************************************" -ForegroundColor Red
echo " "
#######################################################################################
Function EmptyLine {
    echo " "
}
Function CreateRecord(){
	param(
		[Parameter(Mandatory)]
		[string]$HostNameP,
		
		[Parameter(Mandatory)]
		[string]$NewAddressP,

		[Parameter(Mandatory)]
		[string]$DomainP
	)
    Add-DnsServerResourceRecordA -Name $HostNameP -IPv4Address $NewAddressP -ZoneName $DomainP -TimeToLive 01:00:00 -CreatePtr
}
Function DeleteRecord(){
	param(
		[Parameter(Mandatory)]
		[string]$DCP,
		
		[Parameter(Mandatory)]
		[string]$DomainP,

		[Parameter(Mandatory)]
		[string]$HostNameP
	)
    Get-DnsServerResourceRecord -ComputerName $DCP -ZoneName $DomainP -Name $HostNameP | Remove-DNSServerResourceRecord –ZoneName $DomainP –ComputerName $HostNameP
}
Function UpdateRecord(){
	param(
		[Parameter(Mandatory)]
		[string]$DCP,
		
		[Parameter(Mandatory)]
		[string]$DomainP,

		[Parameter(Mandatory)]
		[string]$HostNameP,

		[Parameter(Mandatory)]
		[string]$NewAddressP
	)
        $new = $old = Get-DnsServerResourceRecord -ComputerName $DCP -ZoneName $DomainP -Name $HostNameP

        $new.RecordData.IPv4Address = [System.Net.IPAddress]::parse($NewAddressP)

        Set-DnsServerResourceRecord -NewInputObject $new -OldInputObject $old -ZoneName $DomainP -ComputerName $DCP
}
Function Search(){
	param(
		[Parameter(Mandatory)]
		[string]$DCP,
		
		[Parameter(Mandatory)]
		[string]$DomainP,

		[Parameter(Mandatory)]
		[string]$HostNameP
    )
    $HN = "*" + $HostNameP + "*"
    $SearchR = Get-DnsServerResourceRecord -ComputerName $DCP -ZoneName $DomainP -RRType A | Where-Object HostName -ilike $HN
    #$SearchR = Get-DnsServerResourceRecord -ComputerName $DC -ZoneName $Domain -Name $HostName

    if ( $SearchR.Length -eq 0){Write-Host "Host Doesn't exist" -ForegroundColor Cyan}
    elseif ( $SearchR.Length -ne 0){Write-Host "Host exist !" -ForegroundColor Cyan; Write-Host ($SearchR | Format-Table | Out-String) -ForegroundColor Yellow}
}
######################################################################################
# Modify DC to your Domain Controller and Domain to the domain you intend to modify in.
$DC = "DC1-W19"
$Domain = "domain.private"

Write-Host " 1 - Normal Mode you search the host and you UPDATE or DELETE" -ForegroundColor Magenta
Write-Host " 2 - Advanced Mode you provide a CSV (Hostname, IP columns header required) File to do the above " -ForegroundColor Magenta
EmptyLine
$Mode = Read-Host -Prompt "Type 1 or 2 "
EmptyLine
$Choice = 11
if ($Mode -eq 1){
    while($Choice -ne 4)
    {

        $HostName = Read-Host -Prompt "Type Hostname "
        EmptyLine
        
        Search -DCP $DC -DomainP $Domain -HostNameP $HostName

        Write-Host "- Type 0 to CREATE - Type 1 to UPDATE - type 2 to DELETE - 3 to Search Again - 4 to EXIT" -ForegroundColor Green
        EmptyLine
        $Choice= Read-Host -Prompt "Type your choice "

        if ($Choice -eq 0){
            $NewAddress = Read-Host -Prompt "Type new address "
            CreateRecord -HostNameP $HostName -NewAddressP $NewAddress -DomainP $Domain}
        
        if ($Choice -eq 1){
            $NewAddress = Read-Host -Prompt "Type new address "
            UpdateRecord -DCP $DC -DomainP $Domain -HostNameP $HostName -NewAddressP $NewAddress}

        elseif ($Choice -eq 2){DeleteRecord -DCP $DC -DomainP $Domain -HostNameP $HostName}

        elseif ($Choice -eq 3) {echo "Search Again"}

        else {echo "EXIT !"}

    }
}
####################################################################################

elseif ($Mode -eq 2){

    $Path = Read-Host -Prompt "Type CSV File Full path "

    $DNScsv = Import-Csv $Path -Encoding UTF8 -Delimiter ";"

    Write-Host " - Type 1 to UPDATEALL - type 2 to DELETEALL - 3 to CREATEALL - 4 to EXIT" -ForegroundColor Green
    EmptyLine
    $Choice= Read-Host -Prompt "Type your choice "

    Foreach ($Record in $DNScsv) 
    {
        EmptyLine

        if ($Choice -eq 1){UpdateRecord -DCP $DC -DomainP $Domain -HostNameP $Record.Hostname -NewAddressP $Record.IP}

        elseif ($Choice -eq 2){DeleteRecord -DCP $DC -DomainP $Domain -HostNameP $Record.Hostname}

        elseif ($Choice -eq 3) {CreateRecord -HostNameP $Record.Hostname -NewAddressP $Record.IP -DomainP $Domain}

        else {echo "EXIT !"}
    }

}
