@echo off
title Hanami Minecraft Server

REM Pull the latest changes from the main branch
git pull origin main
echo Pull latest server data

REM Start the Minecraft Server
start /wait java -Xmx2048M -Xms1024M -jar server.jar nogui

REM Check if server stoppped normally

IF ERRORLEVEL 1 (
  echo Server stopped unexpectedly
) ELSE (
  echo Server stopped successfully
  REM Navigate to server directory
  
  git add .
  REM Commit changes
  git commit -m "Automated commit: Minecraft server stopped and saved changes"

  REM Push the changes to the remote repository
  git push origin main
)

pause