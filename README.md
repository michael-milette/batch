# batch - Collection of useful Windows command line batch files.
Copyright (c) 2017 TNG Consulting.ca - License GPL v3 or later.

mysqlbackup.cmd v1.0 for Windows - by Michael Milette - www.tngconsulting.ca
----------------------------------------------------------------------------

Backup mysql database(s) and optionally compress it/them.

Syntax: mysqlbackup </?> [databaseName|-all] <zip|gzip|tar|7z>

* /?: Display help.
* databaseName: Name of a single database that you want to export.
* -all: Will export all of the databases except for except for **information_schema** and **performance_schema**.
* zip|gzip|tar|7z: (optional) Format into which to compress (each of) the SQL script file(s).

Note: MySQL database(s) will be exported into individual files.

subfind.cmd v1.0 for Windows - by Michael Milette - www.tngconsulting.ca
------------------------------------------------------------------------

**Very** quickly lists all of the directories under the current directory containing the specified path (directories and/or file). This is especially useful when you have a bunch of similarly configured directory structures, such as websites, and want to locate those that have a particular file or folder, like a plugin, located in a specific location.

Syntax:  **subfind [subpath]**

Without any parameters, helpful information will be displayed.

Example: **subfind local\contact** - This searches all of the folders in the current directory for a folder called "local\contact". This could be useful to identify which directories contain a Moodle local type plugin called "contact".

Example: **subfind sites** - This seaches all of the folders in the current directory for those that contain a directory called "sites". This could be useful to identify which directories are Drupal sites.

Example: **subfind wp-config.php** - This seaches all of the folders in the current directory for those that contain a file called "wp-config.php". This could be useful to identify which directories are WordPress sites.
