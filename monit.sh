Use monit which purpose is to take care of situations like this.

#to install ubuntu based
apt install monit

#to install centos based
yum install monit

#create config file
nano /etc/monit/conf.d/nginx.conf

Sample Auto start nginx if get stopped
#Put content below inside this file and restart monit

check process nginx with pidfile /var/run/nginx.pid
start program = "/usr/sbin/service nginx start"
stop program = "/usr/sbin/service nginx stop"

you can modified interval check in file /etc/monit/monitrc

# exsample
i set : set daemon 120 << this running check every 2 minute intervals
# time based on second

log location is : /var/log/monit.log
