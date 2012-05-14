::
:: This program is free software. It comes without any warranty, to
:: the extent permitted by applicable law. You can redistribute it
:: and/or modify it under the terms of the Do What The Fuck You Want
:: To Public License, Version 2, as published by Sam Hocevar. See
:: http://sam.zoy.org/wtfpl/COPYING for more details.
:: 
:: * * * * * * * * * * * * *
:: * Script update engine  *
:: *                       *
:: *      By trter10       *
:: * * * * * * * * * * * * *
::
:: PLEASE NOTE - APPLICABLE TO THIS AND SUPPORT_FILES\OTA.BAT:
::   -Keep the script names the same throughout the versions.
::   -Make sure the MD5 text file on the server is in the same format that md5sums.exe outputs (HASH  script.bat) (TWO SPACES!)
::   -You must substitute your script's name for script.bat.
::   -You must substitute the appropriate URL for <URL>. Remove the <> also.

:: TO SUCCESSFULLY UPDATE THE PROGRAM:
::   -Edit the MD5sum file on the server and change the hash to the appropriate one. Edit ONLY the hash.
::   -If you're keeping the old versions on the server, upload the new version and edit the New-ver-DL.txt on the server to reflect the new download location.
::   -If you're not, just delete the old script and upload the new one (keep the same name!!)
::
@echo off
echo Checking for updates...
::In case of freshly updated script...
IF EXIST support_files\Script-MD5.txt (del support_files\Script-MD5.txt)
IF EXIST OTA.bat (MOVE OTA.bat support_files\OTA.bat) >NUL
IF EXIST support_files\Script-server-MD5.txt (del support_files\Script-server-MD5.txt)
::Building MD5 of current script
support_files\md5sums script.bat >support_files\Script-MD5.txt
:: Downloading latest MD5 Definitions
support_files\wget --quiet -O support_files\Script-server-MD5.txt <URL>
::Checking to see if there's a new version...
fc /b support_files\Script-MD5.txt support_files\Script-server-MD5.txt >NUL
if errorlevel 1 (Goto OTA) ELSE (GOTO PROGRAM)
:OTA
MOVE support_files\OTA.bat OTA.bat >NUL
start OTA.bat
exit
:PROGRAM
del support_files\Script-MD5.txt
del support_files\Script-server-MD5.txt
::Your program here...