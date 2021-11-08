#!/bin/bash

file="$1_cpu_rate.csv"
docker_name=$2

if [ ! -f ${file} ];then
    echo "num,total,used,available,usr,sys,rate" >${file}
    i=0
else
    i=$(tail ${file} -n 1 | awk -F, '{print $1}')
fi

while [ True ]; do
    echo -e "${i},$(sudo lxc exec ${docker_name} -- free -b | awk 'NR==2 {printf("%s,%s,%s",$2,$3,$7)}')\c" >>${file}
    echo $(sudo lxc exec ${docker_name} -- top -bn 1 | grep 'Cpu(s)' | awk -F'[" "%]+' '{printf(",%s,%s,%s\n",$3,$5,$3+$5)}') >>${file}
    sleep 1
    i=$(expr ${i} + 1)
done
