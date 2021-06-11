#!/bin/bash

if [ $# != 1 ];then
    echo "useage: $0 server_num"
    exit
fi

cd ~/myInfiniswap/setup

./pull.sh

sudo rm -rf portal.list

client=211
if [ $1 == "1" ];then
    echo "server num: 1"
    echo -e "1\n192.168.0.212:9400" | tee portal.list
elif [ $1 == "2" ];then
    echo "server num: 2"
    echo -e "2\n192.168.0.212:9400\n192.168.0.213:9400" | tee portal.list
elif [ $1 == "4" ];then
    echo "server num: 4"
    echo -e "4\n192.168.0.212:9400\n192.168.0.213:9400\n192.168.0.214:9400\n192.168.0.215:9400" | tee portal.list
elif [ $1 == "8" ];then
    echo "server num: 8"
    echo -e "8\n192.168.0.212:9400\n192.168.0.213:9400\n192.168.0.214:9400\n192.168.0.215:9400\n192.168.0.216:9400\n192.168.0.217:9400\n192.168.0.218:9400\n192.168.0.219:9400" | tee portal.list
fi

./bd.sh ${client}

# cd ../exp
# ./dataframe_docker.sh