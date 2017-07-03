@echo off
if not "%1"=="" goto SEARCH
:HELP
echo subfind.cmd v1.0 for Windows - by Michael Milette - www.tngconsulting.ca
echo Copyright (c) 2017 TNG Consulting.ca - License GPL v3 or later.
echo Lists all of the directories under the current directory containing
echo the specified path (directories and/or file).
echo.
echo Syntax:  subfind [subpath]
echo Example: subfind local\contact
echo Example: subfind sites
echo Example: subfind wp-config.php
GOTO DONE

:SEARCH
setlocal EnableDelayedExpansion
REM For each folder in the current directory.
for /d %%F in (*.*) do (
    REM If the specified path exists.
    if exist %%F/%1 (
        REM Display it.
        for /d %%P in (%%F\%1) do (
            set ATTRIBS=%%~aP
            set ATTRIBS=!ATTRIBS:~0,1!

            if /I !ATTRIBS!==d (
                REM Folder: Just the name. No extra attributes.
                echo %%~P
            ) else (
                REM File: Add date, time and file size.
                echo %%~tP %%~zP %%P
            )
        )
    )
)

:DONE
echo.
