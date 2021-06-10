#!/bin/bash

source servers.sh $1

echo "StrictHostKeyChecking no" > ~/.ssh/config

ib=212
for server in ${servers[*]};do
    echo "cp-${server}, ib: 192.168.0.${ib}, running..."
    ssh ${user}@128.110.96.${server} "ps -ef | grep run_daemon.sh | grep /bin/bash | awk '{print \$2}' | xargs kill -s 9"
    ssh ${user}@128.110.96.${server} "cd ~/myInfiniswap/setup && ./run_daemon.sh ${ib} > /dev/null 2>&1 &" 
    ib=`expr ${ib} + 1`
done

echo "sleep 100s..."
sleep 100

# echo 0 | sudo tee /proc/sys/kernel/hung_task_timeout_secs

cd ../setup
./run_bd.sh $1
cd ../exp

sleep 20
echo "connected server: `dmesg | grep 'ESTABLISHED, ip' | wc -l`"

echo "sleep 10s..."
sleep 10