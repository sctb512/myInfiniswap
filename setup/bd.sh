#!/bin/bash

sudo dmesg -C

cd ../infiniswap_bd
make clean
cd ../setup

swapon -s
swap=`swapon -s | grep /dev | awk '{print $1}'`
dev=`echo ${swap} | awk -F / '{print $3}'`
sudo swapoff ${swap}
sed -i "s/sda3/${dev}/g"  ./old.sh
swapon -s

echo "install bd ..."
sudo ./install.sh bd

echo "confihure ib0 ..."
sudo ./ib_setup.sh $1
ifconfig ib0 | grep "inet addr"

echo "run infiniswap_bd_setup.sh ..."
sudo ./infiniswap_bd_setup.sh
swapon -s

