#!/bin/bash

num=$1

source servers.sh $1{num}

echo "StrictHostKeyChecking no" > ~/.ssh/config

ib=212
for server in ${servers[*]};do
    echo "cp-${server}, ib: 192.168.0.${ib}, running..."
    ssh ${user}@128.110.96.${server} "ps -ef | grep run_daemon.sh | grep /bin/bash | awk '{print \$2}' | xargs kill -s 9"
    sleep 4
    ssh ${user}@128.110.96.${server} "cd ~/myInfiniswap/setup && ./pull.sh && ./run_daemon.sh ${ib} > /dev/null 2>&1 &" 
    ib=`expr ${ib} + 1`
done

echo "sleep 100s..."
sleep 100

# echo 0 | sudo tee /proc/sys/kernel/hung_task_timeout_secs

cd ../setup
./run_bd.sh ${num}
cd ../exp

sleep 20
echo "connected server: `dmesg | grep 'ESTABLISHED, ip' | wc -l`"

echo "sleep 10s..."
sleep 10