#!/bin/bash

wget https://repo.mysql.com//mysql80-community-release-el7-1.noarch.rpm
rpm -Uvh mysql80-community-release-el7-1.noarch.rpm
yum install mysql-community-server -y
service mysqld start
service mysqld status

userid='root'
temporary_password_string=`grep "temporary password" /var/log/mysqld.log`
temporary_password=${temporary_password_string##* }
#if [ x"$1" = x ]; then
#    password="test-123"
#else
#    password=$1
#fi

echo $temporary_password
#echo $password


yum install mysqlclient
