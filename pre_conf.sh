#!/bin/sh

sed -i "s/AJP_ADDRESS/$AJP_ADDRESS/g" /etc/nginx/conf/nginx.conf

/usr/sbin/nginx -g "daemon off;"