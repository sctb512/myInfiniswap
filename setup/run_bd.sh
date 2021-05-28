#!/bin/bash

if [ $# != 1 ];then
    echo "useage: $0 server_num"
    exit
fi

cd ~/myInfiniswap/setup

./pull.sh

./bd.sh $1

# cd ../exp
# ./dataframe_docker.sh