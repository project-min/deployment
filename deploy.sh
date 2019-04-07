#!/bin/bash
# Install package
yum update -y
yum upgrade -y
yum install vim -y
yum install wget -y
yum install net-tools -y
yum install lsof -y
yum install git -y
yum install gcc* -y
yum install make* -y
yum install libevent -y

# Download
wget -P /opt https://github.com/happyfish100/libfastcommon/archive/V1.0.39.tar.gz
tar -zxvf /opt/V1.0.39.tar.gz -C /opt
cd /opt/libfastcommon-1.0.39
/opt/libfastcommon-1.0.39/make.sh
/opt/libfastcommon-1.0.39/make.sh install
cd /

wget -P /opt https://github.com/happyfish100/fastdfs/archive/V5.11.tar.gz
tar -zxvf V5.11.tar.gz -C /opt
cd /opt/fastdfs-5.11
/opt/fastdfs-5.11/make.sh
/opt/fastdfs-5.11/make.sh install
cd /

cp /etc/fdfs/tracker.conf.sample /etc/fdfs/tracker.conf

#vim tracker.conf
sed -i '' '22s/\/home\/yuqing\/fastdfs/\/data\/fastdfs/g' /etc/fdfs/tracker.conf
sed -i '' '260s/http.server_port=8080/http.server_port=80/g' /etc/fdfs/tracker.conf
ln -s /usr/bin/fdfs_trackerd /usr/local/bin
ln -s /usr/bin/stop.sh /usr/local/bin
ln -s /usr/bin/restart.sh /usr/local/bin

mkdir /data
mkdir /data/fastdfs
mkdir /data/fastdfs/storage

service fdfs_trackerd start
netstat -unltp|grep fdfs

cp /etc/fdfs/storage.conf.sample /etc/fdfs/storage.conf

#vim storage.conf
IP_ADDRESS=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"`
sed -i '' '41s/base_path=\/home\/yuqing\/fastdfs/base_path=\/data\/fastdfs\/storage/g' /etc/fdfs/storage.conf
sed -i '' '109s/store_path0=\/home\/yuqing\/fastdfs/store_path0=\/data\/fastdfs\/storage/g' /etc/fdfs/storage.conf
sed -i '' '118s/tracker_server=192.168.209.121:22122/tracker_server=$IP_ADDRESS:22122/g' /etc/fdfs/storage.conf
ln -s /usr/bin/fdfs_storaged /usr/local/bin

service fdfs_trackerd start
service fdfs_storaged start
netstat -unltp|grep fdfs


# MacOS
#sed -i '' '22s/\/home\/yuqing\/fastdfs/\/data\/fastdfs/g' tracker.conf 
# Linux
#sed -i s/\/home\/yuqing\/fastdfs/\/data\/fastdfs/g' tracker.conf 

