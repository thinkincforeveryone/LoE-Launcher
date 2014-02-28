LoE-Launcher
============

This is a simple launcher with updater for private servers of Legends of Equestria.

<h3>How to use (Player)</h3>

Extract in the Legends of Equestria folder, start Launcher.exe and the launcher will check for updates, if there are pending updates, the launcher will update the game, if not, the play button is released.

(The current release is configured to update the files for my private server)

<h3>How to use (Server Admin)</h3>

1- First, send the "launcher" folder that is inside the "www" folder to a web server.

2- Then, go in the launcher folder and open the config.ini file with the notepad

[Configs]<p>
ServerName=Here is the Server Name (The launcher will show this name everywhere)[Ex: LoeBR]

Version=Here is the version of the files (The launcher will compare this version number with the version number on the web server, if they are different, the launcher will update the game) [Ex: v1.0]

Website=Here is your website (The launcher will open this website by clicking on the image on the launcher)<p>
[Ex: http://loebr.cf/]

ChangelogURL=Here is the Changelog URL (The launcher will open this link on the second tab) <p>
[Ex: http://loebr.cf/launcher/changelog.html]

UpdateURL=Here is the update URL (Here is where the launcher will search for the update, here you will put the link for the "launcher" folder on you web server)<p>
[Ex: http://loebr.cf/launcher/]

[Launch]<p>
ExeFile=Here is the executable file that will run by clicking on the play button [Ex: loe.exe]

3- Save all, and done!

<h3>How the launcher works</h3>

Basically, when you open the launcher, it will connect to the web server and download the "currentversion.ini" file. In the file "currentversion.ini" will have the current version of the client. After download the file, it will compare the "currentversion.ini" file with the "version.ini" file. The file "version.ini" contains the number of the current version of the client. If the version numbers are the same in both files, the launcher will conclude that the client is updated. Otherwise, if the version numbers are different, the launcher will conclude that the client is outdated and then the launcher will download the file "update.ini" from the web server. The file "update.ini" will contain the update file. The update file is basically a .rar file with all the files to be updated on the client. After reading the "update.ini" file, the launcher will download the .rar file, written in the "update.ini" file, and then extract the .rar file. After all this, it will save the updated version number in "version.ini" file and then the client was updated! ~Yay

<h3>Screenshot</h3>

<img src="https://dl.dropboxusercontent.com/s/3kmg4e1fv9yuadz/ss.png"/>
