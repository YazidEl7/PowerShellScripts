This script is made to Interact with Windows DNS server in your daily tasks using Powershell.
It'll help a lot especially if you get a list of servers to create DNS records to,
Or that no longer exists and needs to be deleted or that needs their IPs to be Updated.

In the Advanced Mode you'll be able to provide a CSV File, with two column headers; 
I called them Hostname and IP in the script.

For the Normal mode, you can do one at a time where you check existence first and then choose what to do,
This is helpful just if you have a few that are mixed, some to DELETE, CREATE, UPDATE

Also, you can use it inside an invoke without connecting on RDP to the actual server, it needs just a little tweak for that.
