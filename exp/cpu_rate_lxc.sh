#!/bin/bash

if [ $# != 3 ];then
    echo "useage: $0 file_name dockere_name file_dir"
    exit
fi

dir=$3
file="${dir}/$1_cpu_rate_lxc.csv"
docker_name=$2

if [ ! -f ${file} ];then
    echo "unix_time,mem_rate,total,used,free,shared,buffers,cached,usr,sys,cpu_rate" >${file}
fi

while [ True ]; do
    echo -e "$(date +%s),$(sudo lxc exec ${docker_name} -- free -b | awk -F '[ :]+' 'NR==2{printf("%.2f,%d,%d,%d,%d,%d,%d\n"), $3/$2*100,$2,$3,$4,$5,$6,$7}')\c" >>${file}
    echo $(sudo lxc exec ${docker_name} -- top -bn 1 | grep 'Cpu(s)' | awk -F'[" "%]+' '{printf(",%s,%s,%s\n",$3,$5,$3+$5)}') >>${file}
    sleep 1
done
