#!/bin/bash

#open message
echo "$(tput setaf 1)untuk menghindari terjadinya error pastikan OS dalam keadaan fresh install$(tput sgr 0)$(tput sgr 0)"
echo "$(tput setaf 1)Jalankan script ini dengan user root$(tput sgr 0)$(tput sgr 0)"
echo "$(tput setaf 1)Pastikan OS anda adalah Centos 7$(tput sgr 0)"
echo "$(tput setaf 1)Untuk Membatalkan (CTRL + C ) $(tput sgr 0)"
sleep 20

echo "$(tput setaf 1)disable selinux & firewalld$(tput sgr 0)"
echo "=============================================================================================="
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
echo "=============================================================================================="
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
echo "=============================================================================================="
sleep 7

# mod kernel
cd /opt/kimrepo/asset/
mv /etc/sysctl.conf /etc/sysctl.conf.bak
cp /opt/kimrepo/asset/sysctl.conf /etc/sysctl.conf

echo "$(tput setaf 1)disable selinux permanent$(tput sgr 0)"
echo "=============================================================================================="
sleep 7

# disable selinux
mv /etc/selinux/config /etc/selinux/config.bak
cp /opt/kimrepo/asset/config /etc/selinux/config
#=============================================================================

echo "$(tput setaf 1)Memulai instalasi nginx$(tput sgr 0)"
echo "=============================================================================================="
sleep 7

# install nginx
cd ~/

echo "$(tput setaf 1)Get file nginx-1.13.2$(tput sgr 0)"
echo "=============================================================================================="
sleep 7

# nginx 1.13.2
sleep 2
wget https://nginx.org/download/nginx-1.13.2.tar.gz && tar zxvf nginx-1.13.2.tar.gz

echo "$(tput setaf 1)get PCRE$(tput sgr 0)"
echo "=============================================================================================="
sleep 7

# PCRE version 8.40
sleep 2
wget https://ftp.pcre.org/pub/pcre/pcre-8.40.tar.gz && tar xzvf pcre-8.40.tar.gz

echo "$(tput setaf 1)Get zlib$(tput sgr 0)"
echo "=============================================================================================="
sleep 7

# zlib version 1.2.11
sleep 2
wget https://www.zlib.net/zlib-1.2.11.tar.gz && tar xzvf zlib-1.2.11.tar.gz

echo "$(tput setaf 1)Get OpenSSL$(tput sgr 0)"
echo "=============================================================================================="
sleep 7

# OpenSSL version 1.1.0f
sleep 2
wget https://www.openssl.org/source/openssl-1.1.0f.tar.gz && tar xzvf openssl-1.1.0f.tar.gz

echo "$(tput setaf 1)menghapus file tar.gz$(tput sgr 0)"
echo "=============================================================================================="
sleep 7

# remove file tar.zg
rm -rf *.tar.gz

echo "$(tput setaf 1)menambah man nginx$(tput sgr 0)"
echo "=============================================================================================="
sleep 7

# copu man nginx
cp ~/nginx-1.13.2/man/nginx.8 /usr/share/man/man8
gzip /usr/share/man/man8/nginx.8

echo "$(tput setaf 1)configure nginx$(tput sgr 0)"
echo "=============================================================================================="
sleep 7

# Configure nginx
sleep 2
cd nginx-1.13.2/
./configure --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib64/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --user=nginx --group=nginx --build=CentOS --builddir=nginx-1.13.2 --with-select_module --with-poll_module --with-threads --with-file-aio --with-http_ssl_module --with-http_v2_module --with-http_realip_module --with-http_addition_module --with-http_xslt_module=dynamic --with-http_image_filter_module=dynamic --with-http_geoip_module=dynamic --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_auth_request_module --with-http_random_index_module --with-http_secure_link_module --with-http_degradation_module --with-http_slice_module --with-http_stub_status_module --http-log-path=/var/log/nginx/access.log --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --with-mail=dynamic --with-mail_ssl_module --with-stream=dynamic --with-stream_ssl_module --with-stream_realip_module --with-stream_geoip_module=dynamic --with-stream_ssl_preread_module --with-compat --with-pcre=../pcre-8.40 --with-pcre-jit --with-zlib=../zlib-1.2.11 --with-openssl=../openssl-1.1.0f --with-openssl-opt=no-nextprotoneg --with-http_perl_module --with-debug --with-http_image_filter_module

echo "$(tput setaf 1)make nginx$(tput sgr 0)"
echo "=============================================================================================="
sleep 7

