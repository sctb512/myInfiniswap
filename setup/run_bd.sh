#!/bin/bash

cd ~/myInfiniswap/setup

./pull.sh

if [ $2 == "1" ];then
    echo -e "1\n192.168.0.12" > portal.list
elif [ $2 == "2" ];then
    echo -e "2\n192.168.0.122\n192.168.0.123" > portal.list
elif [ $2 == "4" ];then
    echo -e "4\n192.168.0.112\n192.168.0.113\n192.168.0.114\n192.168.0.115" > portal.list
elif [ $2 == "8" ];then
    echo -e "8\n192.168.0.112\n192.168.0.113\n192.168.0.114\n192.168.0.115\n192.168.0.116\n192.168.0.117\n192.168.0.118\n192.168.0.119" > portal.list
fi

# ./bd.sh 192.168.0.111
./bd.sh 192.168.0.$1

# cd ../exp
# ./dataframe_docker.sh