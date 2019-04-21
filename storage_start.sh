#!/bin/bash

fdfs_storaged /etc/fdfs/storage.conf restart
/usr/local/nginx/sbin/nginx

netstat -unltp | grep fdfs
netstat -unltp | grep nginx

