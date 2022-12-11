#Download base image ubuntu 20.04
FROM ubuntu:20.04

#Set default AJP address avar that will be used in the nginx conf,in case nothing is passed in at run time
ENV AJP_ADDRESS="127.0.0.1"

#Set the default version of nginx to install, in case nothing is passed in at build time
ARG NGINX_VERSION="1.22.1"

#Install required 
RUN apt update &&\
    apt install git curl wget build-essential zlib1g-dev -y

#Download and compile nginx with plugin
RUN wget https://nginx.org/download/nginx-$NGINX_VERSION.tar.gz &&\
    tar -xzvf nginx-$NGINX_VERSION.tar.gz &&\
    git clone https://github.com/dvershinin/nginx_ajp_module.git &&\
    cd nginx-$NGINX_VERSION &&\
    apt install libpcre3-dev -y &&\
    ./configure --add-module=`pwd`/../nginx_ajp_module --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules &&\
    make &&\
    make install

#Copy over nginx conf, as well as script that will set correct addressa ta runtime.
COPY nginx.conf /etc/nginx/conf/nginx.conf
COPY pre_conf.sh /usr/local/bin/pre_conf.sh
RUN chmod +x /usr/local/bin/pre_conf.sh

CMD ["/usr/local/bin/pre_conf.sh"]