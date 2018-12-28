@echo off
echo mysqlbackup.cmd v1.0 for Windows - by Michael Milette - www.tngconsulting.ca
if "%1"=="/?" goto :HELP
if "%1"=="--help" goto :HELP
if "%1"=="-help" goto :HELP
if "%1"=="-h" goto :HELP
if "%1"=="" goto :HELP
goto :CONFIG

:HELP
echo Copyright (c) 2017 TNG Consulting.ca - License GPL v3 or later.
echo Backup mysql database(s) and optionally compress it/them.
echo https://github.com/michael-milette/batch/
echo.
echo Syntax: mysqlbackup ^</?^> ^<databaseName^|-all^> ^<zip^|gzip^|tar^|7z^> ^<-dow^>
echo.
echo    databaseName: Name of a single database that you want to export.
echo    -all: Will export all of the databases except for except for information_schema and performance_schema.
echo    zip^|gzip^|tar^|7z: (optional) Format into which to compress (each of) the SQL script file(s).
echo    -dow: Will create folder with week day name (monday...) instead date number format (20181228_2126)
echo.
echo Note: MySQL database(s) will be exported into individual files.
goto :EOF

:CONFIG
:: You must configure this section before using.
SETLOCAL EnableDelayedExpansion
set dbUser=root
set dbPassword=dova2000
set backupDir=C:\wamp\Backup
set mysql="C:\wamp\bin\mysql\mysql5.5.24\bin\mysql.exe"
set mysqldump="C:\wamp\bin\mysql\mysql5.5.24\bin\mysqldump.exe"
set zip="C:\Program Files\7-Zip\7z.exe"
if not "%dbPassword%"=="" set dbUser=%dbUser% -p%dbPassword%
if "%dbUser%"=="" echo Edit the batch file to configure the database user and password. & goto :EOF
if not exist %backupDir%\ echo Edit the batch file to configure the backup directory path. & goto :EOF
if not exist %mysql% echo Edit the batch file to configure the path for MySQL.exe. & goto :EOF
if not exist %mysqldump% echo Edit the batch file to configure the path for MySQLDump.exe. & goto :EOF
if not exist %zip% echo Edit the batch file to configure the path for 7zip.exe. & goto :EOF

:: Switch folder name format
if "%3"=="-dow" goto :PARSEDOW

:: Get data and time.
for /f "skip=1" %%d in ('wmic OS GET LocalDateTime') do (set ldt=%%d & goto PARSELDT)
:PARSELDT
set dirName=%ldt:~0,8%_%ldt:~8,4%
goto CREATEFOLDER

:: Get day of week
:PARSEDOW
for /f %%i in ('powershell ^(get-date^).DayOfWeek') do set dirName=%%i


:: Create backup folder.
:CREATEFOLDER
if not exist %backupDir%\%dirName%\ (
    mkdir %backupDir%\%dirName%
)
echo Databases will be backed-up into: %backupDir%\%dirName%

:: Switch for single database or all databases mode.
for %%A in (zip gzip tar 7z) do if "%2"=="%%A" set aformat=%2
if "%1"=="-all" goto :ALL
if "%1"=="-a" goto :HELP
goto :SINGLE

:SINGLE
echo Backing up database: %1 ...
%mysqldump% --host="localhost" --user=%dbUser% --single-transaction --add-drop-table --databases %1 > %backupDir%\%dirName%\%1.sql
if not "%aformat%"=="" (
    echo Compressing SQL script to %1.sql.%2
    %zip% a -t%2 %backupDir%\%dirName%\%1.sql.%2 %backupDir%\%dirName%\%1.sql >nul
    del %backupDir%\%dirName%\%1.sql
)
echo Done.
goto :EOF

:ALL
echo Please be patient. Exporting all of the databases may take a while.
:: Get a list of the databases from MySQL and backup them all except for information_schema and performance_schema.
%mysql% -u%dbUser% -s -N -e "SHOW DATABASES" | for /F "usebackq" %%f in (`findstr /V "information_schema performance_schema"`) do @(
    echo Backing up database: %%f ...
    %mysqldump% --host="localhost" --user=%dbUser% --single-transaction --add-drop-table --databases %%f > %backupDir%\%dirName%\%%f.sql
    if not "%aformat%"=="" (
        echo Compressing SQL script to %%f.sql.%2
        %zip% a -t%2 %backupDir%\%dirName%\%%f.sql.%2 %backupDir%\%dirName%\%%f.sql >nul
        del %backupDir%\%dirName%\%%f.sql
    )
)
echo Done.

:EOF
