/*************************************************************************************************************/
	This one is meant to be launched on the AD server so that every computer that's on
	will get its local accounts password modified and save the unreacheable ones in a file.
	Sucha environements have same local accounts name across all computers.
	While any other local account created by the user on the computer before joining the pc to the domain, 
	will get disabled or removed
/************************************************************************************************************/

it'll check based on Os name wether it has a specific account created 
(in our case win10-64 bit for windows 10), if it doesn't exist it'll create it. I tried to optimize it, So that whether it exist or not the lines
following the creation are common in both cases