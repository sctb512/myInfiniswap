#!/bin/bash

if [ $# != 2 ];then
    echo "useage: $0 server_num client_ib"
    exit
fi

num=$1

source servers.sh ${num}

cd ~/myInfiniswap/setup

./pull.sh

sudo rm -rf portal.list


# if [ $1 == "1" ];then
#     echo "server num: 1"
#     echo -e "1\n192.168.0.212:9400" | tee portal.list
# elif [ $1 == "2" ];then
#     echo "server num: 2"
#     echo -e "2\n192.168.0.218:9400\n192.168.0.219:9400" | tee portal.list
# elif [ $1 == "4" ];then
#     echo "server num: 4"
#     echo -e "4\n192.168.0.212:9400\n192.168.0.213:9400\n192.168.0.214:9400\n192.168.0.215:9400" | tee portal.list
# elif [ $1 == "8" ];then
#     echo "server num: 8"
#     echo -e "8\n192.168.0.212:9400\n192.168.0.213:9400\n192.168.0.214:9400\n192.168.0.215:9400\n192.168.0.216:9400\n192.168.0.217:9400\n192.168.0.218:9400\n192.168.0.219:9400" | tee portal.list
# fi

list=$1
for ib in ${ibs[*]};do
    list="${list}\n192.168.0.${ib}:9400"
done

echo -e ${list} | tee portal.list


./bd.sh ${client}

# cd ../exp
# ./dataframe_docker.sh