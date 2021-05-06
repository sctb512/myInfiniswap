#!/bin/bash

# change kernel
apt-cache search linux|grep 4.4.0-140-generic
sudo apt-get install linux-image-4.4.0-140-generic linux-image-extra-4.4.0-140-generic linux-tools-4.4.0-140-generic linux-headers-4.4.0-140-generic -y
sudo reboot


# install infiniband driver
wget http://content.mellanox.com/ofed/MLNX_OFED-4.1-1.0.2.0/MLNX_OFED_LINUX-4.1-1.0.2.0-ubuntu14.04-x86_64.iso

sudo apt-get remove libibnetdisc5 -y

sudo mount -o ro,loop MLNX_OFED_LINUX-4.1-1.0.2.0-ubuntu14.04-x86_64.iso /mnt
cd /mnt
sudo ./mlnxofedinstall --basic

sudo /etc/init.d/openibd restart
sudo hca_self_test.ofed

# run daemon
cd ~/myInfiniswap/setup
./daemon.sh 192.168.0.12

# run bd
cd ~/myInfiniswap/setup
./bd.sh 192.168.0.11