/*************************************************************************************************************/
	This one is meant to be used with a GPO so that every computer on the next startup
	will modify the password for local accounts we specify, 
	which is in sucha environement will have same name across all computers.
	While any other local account created by the user on the computer before joining the pc to the domain, 
	will get removed
/************************************************************************************************************/
	Most of the PCs that have joined our domain will have the execution policy for scripts, set as restricted
	So you might have to conider modifying it in a GPO or make a Batch file that'll launch it for you
