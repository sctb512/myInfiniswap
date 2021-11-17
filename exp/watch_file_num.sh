#!/bin/bash

dir=$1
file_num=$(ls -lR ${dir} |grep "^-" | wc -l)

while true;do
    echo "sleep $((60*60*2))s..."
    sleep $((60*60*2))
    cur_file_num=$(ls -lR ${dir} |grep "^-" | wc -l)

    if [ ${cur_file_num} -le ${file_num} ];then
        sudo reboot
    fi
    file_num=${cur_file_num}
done