#!/bin/bash

client=111

if [ $1 == "1" ];then
    echo "server num: 1"
    client=141
    echo -e "1\n192.168.0.142\c" | sudo tee portal.list
elif [ $1 == "2" ];then
    echo "server num: 2"
    client=151
    echo -e "2\n192.168.0.152\n192.168.0.153\c" | sudo tee portal.list
elif [ $1 == "4" ];then
    echo "server num: 4"
    client=161
    cat portal.list
    echo -e "4\n192.168.0.162\n192.168.0.163\n192.168.0.164\n192.168.0.165\c" | sudo tee portal.list
elif [ $1 == "8" ];then
    echo "server num: 8"
    client=171
    echo -e "8\n192.168.0.172\n192.168.0.173\n192.168.0.174\n192.168.0.175\n192.168.0.176\n192.168.0.177\n192.168.0.178\n192.168.0.179\c" | sudo tee portal.list
fi

# mv portal_$1.list portal.list

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

