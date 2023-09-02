Before using this script make sure you already have a GPO that activates WinRM, some computers will refuse access and 
you might need another GPO that adds domain admin to each computer's local admins group (I know it's weird but it worked)
#########################
This script adds the serial number to the description of the computer objects that are in the domain.
Since computer names doesn't identify physical computers because it gets changed sometimes.
So this script will help you to identify to which person it belongs by checking the inventory database which will have each serial number affected to someone.