#============================================================================================================
echo "$(tput setaf 1)jangan jalankan script dengan sh dan ./ tapi buka file nya lalu ikuti tutorialnya$(tput sgr 0)"
echo "=============================================================================================="
sleep 100000000000000000
sleep 10000000000000000
sleep 10000000000000000



# create file mariadb.repo
touch /etc/yum.repos.d/mariadb.repo
===========================================================
# add repo to mariadb.repo
echo -e "\
[mariadb]\
name = MariaDB\
baseurl = http://yum.mariadb.org/10.1/centos7-amd64\
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB\
gpgcheck=1\
" >> /etc/yum.repos.d/mariadb.repo
===========================================================
# makecache repo mariadb
yum makecache --disablerepo='*' --enablerepo='mariadb'
===========================================================
#install mariadb and depedencies
yum install boost-devel.x86_64 socat MariaDB-server MariaDB-client MariaDB-compat galera socat jemalloc rsync galera -y
===========================================================
HANGE SYSTEMD MYSQL ALL SLAVE
Edit /usr/lib/systemd/system/mariadb.service
ProtectSystem=full
ProtectHome=true

and undefine those variables (setting it to false won't work)
ProtectSystem=
ProtectHome=
===========================================================
And reload daemon
systemctl daemon-reload
===========================================================

MYSQL CULSTER
Grant all on master with spesific ip on
User        : user
Password    : password

===========================================================

CREATE DIR DATA ON HOME ALL SLAVE

mkdir -p /home/mysql/data/
chown --reference=/var/lib/mysql /home/mysql/data/
chmod --reference=/var/lib/mysql /home/mysql/data/
===========================================================

MASTER CONFIG
[root@cms ~]# cat /etc/my.cnf.d/server.cnf
===========================================================

# this is read by the standalone daemon and embedded servers
[server]
===========================================================

#Server 1
# this is only for the mysqld standalone daemon
[mysqld]
log_error=/var/log/mariadb.log

[galera]
binlog_format=ROW
default-storage-engine=innodb
innodb_autoinc_lock_mode=2
bind-address=0.0.0.0
wsrep_on=ON
wsrep_provider=/usr/lib64/galera/libgalera_smm.so
wsrep_cluster_address="gcomm://IP address 1,IP address 2"

## Galera Cluster Configuration
wsrep_cluster_name="galera-cluster"
## Galera Synchronization Configuration
wsrep_sst_method=rsync
## Galera Node Configuration
wsrep_node_address="ip address 1"
wsrep_node_name="galera-master"
wsrep_sst_auth=password here
===========================================================

#Server 2
# this is only for embedded server
[embedded]

[mariadb]

[mariadb-10.1]

START MASTER FIRST
type ‘galera_new_cluster’

SLAVE CONFIG
[root@cms ~]# cat /etc/my.cnf.d/server.cnf
# this is read by the standalone daemon and embedded servers
[server]

# this is only for the mysqld standalone daemon
[mysqld]
log_error=/var/log/mariadb.log

[galera]
datadir=/home/mysql/data
binlog_format=ROW
default-storage-engine=innodb
innodb_autoinc_lock_mode=2
bind-address=0.0.0.0
wsrep_on=ON
wsrep_provider=/usr/lib64/galera/libgalera_smm.so
wsrep_cluster_address="gcomm://IP address 1,IP address 2"

## Galera Cluster Configuration
wsrep_cluster_name="galera-cluster"
## Galera Synchronization Configuration
wsrep_sst_method=rsync
## Galera Node Configuration
wsrep_node_address="IP address 2”
wsrep_node_name="galera-slave1”
wsrep_sst_auth=password here

===========================================================

# this is only for embedded server
[embedded]

[mariadb]

[mariadb-10.1]

START SLAVE
type service start mysql
===========================================================
