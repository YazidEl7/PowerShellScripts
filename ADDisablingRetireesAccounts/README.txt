We want to disable Retired Employee's Accounts, Using a file provided by HR.
we might do it too to the ones that left for some reason.
HR makes chngements to the same file, So I added first line in CSV file
a column called "csvstate" that for the first time it'll have "M0" value just so I can logically
control the state of the file, then I grab all the ones that left then I change their "CSVstate" to
a value of 'T' for later, then I export them to the file that I'll rely on to disable accounts, Also I'll change that 'M0' to 'A'
Supposing it'll get executed next month, if HR modified any entry they gotta change the "csvstate" value 
on first line from 'A' to 'M', so that the script know it got modified and it'll proceed, 
but this time since we last time gave a 'T' "csvstate" value to the ones we exported. 
we'll export just the ones that got modified.
 
