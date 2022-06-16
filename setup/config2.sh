#!/bin/bash

user=bin_tang

if [ $1 == "8" ];then
    servers=(55 62 46 63 39 43 48 61)
    client=211
    ibs=(212 213 214 215 216 217 218 219)
elif [ $1 == "4" ];then
    servers=(05 04 08 25)
    ips=(5 4 8 25)
    client=211
    ibs=(212 213 214 215)
elif [ $1 == "2" ];then
    servers=(62 39)
    ips=(62 39)
    client=221
    ibs=(222 223)
elif [ $1 == "1" ];then
    servers=(62)
    ips=(62)
    client=221
    ibs=(222)
fi