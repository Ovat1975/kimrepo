echo "$(tput setaf 1)disable selinux & firewalld$(tput sgr 0)"
sleep 7
# disable selinux & firewalld
systemctl stop firewalld
sleep 2
systemctl disable firewalld
sleep 2
setenforce 0
sestatus 
sleep 3

echo "$(tput setaf 1)install requirment centos 7$(tput sgr 0)"
sleep 7
# install requirment centos 7
cd ~/
yum install epel-release -y
sleep 2
yum update -y
sleep 2
yum install -y nano zip unzip curl screen wget yum-utils gcc git net-tools
sleep 2
yum groupinstall -y 'Development Tools' && sleep 2 && sudo yum install -y vim
yum install -y perl perl-devel perl-ExtUtils-Embed libxslt libxslt-devel libxml2 libxml2-devel gd gd-devel GeoIP GeoIP-devel

echo "$(tput setaf 1)mod kernel$(tput sgr 0)"
sleep 7
# mod kernel
cd /opt/kimrepo/asset/
mv /etc/sysctl.conf /etc/sysctl.conf.bak
cp /opt/kimrepo/asset/sysctl.conf /etc/sysctl.conf

echo "$(tput setaf 1)disable selinux permanent$(tput sgr 0)"
sleep 7
# disable selinux
mv /etc/selinux/config /etc/selinux/config.bak
cp /opt/kimrepo/asset/config /etc/selinux/config


echo "$(tput setaf 1)install dan setting dependencies selesai$(tput sgr 0)"
sleep 15
