@echo off

title SICLM

:: Kill explorer and go full-screen
taskkill /f /im explorer.exe >nul
powershell -command "& {Add-Type -AssemblyName 'System.Windows.Forms'; [System.Windows.Forms.SendKeys]::Sendwait('{F11}')}"

:menu
cls
:: Menu Options
:: echo 1. Change Password
echo 2. Login
:: echo 115. Developer Mode
set /p option="Choose one: "

if "%option%"=="1" goto changep
if "%option%"=="2" goto passwd
if "%option%"=="115" goto dbg
goto end

:: Login Process
:passwd
cls

echo Passwd Login Manager
if not exist kernel31.sys (
    echo Password file not found. Exiting.
    goto end
)

:: Read password from file
for /f "delims=" %%p in (kernel31.sys) do set stored_password=%%p

:: Get user input for password
set /p input_password="Enter the password: "

:: Check if password is blank, return to menu
if "%input_password%"=="" (
    echo Password cannot be blank. Returning to the main menu...
    goto menu
)

:: Check if password is correct
if "%input_password%"=="%stored_password%" goto correct

:: If password is incorrect, restart the computer
echo Incorrect password. Restarting system...
shutdown /r /t 0
goto end

:correct
explorer.exe
msg.exe
goto endt

:: Change Password Process
:changep
set /p newpassword="Enter new password: "

:: Ensure the new password is not empty, return to menu if it is
if "%newpassword%"=="" (
    echo Error: Password cannot be empty. Returning to the main menu...
    goto menu
)

:: Delete the old password file and save the new one
del kernel31.sys
echo %newpassword% > kernel31.sys

echo Password changed successfully! Returning to the main menu...
goto menu

:: Developer Mode - Code named 115
:dbg
cls
echo Welcome to Developer Mode! Code named 115!
:dbgmenu
echo.
echo Developer Options:
echo 1. Show Current Password
echo 2. Display System Information
echo 3. Change Password
echo 4. Launch Task Manager
echo 5. List Files in Current Directory
echo 6. Launch Command Prompt
echo 7. Go Back
echo 8. Exit Developer Mode
set /p dbgchoice="Select an option: "

if "%dbgchoice%"=="1" goto showpass
if "%dbgchoice%"=="2" goto sysinfo
if "%dbgchoice%"=="3" goto changep
if "%dbgchoice%"=="4" goto taskmgr
if "%dbgchoice%"=="5" goto listfiles
if "%dbgchoice%"=="6" goto cmdprompt
if "%dbgchoice%"=="7" goto menu
if "%dbgchoice%"=="8" goto exitdbg
goto dbgmenu

:: Show the current password
:showpass
echo Current password is:
type kernel31.sys
echo .
pause
goto dbgmenu

:: Display System Information
:sysinfo
echo Gathering system information...
systeminfo | findstr /C:"OS Name" /C:"OS Version" /C:"System Manufacturer" /C:"System Model" /C:"Total Physical Memory"
pause
goto dbgmenu

:: Launch Task Manager
:taskmgr
echo Launching Task Manager...
start taskmgr
pause
goto dbgmenu

:: List Files in Current Directory
:listfiles
echo Listing all files in the current directory:
dir
pause
goto dbgmenu

:: Launch Command Prompt
:cmdprompt
echo Launching Command Prompt...
start cmd
pause
goto dbgmenu

:: Exit Developer Mode
:exitdbg
echo Exiting Developer Mode...
pause
explorer.exe
exit /b

:end

:endt

:: echo Click on this window and press alt+f4
