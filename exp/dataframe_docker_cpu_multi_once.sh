#!/bin/bash

cpu_useage=90
servers_num=8

output_dir="is_result_dataframe_${servers_num}_servers_cpu_${cpu_useage}_once"
once_file="is_once.txt"
server_distribute="is_server_distribute.txt"

if [ ! -d ${output_dir} ]; then
    mkdir -p ${output_dir}
fi
# sudo rm -rf ${output_dir}/*

if [ ! -f ${once_file} ]; then
    echo 1 > ${once_file}
fi
i=`cat ${once_file}`

total_mem=16777216
docker_name=is_workloads
echo "total_mem: ${total_mem}"

user=bin_tang
servers=(55 62 46 63 39 43 48 61)


cd ../setup
./run_infiniswap.sh
cd ../exp
./compile_cpu.sh
./cpu ${cpu_useage} &

ps -ef | grep cpu_rate_core.sh | grep /bin/bash | awk '{print $2}' | xargs kill -s 9
ps -ef | grep cpu_rate_docker.sh | grep /bin/bash | awk '{print $2}' | xargs kill -s 9

./cpu_rate_docker.sh ${output_dir} &
./cpu_rate_core.sh ${output_dir} &

sudo docker cp dataframe.py ${docker_name}:/root

if [ ! -f ${server_distribute} ]; then
    head="turn"
    k=1
    for server in ${servers[*]};do
        head="${head},${k}"
        k=`expr ${k} + 1` 
    done
    echo ${head} > ${server_distribute}
fi

sudo dmesg -C

sudo mkdir -p ${output_dir}/${i}
for local in 100 75 50 25;do
    local_mem=`expr ${total_mem} \* ${local} / 100`
    df_num=`expr ${local_mem} / 220851`
    echo "local_mem: ${local_mem}, df_num: ${df_num}"

    file="total_mem${total_mem}_local_mem${local_mem}_local${local}.txt"

    if [ -f ${output_dir}/${i}/${output_dir}/${file} ];then
        continue
    fi

    # ssh ${user}@${server} "pidof infiniswap-daemon | xargs kill -s 9"
    # ssh ${user}@${server} "cd ~/myInfiniswap/setup && ./daemon.sh ${server_ib} 9400" &

    # echo "sleep 80s..."
    # sleep 80

    # cd ../setup
    # ./bd.sh ${client_ib}
    # cd ../exp
    # dmesg | tail

    sudo docker stop $(sudo docker ps -a -q)
    # sudo docker rm $(sudo docker ps -a -q)
    
    # sudo docker run -itd -m ${local_mem}K --name ${docker_name} ubuntu
    # sudo docker ps -a

    sudo docker update -m ${local_mem}K --memory-swap `expr 2 \* ${local_mem}`K ${docker_name}
    sleep 10
    sudo docker start ${docker_name}
    sudo docker ps -a

    echo "install env in docker..."
    # sudo docker exec -it ${docker_name} /bin/bash -c "apt-get update && apt-get install python3 -y && python3 -V && apt-get install python3-pip -y && pip3 install pandas" > /dev/null 2>&1
    # sudo docker cp dataframe.py ${docker_name}:/root
    sudo docker exec -it ${docker_name} /bin/bash -c "cd /root && rm -rf ${output_dir}"  >/dev/null 2>&1
    sudo docker exec -it ${docker_name} /bin/bash -c "cd /root && mkdir ${output_dir} && ls && (time python3 dataframe.py ${df_num}) 2> ${output_dir}/${file}"

    sudo docker cp ${docker_name}:/root/${output_dir}/ ./${output_dir}/${i}/

    line="${i}"
    ib=212
    for server in ${servers[*]};do
        num=`dmesg | grep "] cb->cb_index: ., ip: 192.168.0." | grep ${ib} | wc -l`
        line="${line},${num}"
        ib=`expr ${ib} + 1`
    done
    echo ${line} >> ${server_distribute}

    # cd ../setup
    # ./old.sh
    # cd ../exp
done

i=`expr ${i} + 1`
echo ${i} > ${once_file}