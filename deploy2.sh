cp /etc/fdfs/client.conf.sample /etc/fdfs/client.conf
#vim client.conf
#base_path=/data/fastdfs/tracker
#tracker_server=$IP_ADDRESS:22122


#cd /usr/local/src
#vim ppp.txt
#/usr/bin/fdfs_upload_file /etc/fdfs/client.conf /usr/local/src/ppp.txt

wget -P /opt -c https://nginx.org/download/nginx-1.14.1.tar.gz
wget -P /opt https://github.com/happyfish100/fastdfs-nginx-module/archive/master.zip

unzip /opt/master.zip -d /opt
tar xvf /opt/nginx-1.14.1.tar.gz -C /opt
sed -i '6s/\/usr\/local\/include/\/usr\/include\/fastdfs \/usr\/include\/fastcommon\//g' /opt/fastdfs-nginx-module-master/src/config
sed -i '15s/\/usr\/local\/include/\/usr\/include\/fastdfs \/usr\/include\/fastcommon\//g' /opt/fastdfs-nginx-module-master/src/config


cd /opt/nginx-1.14.1
./configure --add-module=/opt/fastdfs-nginx-module-master/src
make
make install

cp /opt/fastdfs-nginx-module-master/src/mod_fastdfs.conf /etc/fdfs
#vim /etc/fdfs/mod_fastdfs.conf
#tracker_server=ip01:22122
#storage_server_port=23000
#group_name=group1
#url_have_group_name = true
#store_path0=/fastdfs/storage

cp /opt/fastdfs-5.11/conf/http.conf /etc/fdfs/
cp /opt/fastdfs-5.11/conf/mime.types /etc/fdfs/

ln -s /data/fastdfs/storage/data/ /data/fastdfs/storage/data/M00

#vim /usr/local/nginx/conf/nginx.conf
#listen 8888;
#location ~/group([0-9])/M00 {
#
#    ngx_fastdfs_module;
#
#}

/usr/local/nginx/sbin/nginx

firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --reload

firewall-cmd --zone=public --add-port=8888/tcp --permanent
firewall-cmd --reload
