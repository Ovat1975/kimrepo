#TAMBAHKAN BARI DI BAWAH KE /etc/sysctl.conf

fs.inotify.max_user_watches=1048576

#reload sysctl
sysctl -p
