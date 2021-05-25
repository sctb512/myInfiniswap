#!/bin/bash

cd ~/myInfiniswap/setup

./pull.sh

# ./bd.sh 192.168.0.111
./bd.sh 192.168.0.$1

# cd ../exp
# ./dataframe_docker.sh