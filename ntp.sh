# untuk install ntp
yum install ntp


#tambahkan server time ke /etc/ntp.conf lalu beri tag server default nya
server 0.id.pool.ntp.org iburst
server 1.id.pool.ntp.org iburst
server 2.id.pool.ntp.org iburst
server 3.id.pool.ntp.org iburst


#start ntp
systemctl start ntpd


#update time by server
ntpq -p 
