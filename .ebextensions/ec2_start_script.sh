#! /bin/bash

echo "running start script..."
echo "running start script..." > tmp.txt
#install git
#yum -y install git

# Turn it on
swapon -s

# Create a swap file
# 512k --> Swapfile of 1024 MB
dd if=/dev/zero of=/swapfile bs=1024 count=1024k

# Use the swap file
mkswap /swapfile
swapon /swapfile

# make sure the swap is present after reboot:
echo " /swapfile       none    swap    sw      0       0 " >> /etc/fstab


# Set the swappiness (performance - aware)
echo 10 | tee /proc/sys/vm/swappiness
echo vm.swappiness = 10 | tee -a /etc/sysctl.conf           

# Change the permission to non-world-readable
chown root:root /swapfile 
chmod 0600 /swapfile