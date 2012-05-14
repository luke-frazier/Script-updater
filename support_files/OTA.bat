@echo off
::
:: This file is part of the Script Update Engine by trter10.
::
:: This program is free software. It comes without any warranty, to
:: the extent permitted by applicable law. You can redistribute it
:: and/or modify it under the terms of the Do What The Fuck You Want
:: To Public License, Version 2, as published by Sam Hocevar. See
:: http://sam.zoy.org/wtfpl/COPYING for more details.
:: 
echo.
echo -There is a new version of this script availible. Downloading now...
echo.
::Getting new version's download link.
support_files\wget --quiet -O support_files\New-ver-DL.txt <URL>
set /p NewVerDL-URL= <support_files\New-ver-DL.txt
del script.bat
support_files\wget -O support_files\script.bat %NewVerDL-URL%
del support_files\New-ver-DL.txt
MOVE support_files\script.bat script.bat >NUL
echo.
::Checking MD5sums again, just to make it failproof.
support_files\md5sums script.bat>support_files\Script-new-MD5.txt
fc /b support_files\Script-new-MD5.txt support_files\Script-server-MD5.txt >NUL
if errorlevel 1 (Goto re-DL)
start script.bat
del support_files\Script-new-MD5.bat
exit
:re-DL
del script.bat
support_files\wget -O support_files\script.bat %NewVerDL-URL%
del support_files\New-ver-DL.txt
MOVE support_files\script.bat script.bat >NUL
echo.
::Checking MD5sums again, just to make it failproof.
support_files\md5sums script.bat>support_files\Script-new-MD5.txt
fc /b support_files\Script-new-MD5.txt support_files\Script-server-MD5.txt >NUL
if errorlevel 1 (Goto re-DL)
start script.bat
del support_files\Script-new-MD5.bat
exit