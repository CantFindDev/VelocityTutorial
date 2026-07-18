@echo off
cls
:start
title Server
java -DIReallyKnowWhatIAmDoingISwear -Xmx1512M -jar Server.jar nogui
set choice=
set /p choice="Do you want to restart? Press 'Y' and enter for yes: "
if not '%choice%!'=='' set choice=%choice:~0,1%
if '%choice%'=='y' goto start
