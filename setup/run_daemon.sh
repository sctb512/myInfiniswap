#!/bin/bash

cd ~/myInfiniswap/setup

./pull.sh

pidof infiniswap-daemon | xargs kill -s 9
ps -ef | grep cpu_rate_core.sh | grep /bin/bash | awk '{print $2}' | xargs kill -s 9

cd ../exp
./cpu_rate_core.sh ${output_dir} &
cd ../setup

./daemon.sh 192.168.0.112