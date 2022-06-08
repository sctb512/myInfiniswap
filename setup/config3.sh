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
    servers=(62 39)
    ips=(62 39)
    client=231
    ibs=(232 233)
elif [ $1 == "1" ];then
    servers=(62)
    ips=(62)
    client=231
    ibs=(232)
fi