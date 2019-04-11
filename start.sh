service fdfs_trackerd start
service fdfs_storaged start

/usr/local/nginx/sbin/nginx

netstat -unltp|grep fdfs
