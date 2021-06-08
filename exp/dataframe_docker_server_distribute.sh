#!/bin/bash

servers_num=$2

once_file="is_once_${servers_num}.txt"
server_distribute="is_server_${servers_num}_distribute.txt"

# sudo rm -rf ${output_dir}/*


if [ ! -f ${once_file} ]; then
    echo 1 > ${once_file}
fi
i=`cat ${once_file}`


cd ../setup
./run_infiniswap.sh ${servers_num}
cd ../exp
./compile_cpu.sh
./cpu ${cpu_useage} &


if [ ! -f ${server_distribute} ]; then
    head="turn"
    for k in `seq ${servers_num}`;do
        head="${head},${k}"
    done
    echo ${head} > ${server_distribute}
fi

sudo fio -filename=/dev/infiniswap0 -direct=1 -iodepth 64 -thread -rw=32 -ioengine=psync -bs=32k -size=16G -numjobs=32 -runtime=30 -group_reporting -name=is_server_tmp.txt

line="${i}"
ib=212
for m in `seq ${servers_num}`;do
    num=`dmesg | grep "] cb->cb_index: ., ip: 192.168.0." | grep ${ib} | wc -l`
    line="${line},${num}"
    ib=`expr ${ib} + 1`
done
echo ${line} >> ${server_distribute}

i=`expr ${i} + 1`
echo ${i} > ${once_file}