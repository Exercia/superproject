# superproject
It's super.

This project requires Docker and bash.  That is really about it.  I spun up an AWS instance and built it there.
Several scripts are in the /bin directory.

![Scripts](https://github.com/Exercia/superproject/blob/master/Pictures/binscipts.jpg)

Once you have Docker installed run ./install.sh.  This script will follow the Dockerfile downloading centos:latest and utilizing yum to gather required packages, building your container.

![Scripts](https://github.com/Exercia/superproject/blob/master/Pictures/installscript.jpg)

After the build is complete run ./start.sh.  The container will start.  This the Dockerfile copies several files to the container then runs runserv.sh.  runserv.sh sets up the git repo in /git/admin with nothing in it.  It configures the admin user account with git-shell, sets up a cron job and launches httpd and sshd as well as generating self signed web certs.

![Scripts](https://github.com/Exercia/superproject/blob/master/Pictures/startscript.jpg)

If you create a shell file that you want run on the container you can put it in the admin directory and run the ./push.sh script.  This script will set up your repo, configure your git remote to be the ip I hard wired for my container and push your file.  Within 1 minute (this is kind of a cron hack.. git trigger would be better) the container will merge in your file to the admin repo, make it executable and when port 443 is visited it will execute.  

![Scripts](https://github.com/Exercia/superproject/blob/master/Pictures/pushscript.jpg)

The result will be displayed to your web browser.

![Scripts](https://github.com/Exercia/superproject/blob/master/Pictures/browseroutput.jpg)
