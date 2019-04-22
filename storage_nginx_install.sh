#!/bin/bash

### Install nginx
if [ ! -d "/opt/fastdfs-nginx-module-master" ]; then
  wget -P /opt https://github.com/happyfish100/fastdfs-nginx-module/archive/master.zip
  unzip /opt/master.zip -d /opt
  sed -i '6s/\/usr\/local\/include/\/usr\/include\/fastdfs \/usr\/include\/fastcommon\//g' /opt/fastdfs-nginx-module-master/src/config
  sed -i '15s/\/usr\/local\/include/\/usr\/include\/fastdfs \/usr\/include\/fastcommon\//g' /opt/fastdfs-nginx-module-master/src/config

  #cp /opt/fastdfs-nginx-module-master/src/mod_fastdfs.conf /etc/fdfs
  ###vim /etc/fdfs/mod_fastdfs.conf
  #sed -i "10s/\/tmp/\/data\/fastdfs\/storage/g" /etc/fdfs/mod_fastdfs.conf
  #sed -i "40s/tracker:22122/$IP_ADDRESS:22122/g" /etc/fdfs/mod_fastdfs.conf
  #sed -i '53s/false/true/g' /etc/fdfs/mod_fastdfs.conf
  #sed -i '62s/\/home\/yuqing\/fastdfs/\/data\/fastdfs\/storage/g' /etc/fdfs/mod_fastdfs.conf
fi

if [ ! -d "/opt/nginx-1.14.1" ]; then
  wget -P /opt -c https://nginx.org/download/nginx-1.14.1.tar.gz
  tar xvf /opt/nginx-1.14.1.tar.gz -C /opt
  cd /opt/nginx-1.14.1
  ./configure --add-module=/opt/fastdfs-nginx-module-master/src
  make
  make install

  ###vim /usr/local/nginx/conf/nginx.conf
  #sed -i "36s/80/8888/g" /usr/local/nginx/conf/nginx.conf
  #sed -i "43s/\//~\/group([0-9])\/M00/g" /usr/local/nginx/conf/nginx.conf
  #sed -i "44s/root   html;/ngx_fastdfs_module;/g" /usr/local/nginx/conf/nginx.conf
  #sed -i "45d " /usr/local/nginx/conf/nginx.conf
fi

cp /home/deployment/cluster-config/storage/nginx.conf /usr/local/nginx/conf/


if [ ! -f "/etc/fdfs/http.conf" ]; then
  cp /opt/fastdfs-5.11/conf/http.conf /etc/fdfs/
fi

if [ ! -f "/etc/fdfs/mime.types" ]; then
  cp /opt/fastdfs-5.11/conf/mime.types /etc/fdfs/
fi

#systemctl start firewalld

firewall-cmd --zone=public --add-port=8080/tcp --permanent

firewall-cmd --reload

/usr/local/nginx/sbin/nginx

netstat -unltp | grep nginx
