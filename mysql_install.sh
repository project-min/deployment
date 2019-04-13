#!/bin/bash

wget https://repo.mysql.com//mysql80-community-release-el7-1.noarch.rpm
rpm -Uvh mysql80-community-release-el7-1.noarch.rpm
yum install mysql-community-server -y
service mysqld start
service mysqld status

userid='root'
temporary_password_string=`grep "temporary password" /var/log/mysqld.log`
temporary_password=${temporary_password_string##* }
if [ x"$1" = x ]; then
    password="test-123"
else
    password=$1
fi

echo $temporary_password
echo $password

mysql -u ${userid} -p${temporary_password} -e "set global validate_password.policy=0;"
mysql -u ${userid} -p${temporary_password} -e "set global validate_password.length=4;"
mysql -u ${userid} -p${temporary_password} -e "set password=\"${password}\";"

yum install mysqlclient
