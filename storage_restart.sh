#!/bin/bash

/usr/local/bin/stop.sh /etc/fdfs/storage.conf
/usr/local/nginx/sbin/nginx -s stop

fdfs_storaged /etc/fdfs/storage.conf restart
/usr/local/nginx/sbin/nginx

netstat -unltp | grep fdfs
netstat -unltp | grep nginx