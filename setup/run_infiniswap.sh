#!/bin/bash

user=bin_tang
server=128.110.96.50
server_ib=192.168.0.112
client_ib=192.168.0.111

ssh ${user}@${server} "pidof infiniswap-daemon | xargs kill -s 9"
ssh ${user}@${server} "cd ~/myInfiniswap/setup && ./daemon.sh ${server_ib} 9400" &

echo "sleep 80s..."
sleep 80

cd ../setup
./bd.sh ${client_ib}
cd ../exp
dmesg | tail

echo "sleep 10s..."
sleep 10