::current location which is the USB path
set "var=%cd%"
::script to be executed which exists in the current location
set "var2=\Launcher.ps1"
::concatenate both to have full path to the script
set "S=%var%%var2%"
:: The drive letter of the USB gonna change everytime so I wanna make sure that I get its path so that I avoid relative paths in the script 
::Making sure policy is bypassed and executing the script through its full path, plus passing a parametre of current location that the launcher script will use
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '%S% -Param1 %var%' -Verb RunAs}"