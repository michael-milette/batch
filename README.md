# batch - A collection of Batch files for Windows command prompt.

subfind.cmd v1.0 for Windows - by Michael Milette - www.tngconsulting.ca
------------------------------------------------------------------------
Copyright (c) 2017 TNG Consulting.ca - License GPL v3 or later.

**Very** quickly lists all of the directories under the current directory containing the specified path (directories and/or file). This is especially useful when you have a bunch of similarly configured directory structures, such as websites, and want to locate those that have a particular file or folder, like a plugin, located in a specific location.

Syntax:  **subfind [subpath]**

Without any parameters, helpful information will be displayed.

Example: **subfind local\contact** - This searches all of the folders in the current directory for a folder called "local\contact". This could be useful to identify which directories contain a Moodle local type plugin called "contact".

Example: **subfind sites** - This seaches all of the folders in the current directory for those that contain a directory called "sites". This could be useful to identify which directories are Drupal sites.

Example: subfind wp-config.php - This seaches all of the folders in the current directory for those that contain a file called "wp-config.php". This could be useful to identify which directories are WordPress sites.
