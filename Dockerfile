FROM project42/s6-centos:1.18.1.5
MAINTAINER Brandon Cone bcone@esu10.org

#https://wordpress.org/latest.tar.gz

COPY container-files /

RUN yum install -y httpd


# #Add S6 Overlay
# ENV S6_RELEASE 1.20.0.0
# ADD https://github.com/just-containers/s6-overlay/releases/download/v$S6_RELEASE/s6-overlay-amd64.tar.gz /tmp/
# RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C / --exclude="./bin" \
#  && tar xzf /tmp/s6-overlay-amd64.tar.gz -C /usr ./bin

 #Install LAMP stack components
#RUN yum install -y wget, php, 

#Every time you add something that you want running, you must add its non-deamonized service.


#Add Service NGINX to be Monitored by S6
# RUN mkdir -p /etc/services.d/sh/ \
#  && touch /etc/services.d/sh/run \
#  #&& echo '#!/usr/bin/execlineb -P' > /etc/services.d//run \
#  && echo 'sh' >> /etc/services.d/sh/run

 # ENTRYPOINT ["/init"]