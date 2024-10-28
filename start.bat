@echo off
title Minecraft Server

REM Pull the latest changes from the main branch
echo Pulling latest server data
git pull origin minecraft

REM Start the Minecraft server in a new window
start "Minecraft Server" cmd /c java -Xmx2048M -Xms1024M -jar server.jar nogui

REM Wait for the Minecraft server to stop
echo Waiting for the Minecraft server to stop...
:waitloop
timeout /t 10 >nul
tasklist | find /i "java.exe" >nul
if not errorlevel 1 goto waitloop

REM Get the current date and time
for /f "tokens=2 delims==" %%D in ('"wmic os get localdatetime /value"') do set dt=%%D
set dt=%dt:~0,4%-%dt:~4,2%-%dt:~6,2% %dt:~8,2%:%dt:~10,2%

REM Check if the server stopped normally or was interrupted
echo Server stopped successfully

REM Check if there are changes to commit
git add .
git diff-index --quiet HEAD --
if %errorlevel% neq 0 (
    REM Commit the changes with the current date and time
    git commit -m "Automated commit: Minecraft server stopped and saved changes on %dt%"

    REM Push the changes to the remote repository
    echo Pushing updates to GitHub
    git push origin minecraft

    echo Server changes saved
) else (
    echo No changes to commit
)

pause
