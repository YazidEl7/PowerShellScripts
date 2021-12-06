# taking parameters from the batch file
param(
    [Parameter(Mandatory=$True, Position=0, ValueFromPipeline=$false)]
    [System.String]
    $Param1#,

    #[Parameter(Mandatory=$True, Position=1, ValueFromPipeline=$false)]
    #[System.String]
    #$Param2
)
# Making sure the policy won't stop the execution
Set-ExecutionPolicy Unrestricted -Force

# copying the current folder to sys drive where will it be for execution, using the earlier used current location env var %cd% 
$Dest = ($env:SystemDrive) + "\Domainjoin"
Copy-Item -Path $Param1 -Destination $Dest -Recurse -Force
# making the directory hidden
attrib +h $Dest

$FP = ($env:SystemDrive) + "\main.ps1"
# Running the main script as Admin
start-process powershell -ArgumentList '-noprofile -file $FP' -verb RunAs 

# Draft
#Start-Process -FilePath C:\Domainjoin\Runs_main.bat -Verb Runas
