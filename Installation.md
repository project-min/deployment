Installation
------------

    yum install git -y
    git config --global user.email "project.min@outlook.com"
    git config --global user.name "Ye Min"
    
    mkdir /home/deployment
    cd /home/deployment
    git init
    git remote add origin https://github.com/project-min/deployment.git
    git pull origin master
    <shadow></shadow>
    ./centos.sh
    ./deploy.sh

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


Reference
---------

Kafka
=====
https://www.digitalocean.com/community/tutorials/how-to-install-apache-kafka-on-centos-7
https://cloudwafer.com/blog/installing-apache-kafka-on-centos-7/