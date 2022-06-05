#!/bin/bash

dir=$1
index=$2
servers_num=$3
server_distribute=$4
ib_start=$5
file_num=$(ls -lR ${dir} |grep "^-" | wc -l)

while true;do
    echo "sleep $((60*60*1))s..."
    sleep $((60*60*1))
    cur_file_num=$(ls -lR ${dir} |grep "^-" | wc -l)

    if [ ${cur_file_num} -le ${file_num} ];then
        ib=${ib_start}
        line="${index}"
        for m in $(seq ${servers_num}); do
            num=$(dmesg | grep "bd done, daemon ip" | grep ${ib} | wc -l)
            line="${line},${num}"
            ib=$(expr ${ib} + 1)
        done
        echo ${line} >>${server_distribute}

        index=$((${index} + 1))
        echo ${index} >${once_file}

        sudo reboot
    fi
    file_num=${cur_file_num}
done