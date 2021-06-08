#!/bin/bash

user=bin_tang
servers=(55 62 46 63 39 43 48 61)

echo "StrictHostKeyChecking no" > ~/.ssh/config

ib=212
for server in ${servers[*]};do
    echo "cp-${server}, ib: 192.168.0.${ib}, running..."
    ssh ${user}@128.110.96.${server} "pidof infiniswap-daemon | xargs kill -s 9 && ps -ef | grep run_daemon.sh | grep /bin/bash | awk '{print \$2}' | xargs kill -s 9"
    ssh ${user}@128.110.96.${server} "cd ~/myInfiniswap/setup && ./run_daemon.sh ${ib} > /dev/null 2>&1 &" 
    ib=`expr ${ib} + 1`
done

echo "sleep 80s..."
sleep 80

cd ../setup
./run_bd.sh 8
cd ../exp
dmesg | tail

echo "sleep 10s..."
sleep 10