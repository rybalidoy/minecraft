@echo off
title Minecraft Server

REM Function to handle shutdown and commit
:shutdown_commit
    echo Server stopped successfully
    REM Stage changes for commit
    git add .

    REM Commit the changes
    git commit -m "Automated commit: Minecraft server stopped and saved changes"

    REM Push the changes to the remote repository
    echo Pushing updates to GitHub
    git push origin main
    exit /B

REM Pull the latest changes from the main branch
echo Pulling latest server data
git pull origin main

REM Start the Minecraft server
start /wait java -Xmx1024M -Xms1024M -jar Minecraft-server-1.X.X.jar nogui

REM Check if the server stopped normally or was interrupted
IF ERRORLEVEL 1 (
    echo Server stopped unexpectedly
) ELSE (
    call :shutdown_commit
