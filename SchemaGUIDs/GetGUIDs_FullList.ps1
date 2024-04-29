$rootdse = Get-ADRootDSE
$guidmap = @{}
Get-ADObject -SearchBase ($rootdse.SchemaNamingContext) -LDAPFilter `
"(schemaidguid=*)" -Properties lDAPDisplayName,schemaIDGUID |
% {$guidmap[$_.lDAPDisplayName]=[System.GUID]$_.schemaIDGUID}
$guidmap > c:\GUIDs.txt