#!/bin/bash

if [ $# != 1 ];then
    echo "useage: $0 server_num"
    exit
fi

if [ $1 == "1" ];then
    echo "server num: 1"
    client=219
    echo -e "1\n192.168.0.217\c" | sudo tee portal.list
elif [ $1 == "2" ];then
    echo "server num: 2"
    client=219
    echo -e "2\n192.168.0.217\n192.168.0.218\c" | sudo tee portal.list
elif [ $1 == "4" ];then
    echo "server num: 4"
    client=211
    echo -e "4\n192.168.0.212\n192.168.0.213\n192.168.0.214\n192.168.0.215\c" | sudo tee portal.list
elif [ $1 == "8" ];then
    echo "server num: 8"
    client=211
    echo -e "8\n192.168.0.212\n192.168.0.213\n192.168.0.214\n192.168.0.215\n192.168.0.216\n192.168.0.217\n192.168.0.218\n192.168.0.219\c" | sudo tee portal.list
fi

# rm -rf portal.list
# mv portal_$1.list portal.list
# echo "servers:"
# cat portal.list

echo ""
echo "client ip: 192.168.0.${client}"

sudo dmesg -C

cd ../infiniswap_bd
sudo make clean >/dev/null 2>&1
sudo rm -rf config.h.in config.log config.status configure infiniswap.ko infiniswap.mod.c infiniswap.mod.o infiniswap.o is_configfs.c is_configfs.o is_main.o is_main.o.ur-safe is_mq.o is_mq.o.ur-safe Makefile Module.symvers modules.order autom4te.cache
cd ../setup

swapon -s
swap=`swapon -s | grep /dev | awk '{print $1}'`
dev=`echo ${swap} | awk -F / '{print $3}'`
sudo swapoff ${swap}
sed -i "s/sda3/${dev}/g"  ./old.sh
swapon -s

echo "install bd ..."
# sudo ./install.sh bd >/dev/null 2>&1
sudo ./install.sh bd >/dev/null 2>&1

echo "confihure ib0 ..."
sudo /etc/init.d/openibd restart

echo "sleep 20s..."
sleep 20

sudo ./ib_setup.sh 192.168.0.${client}
ifconfig ib0 | grep "inet addr"

server=`cat portal.list | tail -n 1| awk -F: '{print $1}'`
ping -c1 ${server} &>/dev/null
while [ $? -eq 1 ];do
    ping -c1 ${server} &>/dev/null
done

echo "run infiniswap_bd_setup.sh ..."
sudo ./infiniswap_bd_setup.sh
swapon -s

