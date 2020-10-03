#!/bin/bash

#open message
echo "untuk menghindari terjadinya error pastikan OS dalam keadaan fresh install"
echo "Pastikan OS anda adalah Centos 7"
sleep 7

echo "disable selinux & firewalld"
# disable selinux & firewalld
systemctl stop firewalld
sleep 2
systemctl disable firewalld
sleep 2
setenforce 0
sestatus 
sleep 3

echo "install requirment centos 7"
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

echo "mod kernel"
# mod kernel
cd /opt/kimrepo/asset/
mv /etc/sysctl.conf /etc/sysctl.conf.bak
cp /opt/kimrepo/asset/sysctl.conf /etc/sysctl.conf

echo "disable selinux permanent"
# disable selinux
mv /etc/selinux/config /etc/selinux/config.bak
cp /opt/kimrepo/asset/config /etc/selinux/config
#=============================================================================

echo "Memulai instalasi nginx"
sleep 5
# install nginx
cd ~/

echo "Get file nginx-1.13.2 "
# nginx 1.13.2
sleep 2
wget https://nginx.org/download/nginx-1.13.2.tar.gz && tar zxvf nginx-1.13.2.tar.gz

echo "get PCRE"
# PCRE version 8.40
sleep 2
wget https://ftp.pcre.org/pub/pcre/pcre-8.40.tar.gz && tar xzvf pcre-8.40.tar.gz

echo "Get zlib"
# zlib version 1.2.11
sleep 2
wget https://www.zlib.net/zlib-1.2.11.tar.gz && tar xzvf zlib-1.2.11.tar.gz

echo "Get OpenSSL"
# OpenSSL version 1.1.0f
sleep 2
wget https://www.openssl.org/source/openssl-1.1.0f.tar.gz && tar xzvf openssl-1.1.0f.tar.gz

echo "menghapus file tar.gz"
# remove file tar.zg
rm -rf *.tar.gz

echo "menambah man nginx"
# copu man nginx
cp ~/nginx-1.13.2/man/nginx.8 /usr/share/man/man8
gzip /usr/share/man/man8/nginx.8

echo "configure nginx"
# Configure nginx
sleep 2
cd nginx-1.13.2/
./configure --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib64/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --user=nginx --group=nginx --build=CentOS --builddir=nginx-1.13.2 --with-select_module --with-poll_module --with-threads --with-file-aio --with-http_ssl_module --with-http_v2_module --with-http_realip_module --with-http_addition_module --with-http_xslt_module=dynamic --with-http_image_filter_module=dynamic --with-http_geoip_module=dynamic --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_auth_request_module --with-http_random_index_module --with-http_secure_link_module --with-http_degradation_module --with-http_slice_module --with-http_stub_status_module --http-log-path=/var/log/nginx/access.log --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --with-mail=dynamic --with-mail_ssl_module --with-stream=dynamic --with-stream_ssl_module --with-stream_realip_module --with-stream_geoip_module=dynamic --with-stream_ssl_preread_module --with-compat --with-pcre=../pcre-8.40 --with-pcre-jit --with-zlib=../zlib-1.2.11 --with-openssl=../openssl-1.1.0f --with-openssl-opt=no-nextprotoneg --with-http_perl_module --with-debug --with-http_image_filter_module

echo "make nginx"
# make nginx
sleep 2
make

echo "make install nginx"
# make install
sleep 2
make install

echo "add symlink nginx module"
# symlink module nginx
ln -s /usr/lib64/nginx/modules /etc/nginx/modules

echo "add user nginx"
# add user nginx 
useradd --system --home /var/cache/nginx --shell /sbin/nologin --comment "nginx user" --user-group nginx

echo "add folder cache nginx"
# add folder cache nginx
mkdir -p /var/cache/nginx && sudo nginx -t

echo "add nginx.service"
# add nginx.service
cp /opt/kimrepo/asset/nginx.service /usr/lib/systemd/system/nginx.service

echo "starting nginx"
# start & add auto start nginx service
systemctl start nginx.service && systemctl enable nginx.service

# check nginx service
systemctl status nginx.service
sleep 2
ps aux | grep nginx
sleep 2
curl -I 127.0.0.1


#============================================================================================================
echo "install mariadb 10.1"
# add repo mariadb
cd ~/
cp /opt/kimrepo/asset/MariaDB.repo /etc/yum.repos.d/MariaDB.repo

#install mariadb 10.1
yum install boost-devel.x86_64 socat MariaDB-server MariaDB-client MariaDB-compat galera socat jemalloc rsync galera -y
sleep 2

# start & auto start mariadb
systemctl start mariadb && systemctl enable mariadb

#=============================================================================================================
echo "install php-fpm 7.2"
# add remo repo php
sleep 2
cd ~/
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
sleep 2

# enable remi repo php 7.2
yum-config-manager --enable remi-php72

# install all php requirment
yum -y install php php-fpm php-gd php-json php-mbstring php-mysqlnd php-xml php-xmlrpc php-opcache
sleep 2

# start & auto start php-fpm
systemctl start php-fpm && systemctl enable php-fpm

# add permission user to session
chown nginx.nginx -R /var/lib/php/session

echo "add nginx config ke php-fpm www.conf"
# add php-fpm config
mv /etc/php-fpm.d/www.conf /etc/php-fpm.d/www.conf.bak
cp /opt/kimrepo/asset/www.conf /etc/php-fpm.d/www.conf


#==============================================================================================================

echo "install nodeJS 11"
# Install NodeJS 11
cd ~/
curl -sL https://rpm.nodesource.com/setup_11.x | bash -
sleep 2
yum install -y nodejs
#check version nodejs
node -v

echo "install npm"
# Install npm
sleep 2
yum install -y npm
#check version npm
npm -v

echo "install yarn"
# Install Yarn
curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg
yum install yarn -y
sleep 2
#check version yarn -v

echo "install composer"
# install composer
curl -sS https://getcomposer.org/installer | php
sleep 2
mv composer.phar /usr/local/bin/composer

echo "check composer version" 
#check version composer
composer
sleep 2
#=========================================================================================================
##DONE##

echo "instalasi telah selesai"
echo "pastikan semua servie berjalan dengan baik"
echo "check port yang berjalan netstat -ntlp"

echo "jangan ngeluh kalo ada error, usaha usaha cok"
echo "benerin dewek"

echo "========================================================="
echo "Gaang"
