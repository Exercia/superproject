#!/bin/sh

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout mykey.key -out mykey.crt -subj "/C=US/ST=Ok/L=Here/O=Hi/CN=www.totallylegit.com"
/sbin/apachectl 
/usr/sbin/sshd -D 
