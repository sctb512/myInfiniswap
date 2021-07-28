#!/bin/bash

user=bin_tang

if [ $1 == "8" ];then
    servers=(55 62 46 63 39 43 48 61)
    client=211
    ibs=(212 213 214 215 216 217 218 219)
elif [ $1 == "4" ];then
    servers=(01 08 04 50)
    ips=(193 8 4 50)
    client=211
    ibs=(212 213 214 215)
elif [ $1 == "2" ];then
    servers=(01 08)
    ips=(193 8)
    client=211
    ibs=(212 213)
elif [ $1 == "1" ];then
    servers=(01)
    ips=(193)
    client=211
    ibs=(212)
fi