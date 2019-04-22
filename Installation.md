Installation
------------

    yum install git -yum
    git config --global user.email "project.min@outlook.com"
    git config --global user.name "Ye Min"

    mkdir /home/deployment
    cd /home/deployment
    git init
    git remote add origin https://github.com/project-min/deployment.git
    git pull origin master
    chmod 777 *.sh
    ./centos.sh

Tracker Server:

    ./tracker_install.sh
    fdfs_trackerd /etc/fdfs/tracker.conf restart

Storage Server:

    ./storage_install.sh
    fdfs_storaged /etc/fdfs/storage.conf restart
    netstat -unltp | grep fdfs
    fdfs_monitor /etc/fdfs/storage.conf
    sed -i "118s/#tracker_server=39.98.214.72:22122/tracker_server=39.98.214.72:22122/g" /etc/fdfs/storage.conf
    sed -i "119s/tracker_server=192.168.31.88:22122/#tracker_server=192.168.31.88:22122/g" /etc/fdfs/storage.conf
    /usr/local/bin/stop.sh /opt/FastDFS/conf/storage.conf
    fdfs_storaged /etc/fdfs/storage.conf restart
    fdfs_monitor /etc/fdfs/storage.conf

Tracker Server:

    ./tracker_nginx_install.sh
    /usr/local/nginx/sbin/nginx

Storage Server:

    ./storage_nginx_install.sh
    /usr/local/nginx/sbin/nginx



    systemctl start kafka
    journalctl -u kafka

    cp /home/deployment/cluster-config/tracker/tracker.conf /etc/fdfs/
    cp /home/deployment/cluster-config/tracker/nginx.conf /usr/local/nginx/conf/

    cp /home/deployment/cluster-config/storage/storage.conf /etc/fdfs/
    cp /home/deployment/cluster-config/storage/nginx.conf /usr/local/nginx/conf/
    cp /home/deployment/cluster-config/storage/mod_fastdfs.conf /etc/fdfs/

    fdfs_trackerd /etc/fdfs/tracker.conf restart
    fdfs_storaged /etc/fdfs/storage.conf restart
    netstat -unltp | grep fdfs

    fdfs_monitor /etc/fdfs/storage.conf

    ln -s /data/fastdfs/storage/data/ /data/fastdfs/storage/data/M00

    /usr/bin/fdfs_test /etc/fdfs/client.conf upload ppp.txt

    firewall-cmd --list-ports


Reference
---------

Kafka
=====
https://www.digitalocean.com/community/tutorials/how-to-install-apache-kafka-on-centos-7
https://cloudwafer.com/blog/installing-apache-kafka-on-centos-7/

Fastdfs
=======

https://blog.51cto.com/quguoliang2017/2174524?source=dra
