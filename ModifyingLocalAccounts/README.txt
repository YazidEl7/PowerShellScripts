/*************************************************************************************************************/
	This one is meant to be used with a GPO so that every computer on the next startup
	will modify the password for local accounts we specify, 
	which is in sucha environement will have same name across all computers.
	While any other local account created by the user on the computer before joining the pc to the domain, 
	will get removed
/************************************************************************************************************/
/************************************** main *********************************************************/
main .ps1 is checks the Os Architecture then it for each Arch, it'll check based on Os name wether it has a specific account created 
(in our case win10-64 bit for windows 10), if it doesn't exist it'll create it. I tried to optimize it, So that whether it exist or not the lines
following the creation are common in both cases, but in case it was created, it'll skip resetting its password 
(Cuz we intend to change their password too), then we gonna
remove other accounts but the ones listed in the condition alongside the one we want to be in the PC
///////////////////////////////////////////////////////////////////////////////////////////////////////
/************************************* main2 .ps1 ****************************************************/
That one is soo simple, it checks for the existence of an account and chanes its name, 
Otherwise it'll remove any other account but the ones listed in the condition
******************************************************************************************************
Execution policy might stop the PoSh script, make sure to make a batch file script that launches the PoSh for the GPO
