#!/bin/bash

fdfs_trackerd /etc/fdfs/tracker.conf restart
/usr/local/nginx/sbin/nginx

netstat -unltp | grep fdfs
netstat -unltp | grep nginx

