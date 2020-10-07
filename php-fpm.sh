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
echo "$(tput setaf 1)selesai$(tput sgr 0)"
echo "=============================================================================================="
sleep 7