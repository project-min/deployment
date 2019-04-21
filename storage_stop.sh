#!/bin/bash

/usr/local/bin/stop.sh /etc/fdfs/storage.conf
/usr/local/nginx/sbin/nginx -s stop
