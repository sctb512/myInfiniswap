#!/bin/bash

output_dir=$2
cpu_rate_dir=$3

cd ~/myInfiniswap/setup

./pull.sh

pidof infiniswap-daemon | xargs kill -s 9
pidof activeswap-daemon | xargs kill -s 9
ps -ef | grep cpu_rate.sh | grep /bin/bash | awk '{print $2}' | xargs kill -s 9

if [ -n "$2" ] && [ -n "$3" ];then
    cd ../exp
    ./cpu_rate.sh ${output_dir} ${cpu_rate_dir} &
    cd ../setup
fi

./daemon.sh 192.168.0.$1