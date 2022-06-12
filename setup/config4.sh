#!/bin/bash

user=bin_tang

if [ $1 == "8" ];then
    servers=(55 62 46 63 39 43 48 61)
    client=231
    ibs=(232 233 234 235 236 237 238 239)
elif [ $1 == "4" ];then
    servers=(05 04 08 25)
    ips=(5 4 8 25)
    client=231
    ibs=(232 233 234 235)
elif [ $1 == "2" ];then
    servers=(49 60)
    ips=(49 60)
    client=241
    ibs=(242 243)
elif [ $1 == "1" ];then
    servers=(49)
    ips=(49)
    client=241
    ibs=(242)
fi