########################################################################
This script meant to be executed on daily basis, it needs for the first time a csv file 
named after the date of the previous day, HR provide us with ppl's IDs that have gone on a holiday
and for how long so that we can disable their accounts temporarily, (and enable it on the day they are supposed to return)
after the first execution it'll create a csv file with the current date containing the ones 
that are still disabled, so that it'll check it the day after (for optimization reasons so it won't parse through old data, 
like ppl that got their accounts enabled after their return, while they shouldn't exist in that file anymore)
In case HR provided new csv for new entries, you must append it to that day's csv file to be executed the day after. 