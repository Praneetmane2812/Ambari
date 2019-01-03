#/usr/bin/env bash
sudo yum install -y wget
#set password less ssh
if [ ! -f ~/.ssh/id_rsa.pub ]; then
   ssh-keygen  -f ~/.ssh/id_rsa -q -N ""
fi
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys;chmod 700 ~/.ssh;chmod 600 ~/.ssh/authorized_keys
#enable ntp
sudo yum install -y ntp;sudo systemctl enable ntpd
#stop firewall
sudo systemctl disable firewalld;sudo service firewalld stop

#download repo
sudo wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.6.1.5/ambari.repo -O /etc/yum.repos.d/ambari.repo
#sudo wget https://s3-us-west-2.amazonaws.com/ampool-adm/adm.repo -O 
/etc/yum.repos.d/adm.repo
sudo yum install -y ambari-server
sudo ambari-server setup -s
sudo ambari-server start -s


#install mysql
sudo wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
sudo rpm -ivh mysql-community-release-el7-5.noarch.rpm
sudo yum update -y
sudo yum install -y mysql-server
sudo systemctl start mysqld

#install mysql connector jar
sudo yum install -y mysql-connector-java*
sudo ln -s /usr/share/java/mysql-connector-java.jar 
sudo ln -s /var/lib/ambari-server/resources/mysql-connector-java.jar

#Changes to be done
#sudo ambari-server stop
#sudo vi /etc/ambari-agent/conf/ambari-agent.ini
#force_https_protocol=PROTOCOL_TLSv1_2
#vi /etc/python/cert-verification.cfg
#[https] 
#verify=disable
#sudo ambari-server start
