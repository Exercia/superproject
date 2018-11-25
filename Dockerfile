
#opening stuff
FROM centos:latest
MAINTAINER Jeremiah

#install httpd in case we need it and open sshd
RUN yum -y install httpd
RUN yum -y install openssh-server
RUN yum -y install mod_ssl

##configure SSHD
RUN mkdir /var/run/sshd
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN echo "export VISIBLE=now" >> /etc/profile

RUN /usr/bin/ssh-keygen -A

COPY index.html /var/www/html/
COPY mykey.key mykey.key
COPY mykey.crt mykey.crt
COPY httpd.conf /etc/httpd/conf/httpd.conf

RUN yum install git -y
RUN adduser admin
RUN echo "theempiredidnothingwrong"|passwd admin --stdin
RUN su admin 
RUN cd
RUN mkdir .ssh && chmod 700 .ssh
RUN mkdir -p /git/admin
RUN cd /git/
RUN git init --bare --shared /git
COPY runserv.sh /runserv.sh
RUN chmod +x runserv.sh

CMD /runserv.sh 

EXPOSE 22
EXPOSE 80 
#EXPOSE 443
#EXPOSE 4443
