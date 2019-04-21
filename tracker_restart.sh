#!/bin/bash

/usr/local/bin/stop.sh /etc/fdfs/tracker.conf
/usr/local/nginx/sbin/nginx -s stop

fdfs_trackerd /etc/fdfs/tracker.conf restart
/usr/local/nginx/sbin/nginx

netstat -unltp | grep fdfs
netstat -unltp | grep nginx