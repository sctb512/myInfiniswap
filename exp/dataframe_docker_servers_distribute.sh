#!/bin/bash

servers_num=$1
cpu_useage=90

output_dir="is_result_dataframe_server_${servers_num}_distribute"

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

echo "run infiniswap, sleep 40s..."
sleep 40

if [ ! -f ${server_distribute} ]; then
    head="turn"
    for k in `seq ${servers_num}`;do
        head="${head},${k}"
    done
    echo ${head} > ${server_distribute}
fi

sudo dd if=/dev/zero of=/dev/infiniswap0 count=512 bs=64MB

echo "sleep 80s..."
sleep 80

line="${i}"
ib=212
for m in `seq ${servers_num}`;do
    num=`dmesg | grep "bd done, daemon ip" | grep ${ib} | wc -l`
    line="${line},${num}"
    ib=`expr ${ib} + 1`
done
echo ${line} >> ${server_distribute}

i=`expr ${i} + 1`
echo ${i} > ${once_file}