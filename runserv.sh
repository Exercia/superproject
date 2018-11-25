#!/bin/sh




mkdir -p /git/admin
chown -R admin.admin /git
cd /git/
mkdir .ssh && chmod 700 .ssh

cd /git/admin
su admin -c "git init"
su admin -c "git add ."
su admin -c "git config --global user.email 'me@here.com'"
su admin -c "git config --global user.name 'me'"
su admin -c "git commit -m 'Admin repo established'"




#now that setup is done.. making admin a git-shell
sed -i '/admin/s/bin\/bash/usr\/bin\/git-shell/g' /etc/passwd
sed -i '/admin/s/home\/admin/git/g' /etc/passwd
mkdir /git/git-shell-commands
cp help /git/git-shell-commands/help
chown -R admin.admin /git

#build self signed cert
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /mykey.key -out /mykey.crt -subj "/C=US/ST=Ok/L=Here/O=Hi/CN=www.totallylegit.com"

/root/setupcron.sh
/sbin/apachectl 
/usr/sbin/sshd -D 
