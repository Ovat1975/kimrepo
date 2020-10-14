#=============================================================================================================
echo "$(tput setaf 1)add swap file & tuning kernel linux $(tput sgr 0)"
echo "$(tput setaf 1)pastikan Operating System Centos 7 $(tput sgr 0)"
echo "$(tput setaf 1)Pastikan Belum ada swap sebelummnya (check swap 'free -m') $(tput sgr 0)"
echo "$(tput setaf 1)Selalu Baca Dokumentasi Terlebih Dahulu $(tput sgr 0)"

echo "=============================================================================================="
sleep 7

#add swap file
dd if=/dev/zero of=/swapfile count=2096 bs=1MiB
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

#check swap on or off
swapon -s
free -m

#add auto start swap & tune swap
echo "/swapfile   swap    swap    sw  0   0" | sudo tee -a /etc/fstab
cat /proc/sys/vm/swappiness
sysctl vm.swappiness=10
echo "vm.swappiness = 10" | sudo tee -a /etc/sysctl.conf
cat /proc/sys/vm/vfs_cache_pressure
sysctl vm.vfs_cache_pressure=50
echo "vm.vfs_cache_pressure = 50" | sudo tee -a /etc/sysctl.conf
echo "done" 



# Set Kernel
echo -e "\
net.core.somaxconn = 65535 \n\
net.core.netdev_max_backlog = 262144 \n\
net.core.optmem_max = 25165824 \n\
net.core.rmem_default = 31457280 \n\
net.core.rmem_max = 67108864 \n\
net.core.wmem_default = 31457280 \n\
net.core.wmen_max = 67108864\
" >> /etc/sysctl.conf
