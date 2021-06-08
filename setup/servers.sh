#!/bin/bash

user=bin_tang

if [ $1 == "8" ];then
    servers=(55 62 46 63 39 43 48 61)
elif [ $1 == "4" ];then
    servers=(55 62 46 63)
elif [ $1 == "2" ];then
    servers=(55 62)
elif [ $1 == "1" ];then
    servers=(55)
fi

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