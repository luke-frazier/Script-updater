
::
:: This file is part of the Script Update Engine by trter10.
::
:: This program is free software. It comes without any warranty, to
:: the extent permitted by applicable law. You can redistribute it
:: and/or modify it under the terms of the Do What The Fuck You Want
:: To Public License, Version 2, as published by Sam Hocevar. See
:: http://sam.zoy.org/wtfpl/COPYING for more details.
:: 

::Start clean again :)
@echo off
SETLOCAL
set script-md5=
set servermd5=

:MAIN

::Clear "Checking for updates" off the screen
cls

::Let user know we are updating
echo Updating...

::Even if there was an error and the user is stuck with only OTA.bat, it will still download and verify the latest version of the script.
IF NOT EXIST support_files\Script-server-MD5.txt (support_files\wget --quiet -O support_files\Script-server-MD5.txt <URL>)

::Download latest script from server
support_files\wget --quiet -O script.bat <URL>

::Verifying a correct download by checking MD5sums 

::Building MD5 of downloaded script
FOR /F "tokens=1 delims=" %%a in ( 'support_files\md5sums script.bat' ) do ( set script-md5=%%a )

::Setting the Server MD5 as %script-new-MD5% again
set /p script-new-md5=<support_files\Script-server-MD5.txt >>%log%

::If the MD5's aren't equal, let's retry. If not, continue on.
IF "%script-md5%" NEQ "%script-new-md5% " (
GOTO MAIN
)

::Remove the MD5 file
del support_files\Script-server-MD5.txt

::Clean screen for start of new scriot
cls

::Start new script
script.bat

ENDLOCAL