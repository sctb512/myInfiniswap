#!/bin/bash

user=bin_tang

if [ $1 == "8" ];then
    servers=(64 38 33 57 62 39 36 34)
    ips=(64 38 33 57 62 39 36 34)
    client=241
    ibs=(242 243 244 247 248 249 250 251)
elif [ $1 == "6" ];then
    servers=(64 38 33 57 62 39)
    ips=(64 38 33 57 62 39)
    client=241
    ibs=(242 243 244 247 248 249)
elif [ $1 == "4" ];then
    servers=(64 38 33 57)
    ips=(64 38 33 57)
    client=241
    ibs=(242 243 244 247)
elif [ $1 == "2" ];then
    servers=(64 38)
    ips=(64 38)
    client=241
    ibs=(242 243)
elif [ $1 == "1" ];then
    servers=(64)
    ips=(64)
    client=241
    ibs=(242)
fi