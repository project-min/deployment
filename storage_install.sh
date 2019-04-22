#!/bin/bash

#IP_ADDRESS=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"`

### Create fastdfs folder
if [ ! -d "/data" ]; then
  mkdir /data
fi

if [ ! -d "/data/fastdfs" ]; then
  mkdir /data/fastdfs
fi

if [ ! -d "/data/fastdfs/storage" ]; then
  mkdir /data/fastdfs/storage
fi

### Install libfastcommon-1.0.39
if [ ! -d "/opt/libfastcommon-1.0.39/" ]; then
  wget -P /opt https://github.com/happyfish100/libfastcommon/archive/V1.0.39.tar.gz
  tar -zxvf /opt/V1.0.39.tar.gz -C /opt
  cd /opt/libfastcommon-1.0.39
  /opt/libfastcommon-1.0.39/make.sh
  /opt/libfastcommon-1.0.39/make.sh install
  cd /
fi

### Install fastdfs-5.11
if [ ! -d "/opt/fastdfs-5.11" ]; then
  wget -P /opt https://github.com/happyfish100/fastdfs/archive/V5.11.tar.gz
  tar -zxvf /opt/V5.11.tar.gz -C /opt
  cd /opt/fastdfs-5.11
  /opt/fastdfs-5.11/make.sh
  /opt/fastdfs-5.11/make.sh install
  cd /
fi

### Update storage.conf
#if [ ! -f "/etc/fdfs/storage.conf" ]; then
#  cp /etc/fdfs/storage.conf.sample /etc/fdfs/storage.conf
  ### vim storage.conf
#  sed -i '41s/base_path=\/home\/yuqing\/fastdfs/base_path=\/data\/fastdfs\/storage/g' /etc/fdfs/storage.conf
#  sed -i '109s/store_path0=\/home\/yuqing\/fastdfs/store_path0=\/data\/fastdfs\/storage/g' /etc/fdfs/storage.conf
#  sed -i '118d' /etc/fdfs/storage.conf
#  sed -i "118i tracker_server=$IP_ADDRESS:22122" /etc/fdfs/storage.conf
#fi

#ln -s /usr/bin/fdfs_trackerd /usr/local/bin
ln -s /usr/bin/stop.sh /usr/local/bin
ln -s /usr/bin/restart.sh /usr/local/bin
ln -s /usr/bin/fdfs_storaged /usr/local/bin

### Update client.conf
#if [ ! -f "/etc/fdfs/client.conf" ]; then
#  cp /etc/fdfs/client.conf.sample /etc/fdfs/client.conf
  ###vim /etc/fdfs/client.conf
#  sed -i '10s/\/home\/yuqing\/fastdfs/\/data\/fastdfs\/tracker/g' /etc/fdfs/client.conf
#  sed -i '14d' /etc/fdfs/client.conf
#  sed -i "14i tracker_server=$IP_ADDRESS:22122" /etc/fdfs/client.conf
#fi

#service fdfs_trackerd start
#service fdfs_storaged start

### Install nginx
#if [ ! -d "/opt/fastdfs-nginx-module-master" ]; then
#  wget -P /opt https://github.com/happyfish100/fastdfs-nginx-module/archive/master.zip
#  unzip /opt/master.zip -d /opt
#  sed -i '6s/\/usr\/local\/include/\/usr\/include\/fastdfs \/usr\/include\/fastcommon\//g' /opt/fastdfs-nginx-module-master/src/config
#  sed -i '15s/\/usr\/local\/include/\/usr\/include\/fastdfs \/usr\/include\/fastcommon\//g' /opt/fastdfs-nginx-module-master/src/config

  #cp /opt/fastdfs-nginx-module-master/src/mod_fastdfs.conf /etc/fdfs
  ###vim /etc/fdfs/mod_fastdfs.conf
  #sed -i "10s/\/tmp/\/data\/fastdfs\/storage/g" /etc/fdfs/mod_fastdfs.conf
  #sed -i "40s/tracker:22122/$IP_ADDRESS:22122/g" /etc/fdfs/mod_fastdfs.conf
  #sed -i '53s/false/true/g' /etc/fdfs/mod_fastdfs.conf
  #sed -i '62s/\/home\/yuqing\/fastdfs/\/data\/fastdfs\/storage/g' /etc/fdfs/mod_fastdfs.conf
#fi

#if [ ! -d "/opt/nginx-1.14.1" ]; then
#  wget -P /opt -c https://nginx.org/download/nginx-1.14.1.tar.gz
#  tar xvf /opt/nginx-1.14.1.tar.gz -C /opt
#  cd /opt/nginx-1.14.1
#  ./configure --add-module=/opt/fastdfs-nginx-module-master/src
#  make
#  make install

  ###vim /usr/local/nginx/conf/nginx.conf
  #sed -i "36s/80/8888/g" /usr/local/nginx/conf/nginx.conf
  #sed -i "43s/\//~\/group([0-9])\/M00/g" /usr/local/nginx/conf/nginx.conf
  #sed -i "44s/root   html;/ngx_fastdfs_module;/g" /usr/local/nginx/conf/nginx.conf
  #sed -i "45d " /usr/local/nginx/conf/nginx.conf
#fi

cp /home/deployment/cluster-config/storage/storage.conf /etc/fdfs/
#cp /home/deployment/cluster-config/storage/nginx.conf /usr/local/nginx/conf/
#cp /home/deployment/cluster-config/storage/mod_fastdfs.conf /etc/fdfs/


#if [ ! -f "/etc/fdfs/http.conf" ]; then
#  cp /opt/fastdfs-5.11/conf/http.conf /etc/fdfs/
#fi

#if [ ! -f "/etc/fdfs/mime.types" ]; then
#  cp /opt/fastdfs-5.11/conf/mime.types /etc/fdfs/
#fi

systemctl start firewalld

firewall-cmd --zone=public --add-port=8080/tcp --permanent
firewall-cmd --zone=public --add-port=23000/tcp --permanent

firewall-cmd --reload

#fdfs_storaged /etc/fdfs/storage.conf restart
#/usr/local/nginx/sbin/nginx

#ln -s /data/fastdfs/storage/data/ /data/fastdfs/storage/data/M00

#netstat -unltp | grep fdfs
#netstat -unltp | grep nginx
