cp /etc/fdfs/client.conf.sample /etc/fdfs/client.conf
#vim /etc/fdfs/client.conf
IP_ADDRESS=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"`
sed -i '10s/\/home\/yuqing\/fastdfs/\/data\/fastdfs\/tracker/g' /etc/fdfs/client.conf
sed -i "14s/tracker_server=192.168.0.197:22122/tracker_server=$IP_ADDRESS:22122/g" /etc/fdfs/client.conf

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
sed -i "40s/tracker:22122/$IP_ADDRESS:22122/g" /etc/fdfs/mod_fastdfs.conf
sed -i '53s/false/true/g' /etc/fdfs/mod_fastdfs.conf
sed -i '62s/\/home\/yuqing\/fastdfs/\/data\/fastdfs\/storage/g' /etc/fdfs/mod_fastdfs.conf

cp /opt/fastdfs-5.11/conf/http.conf /etc/fdfs/
cp /opt/fastdfs-5.11/conf/mime.types /etc/fdfs/

ln -s /data/fastdfs/storage/data/ /data/fastdfs/storage/data/M00

#vim /usr/local/nginx/conf/nginx.conf
sed -i "36s/80/8888/g" /usr/local/nginx/conf/nginx.conf
sed -i "43s/\//~\/group([0-9])\/M00/g" /usr/local/nginx/conf/nginx.conf
sed -i "44s/root   html;/ngx_fastdfs_module;/g" /usr/local/nginx/conf/nginx.conf
sed -i "45d" /usr/local/nginx/conf/nginx.conf

/usr/local/nginx/sbin/nginx

firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --reload

firewall-cmd --zone=public --add-port=8888/tcp --permanent
firewall-cmd --reload
