#!/bin/bash

if [ $# != 1 ];then
    echo "useage: $0 server_num"
    exit
fi

if [ $1 == "1" ];then
    echo "server num: 1"
    client=119
    echo -e "1\n192.168.0.117\c" | sudo tee portal.list
elif [ $1 == "2" ];then
    echo "server num: 2"
    client=119
    echo -e "2\n192.168.0.117\n192.168.0.118\c" | sudo tee portal.list
elif [ $1 == "4" ];then
    echo "server num: 4"
    client=111
    echo -e "4\n192.168.0.112\n192.168.0.113\n192.168.0.114\n192.168.0.115\c" | sudo tee portal.list
elif [ $1 == "8" ];then
    echo "server num: 8"
    client=111
    echo -e "8\n192.168.0.112\n192.168.0.113\n192.168.0.114\n192.168.0.115\n192.168.0.116\n192.168.0.117\n192.168.0.118\n192.168.0.119\c" | sudo tee portal.list
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

