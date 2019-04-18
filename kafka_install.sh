if [ ! -f "/opt/kafka_2.12-2.2.0.tgz" ]; then
  wget -P /opt http://mirror.bit.edu.cn/apache/kafka/2.2.0/kafka_2.12-2.2.0.tgz
  tar -zxvf /opt/kafka_2.12-2.2.0.tgz -C /opt
  rm -rf /opt/kafka
  mv /opt/kafka_2.12-2.2.0 /opt/kafka
  cd /
fi

sed -i '$a delete.topic.enable=true' /opt/kafka/config/server.properties

cp /home/deployment/zookeeper.service /etc/systemd/system/
cp /home/deployment/kafka.service /etc/systemd/system/

chmod 666 /etc/systemd/system/kafka.service 
chmod 666 /etc/systemd/system/zookeeper.service
