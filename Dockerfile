
#opening stuff
FROM centos:latest
MAINTAINER Jeremiah

#install httpd and sshd
RUN yum -y install httpd
RUN yum -y install openssh-server
RUN yum -y install mod_ssl
RUN yum -y install cronie

##configure SSHD
RUN mkdir /var/run/sshd
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN echo "export VISIBLE=now" >> /etc/profile

RUN /usr/bin/ssh-keygen -A

COPY index.html /var/www/cgi-bin/
COPY mykey.key mykey.key
COPY mykey.crt mykey.crt
COPY httpd.conf /etc/httpd/conf/httpd.conf
COPY gitperms.sh /root/gitperms.sh
COPY setupcron.sh /root/setupcron.sh
RUN chmod +x /root/*.sh

RUN yum install git -y
RUN adduser admin
RUN echo "theempiredidnothingwrong"|passwd admin --stdin
RUN mkdir /git/
RUN chown -R admin.admin /git/

COPY runserv.sh /runserv.sh
RUN chmod +x runserv.sh

CMD /runserv.sh 

EXPOSE 22
EXPOSE 80 
EXPOSE 443
EXPOSE 4443
