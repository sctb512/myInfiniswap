#!/bin/bash

echo "numbers:$#"
if [ $# != 2 ] || [ $# != 4 ];then
    echo "useage: $0 server_num configure_file or $0 server_num configure_file daemon_output_dir daemon_cpu_rate_dir"
    exit
fi

num=$1
conf=$2

source ${conf} ${num}

echo "StrictHostKeyChecking no" > ~/.ssh/config

for i in ${!servers[@]};do
    server=${servers[${i}]}
    ip=${ips[${i}]}
    ib=${ibs[${i}]}

    echo "cp-${server}, ib: 192.168.0.${ib}, running..."
    ssh ${user}@128.110.96.${ip} "ps -ef | grep run_daemon.sh | grep /bin/bash | awk '{print \$2}' | xargs kill -s 9"
    sleep 2
    if [ -n "$3" ] && [ -n "$4" ];then
        ssh ${user}@128.110.96.${ip} "cd ~/myInfiniswap/setup && ./run_daemon.sh ${ib} $3 $4> ~/myInfiniswap/setup/myInfiniswap_daemon.txt &" 
    then
        ssh ${user}@128.110.96.${ip} "cd ~/myInfiniswap/setup && ./run_daemon.sh ${ib} > ~/myInfiniswap/setup/myInfiniswap_daemon.txt &" 
    fi
done

echo "sleep 60s..."
sleep 60

# echo 0 | sudo tee /proc/sys/kernel/hung_task_timeout_secs

cd ../setup
./run_bd.sh ${num} ${conf}
cd ../exp

sleep 20
echo "connected server: `dmesg | grep 'ESTABLISHED, ip' | wc -l`"

echo "sleep 10s..."
sleep 10