# make nginx
sleep 2
make

echo "$(tput setaf 1)make install nginx$(tput sgr 0)"
echo "=============================================================================================="
sleep 7

# make install
sleep 2
make install

echo "$(tput setaf 1)add symlink nginx module$(tput sgr 0)"
echo "=============================================================================================="
sleep 7

# symlink module nginx
ln -s /usr/lib64/nginx/modules /etc/nginx/modules

echo "$(tput setaf 1)add user nginx$(tput sgr 0)"
echo "=============================================================================================="
sleep 7

# add user nginx 
useradd --system --home /var/cache/nginx --shell /sbin/nologin --comment "nginx user" --user-group nginx

echo "$(tput setaf 1)add folder cache nginx$(tput sgr 0)"
echo "=============================================================================================="
sleep 7

# add folder cache nginx
mkdir -p /var/cache/nginx && sudo nginx -t

echo "$(tput setaf 1)add nginx.service$(tput sgr 0)"
echo "=============================================================================================="
sleep 7

# add nginx.service
cp /opt/kimrepo/asset/nginx.service /usr/lib/systemd/system/nginx.service

echo "$(tput setaf 1)starting nginx$(tput sgr 0)"
echo "=============================================================================================="
sleep 7

# start & add auto start nginx service
systemctl start nginx.service && systemctl enable nginx.service

# check nginx service
systemctl status nginx.service
sleep 2
ps aux | grep nginx
sleep 2
curl -I 127.0.0.1


#============================================================================================================
echo "$(tput setaf 1)install mariadb 10.1$(tput sgr 0)"
echo "=============================================================================================="
sleep 7

# add repo mariadb
cd ~/
cp /opt/kimrepo/asset/MariaDB.repo /etc/yum.repos.d/MariaDB.repo

#install mariadb 10.1
yum install boost-devel.x86_64 socat MariaDB-server MariaDB-client MariaDB-compat galera socat jemalloc rsync galera -y
sleep 2

# start & auto start mariadb
systemctl start mariadb && systemctl enable mariadb

#=============================================================================================================
echo "$(tput setaf 1)install php-fpm 7.2$(tput sgr 0)"
echo "=============================================================================================="
sleep 7

# add remi-php 7.2 repo
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

echo "$(tput setaf 1)add nginx user ke php-fpm www.conf$(tput sgr 0)"
echo "=============================================================================================="
sleep 7

# add php-fpm config
mv /etc/php-fpm.d/www.conf /etc/php-fpm.d/www.conf.bak
cp /opt/kimrepo/asset/www.conf /etc/php-fpm.d/www.conf


#==============================================================================================================

echo "$(tput setaf 1)install nodeJS 11$(tput sgr 0)"
echo "=============================================================================================="
sleep 7

# Install NodeJS 11
cd ~/
curl -sL https://rpm.nodesource.com/setup_11.x | bash -
sleep 2
yum install -y nodejs
#check version nodejs
node -v

echo "$(tput setaf 1)install npm$(tput sgr 0)"
echo "=============================================================================================="
sleep 7

# Install npm
sleep 2
yum install -y npm
#check version npm
npm -v

echo "$(tput setaf 1)install yarn$(tput sgr 0)"
echo "=============================================================================================="
sleep 7

# Install Yarn
curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg
yum install yarn -y
sleep 2
#check version yarn -v

echo "$(tput setaf 1)install composer$(tput sgr 0)"
echo "=============================================================================================="
sleep 7

# install composer
curl -sS https://getcomposer.org/installer | php
sleep 2
mv composer.phar /usr/local/bin/composer

echo "$(tput setaf 1)check composer version$(tput sgr 0)"
echo "=============================================================================================="
sleep 7

#check version composer
composer
sleep 2
#=========================================================================================================
##DONE##

echo "$(tput setaf 1)instalasi telah selesai$(tput sgr 0)"
echo "$(tput setaf 1)pastikan semua servie berjalan dengan baik$(tput sgr 0)"
echo "$(tput setaf 1)check port yang berjalan netstat -ntlp$(tput sgr 0)"

echo "$(tput setaf 1)lapor jika ada error$(tput sgr 0)"
echo "$(tput setaf 1)Thanks for using This Script$(tput sgr 0)"

echo "=============================================================================================="
echo "$(tput setaf 1)Gaang$(tput sgr 0)"
echo "=============================================================================================="
sleep 7
