wget https://repo.mysql.com//mysql80-community-release-el7-1.noarch.rpm
rpm -Uvh mysql80-community-release-el7-1.noarch.rpm
yum install mysql-community-server -y
service mysqld start
service mysqld status

userid=`root`
temporary_password=`grep "temporary password" /var/log/mysqld.log`
password=${temporary_password##* }

mysql -u ${userid} -p${password} -e "set global validate_password.policy=0;"
mysql -u ${userid} -p${password} -e "set global validate_password.length=4;"
mysql -u ${userid} -p${password} -e "set password=\"${password}\";"

yum install mysqlclient
