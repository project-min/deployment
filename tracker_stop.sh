#!/bin/bash

/usr/local/bin/stop.sh /etc/fdfs/tracker.conf
/usr/local/nginx/sbin/nginx -s stop
