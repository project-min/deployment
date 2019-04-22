#!/bin/bash

if [ ! -d "/opt/nginx-1.14.1" ]; then
  wget -P /opt -c https://nginx.org/download/nginx-1.14.1.tar.gz
  tar xvf /opt/nginx-1.14.1.tar.gz -C /opt
  cd /opt/nginx-1.14.1
  ./configure #--add-module=/opt/fastdfs-nginx-module-master/src
  make
  make install

fi

cp /home/deployment/cluster-config/tracker/nginx.conf /usr/local/nginx/conf/

#systemctl start firewalld

#firewall-cmd --zone=public --add-port=8080/tcp --permanent

#firewall-cmd --reload

#/usr/local/nginx/sbin/nginx

#netstat -unltp | grep nginx
