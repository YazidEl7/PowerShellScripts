##################################################################################################################
# When we buy PCs we like to identify it by our own serial numbers generated from our inventory system 
# not the serial that the vendor alreadY assigns to the hardware
# we send to the vendor our own serials
# to allocate each one to a PC that got already its own serial number from the manufacturer
# At the end the vendor sends us a CSV file containing two columns (Inventory and Serial)
# The following code will Rename PCs that has already joined a domain but
# hasn't changed it's name to the corresponding value of its serial number
#
# Check the other script I made for PCs that hasn't joined domain yet.
# 
# this script is meant to be used with a GPO, which will be applied on computers