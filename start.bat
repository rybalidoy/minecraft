@echo off
title Minecraft Server

REM Pull the latest changes from the main branch
echo Pulling latest server data
git pull origin main

REM Start the Minecraft server and wait for it to stop
cmd /c start /wait java -Xmx1024M -Xms1024M -jar Minecraft-server-1.X.X.jar nogui

REM Stage changes for commit
git add .

REM Commit the changes
git commit -m "Automated commit: Minecraft server stopped and saved changes"

REM Push the changes to the remote repository
echo Pushing updates to GitHub
git push origin main

pause
