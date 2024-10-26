@echo off
title Minecraft Server

REM Pull the latest changes from the main branch
echo Pulling latest server data
git pull origin main

REM Start the Minecraft server in a new window
start "Minecraft Server" cmd /c java -Xmx1024M -Xms1024M -jar server.jar nogui

REM Wait for the Minecraft server to stop
echo Waiting for the Minecraft server to stop...
:waitloop
timeout /t 10 >nul
tasklist | find /i "java.exe" >nul
if not errorlevel 1 goto waitloop

REM Check if the server stopped normally or was interrupted
echo Server stopped successfully
REM Stage changes for commit
git add .

REM Commit the changes
git commit -m "Automated commit: Minecraft server stopped and saved changes"

REM Push the changes to the remote repository
echo Pushing updates to GitHub
git push origin main

pause
