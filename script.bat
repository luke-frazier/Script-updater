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
::
:: TO SUCCESSFULLY UPDATE THE PROGRAM:
::   1- Edit the MD5sum file on the server and change the hash to the appropriate one. Edit ONLY the hash.
::   2- Update the script on the server.
::
:: NOTES:
::   -This is a system of MD5sums. This means that if the user edits the program manually, their edits will be overwritten.
::   -Make sure when you are coding updates, uncomment line 38. In simple English, if line 38 is not commented, the program 
::    will not check for updates, thus allowing you to code new ones. MAKE SURE YOU RE-COMMENT THE LINE BEFORE YOU PUT THE 
::    NEW SCRIPT ON THE SERVER AND CALCULATE THE MD5! (I know from experience :P)
::

::Start off clean :)
@echo off
SETLOCAL rem This command keeps variables local, put it directly after @echo off.
set script-new-md5=NULL
set script-md5=NULL

::Read notes section above for an explanation of the line below.
::GOTO PROGRAM REM ADD :: TO BEGINNING OF THIS LINE FOR RELEASE VERSIONS!

::Let the user know we auto-update
echo Checking for updates...

::In case of freshly updated script
IF EXIST support_files\Script-MD5.txt (del support_files\Script-MD5.txt)
IF EXIST OTA.bat (MOVE OTA.bat support_files\OTA.bat) >NUL
IF EXIST support_files\Script-server-MD5.txt (del support_files\Script-server-MD5.txt)

:: Downloading latest MD5 Definitions
support_files\wget --quiet -O support_files\Script-server-MD5.txt <URL>

::Building MD5 of current script
FOR /F "tokens=1 delims=" %%a in ( 'support_files\md5sums script.bat' ) do ( set script-md5=%%a )

::Setting the Server MD5 as %script-new-MD5%
set /p script-new-md5=<support_files\Script-server-MD5.txt >>%log%

::If the MD5's aren't equal (there is an update), let's update. If not, continue on.
IF "%script-new-md5% " NEQ "%script-md5%" (
MOVE support_files\OTA.bat OTA.bat >>%log% 2>&1
OTA.bat
)

::No updates are availible, so we start the program now.
echo.
echo No updates availible

::Remove the MD5 file
del support_files\Script-server-MD5.txt

:PROGRAM
:: --- Program goes here ---

ENDLOCAL rem This command keeps variables local, put it at end of program.