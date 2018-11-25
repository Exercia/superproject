#!/bin/bash
sed -i '/session    required   pam_loginuid.so/c\#session    required   pam_loginuid.so' /etc/pam.d/crond
echo "* * * * * /usr/bin/sh /root/gitperms.sh" > mycron
crontab mycron
rm mycron
crond

