/***************Meant for PCs that haven't joined the domain yet*****************************/
#When we buy PCs we like to identify it by our own serial numbers generated from our inventory system 
#not the serial that the vendor alread assigns to the hardware
#we send to a vendor our own serials
#to allocate each one to a PC (They put a ticket on the hardware, of the correspondent inventory number) 
that got already its own serial number from the manufacturer
#At the end the vendor sends us a file containing two columns (Inventory and Serial)
#So that we rename the pc later with its inventory number and we join it to a domain
###########################################################################
# Launch run_launcher .bat and it'll take care of everything.
# Make sure to change domain stuff and credentials in the domainjoin .ps1
