::Making sure policy is bypassed and executing the script through its full path
set "var=%SYSTEMDRIVE%"
set "var2=\RJD\Connection_Test.ps1"
set "S=%var%%var2%"
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-noprofile -file %S%' -verb runas'}"
