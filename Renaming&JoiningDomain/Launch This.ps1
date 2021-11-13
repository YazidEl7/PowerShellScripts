# copying the current folder to sys drive where will it be for execution
Copy-Item -Path "." -Destination "C:\Domainjoin" -Recurse
# making the directory hidden
attrib +h "C:\Domainjoin"
#starting the .bat file which launches the main powershell as admin
Start-Process -FilePath C:\Domainjoin\Runs_main.bat -Verb Runas