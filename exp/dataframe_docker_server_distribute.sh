#!/bin/bash

servers_num=$1
cpu_useage=90

output_dir="is_result_dataframe_server_${servers_num}_distribute"

once_file="is_once_${servers_num}.txt"
server_distribute="is_server_${servers_num}_distribute.txt"

# sudo rm -rf ${output_dir}/*

total_mem=16777216
docker_name=is_workloads
echo "total_mem: ${total_mem}"

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

# sudo fio -filename=/dev/infiniswap0 -direct=1 -iodepth 64 -thread -rw=write -ioengine=psync -bs=128k -size=48G -numjobs=64 -runtime=30 -group_reporting -name=is_server_tmp.txt

sudo docker cp dataframe.py ${docker_name}:/root

sudo mkdir -p ${output_dir}/${i}

local=100

local_mem=`expr ${total_mem} \* ${local} / 100`
df_num=`expr ${local} / 220851`
echo "local_mem: ${local_mem}, df_num: ${df_num}"

file="total_mem${total_mem}_local_mem${local_mem}_local${local}.txt"

if [ -f ${output_dir}/${i}/${output_dir}/${file} ];then
    continue
fi


sudo docker stop $(sudo docker ps -a -q)

sudo docker update -m ${local_mem}K --memory-swap `expr 2 \* ${local_mem}`K ${docker_name}
sleep 10
sudo docker start ${docker_name}
sudo docker ps -a

echo "install env in docker..."
sudo docker exec -it ${docker_name} /bin/bash -c "cd /root && rm -rf ${output_dir}"  >/dev/null 2>&1
sudo docker exec -it ${docker_name} /bin/bash -c "cd /root && mkdir ${output_dir} && ls && (time python3 dataframe.py ${df_num}) 2> ${output_dir}/${file}"

sudo docker cp ${docker_name}:/root/${output_dir}/ ./${output_dir}/${i}/


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