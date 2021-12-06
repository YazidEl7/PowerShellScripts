/***************Same concept as Renaming&JoiningDomain (Check it to understand what we trying here) ****************/
But this time we gonna include the RJD folder under the C:\ drive 
in the image we gonna send the vendor to put on our PCs, 
Also we should already have executed the run .ps1 on the image before delivering it 
(Don't restart computer after executing it)
we'll have to have the db1.csv on a cenralized shared folder or ftp server.
the run.ps1 puts the run_test .bat in HKLM run so that it'll run everytime on startup and it keeps waiting for 
local network connection then it proceeds to downloading db1.csv and renaming the pc plus joining it to the domain
# Requirements : RJD folder in the systemdrive containing all the above files, put your domain credentials and domain also the ip and credentials 
for the shared folder conata  ining the db1.csv
