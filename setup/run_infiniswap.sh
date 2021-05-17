#!/bin/bash

user=bin_tang
server=128.110.96.50

ssh ${user}@${server} "pidof infiniswap-daemon | xargs kill -s 9"
ssh ${user}@${server} "cd ~/myInfiniswap/setup &&./run_daemon.sh 9400" >/dev/null 2>&1 &

echo "sleep 80s..."
sleep 80

cd ../setup
./run_bd.sh
cd ../exp
dmesg | tail

echo "sleep 10s..."
sleep 10