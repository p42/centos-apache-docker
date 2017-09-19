#Install Apache on Centos7 with PHP
# FROM project42/s6-centos-php
FROM project42/s6-centos:1.18.1.5
MAINTAINER Brandon Cone bcone@esu10.org

#https://wordpress.org/latest.tar.gz

COPY container-files /

RUN yum install -y httpd