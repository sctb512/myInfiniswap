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