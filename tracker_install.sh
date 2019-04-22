#!/bin/bash

#IP_ADDRESS=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"`

### Create fastdfs folder
if [ ! -d "/data" ]; then
  mkdir /data
fi

if [ ! -d "/data/fastdfs" ]; then
  mkdir /data/fastdfs
fi

if [ ! -d "/data/fastdfs/tracker" ]; then
  mkdir /data/fastdfs/tracker
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

# Install fastdfs-5.11
if [ ! -d "/opt/fastdfs-5.11" ]; then
  wget -P /opt https://github.com/happyfish100/fastdfs/archive/V5.11.tar.gz
  tar -zxvf /opt/V5.11.tar.gz -C /opt
  cd /opt/fastdfs-5.11
  /opt/fastdfs-5.11/make.sh
  /opt/fastdfs-5.11/make.sh install
  cd /
fi

### Update tracker.conf
#if [ ! -f "/etc/fdfs/tracker.conf" ]; then
#  cp /etc/fdfs/tracker.conf.sample /etc/fdfs/tracker.conf
#
#  sed -i '22s/\/home\/yuqing\/fastdfs/\/data\/fastdfs\/tracker/g' /etc/fdfs/tracker.conf
#  sed -i '260s/http.server_port=8080/http.server_port=9090/g' /etc/fdfs/tracker.conf
#fi

ln -s /usr/bin/fdfs_trackerd /usr/local/bin
ln -s /usr/bin/stop.sh /usr/local/bin
ln -s /usr/bin/restart.sh /usr/local/bin

#service fdfs_trackerd start
#service fdfs_storaged start

#if [ ! -d "/opt/nginx-1.14.1" ]; then
#  wget -P /opt -c https://nginx.org/download/nginx-1.14.1.tar.gz
#  tar xvf /opt/nginx-1.14.1.tar.gz -C /opt
#  cd /opt/nginx-1.14.1
#  ./configure #--add-module=/opt/fastdfs-nginx-module-master/src
#  make
#  make install

  ###vim /usr/local/nginx/conf/nginx.conf
  #sed -i "36s/80/8888/g" /usr/local/nginx/conf/nginx.conf
  #sed -i "43s/\//~\/group([0-9])\/M00/g" /usr/local/nginx/conf/nginx.conf
  #sed -i "44s/root   html;/ngx_fastdfs_module;/g" /usr/local/nginx/conf/nginx.conf
  #sed -i "45d " /usr/local/nginx/conf/nginx.conf
#fi

cp /home/deployment/cluster-config/tracker/tracker.conf /etc/fdfs/
#cp /home/deployment/cluster-config/tracker/nginx.conf /usr/local/nginx/conf/

systemctl start firewalld

firewall-cmd --zone=public --add-port=9090/tcp --permanent
#firewall-cmd --zone=public --add-port=8080/tcp --permanent
firewall-cmd --zone=public --add-port=22122/tcp --permanent

firewall-cmd --reload

fdfs_trackerd /etc/fdfs/tracker.conf restart
#/usr/local/nginx/sbin/nginx

netstat -unltp | grep fdfs
#netstat -unltp | grep nginx
