#!/bin/bash

if [ $# != 1 ];then
    echo "useage: $0 server_num"
    exit
fi

cd ~/myInfiniswap/setup

./pull.sh

client=111

if [ $1 == "1" ];then
    echo "server num: 1"
    client=111
    echo -e "1\n192.168.0.119" | sudo tee portal.list
elif [ $1 == "2" ];then
    echo "server num: 2"
    client=116
    echo -e "2\n192.168.0.117\n192.168.0.118" | sudo tee portal.list
elif [ $1 == "4" ];then
    echo "server num: 4"
    client=111
    echo -e "4\n192.168.0.112\n192.168.0.113\n192.168.0.114\n192.168.0.115" | sudo tee portal.list
elif [ $1 == "8" ];then
    echo "server num: 8"
    client=111
    echo -e "8\n192.168.0.112\n192.168.0.113\n192.168.0.114\n192.168.0.115\n192.168.0.116\n192.168.0.117\n192.168.0.118\n192.168.0.119" | sudo tee portal.list
fi

# ./bd.sh 192.168.0.111
echo "client ip: 192.168.0.${client}"
./bd.sh 192.168.0.${client}

# cd ../exp
# ./dataframe_docker.sh