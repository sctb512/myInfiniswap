#!/bin/bash

cpu_useage=$1
servers_num=$2

output_dir="is_result_tpcc_${servers_num}_servers_cpu_${cpu_useage}"

if [ ! -d ${output_dir} ]; then
    mkdir -p ${output_dir}
fi
# sudo rm -rf ${output_dir}/*

total_mem=25165824
docker_name=is_workloads
echo "total_mem: ${total_mem}"

cd ../setup
./run_infiniswap.sh ${servers_num}
cd ../exp
./compile_cpu.sh
./cpu ${cpu_useage} &

ps -ef | grep cpu_rate_core.sh | grep /bin/bash | awk '{print $2}' | xargs kill -s 9
ps -ef | grep cpu_rate_docker.sh | grep /bin/bash | awk '{print $2}' | xargs kill -s 9

./cpu_rate_docker.sh ${output_dir} &
./cpu_rate_core.sh ${output_dir} &


for i in `seq 10`;do
    sudo mkdir -p ${output_dir}/${i}
    for local in 100 90 80 70 60 50 40 30 20 10;do
        local_mem=`expr ${total_mem} \* ${local} / 100`
        echo "local_mem: ${local_mem}"

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
        sudo docker exec -it ${docker_name} /bin/bash -c "cd ~/voltdb/tests/test_apps/tpcc/ && ./run.sh server >/dev/null 2>&1 &"  
        sudo docker exec -it ${docker_name} /bin/bash -c "cd /root && mkdir ${output_dir} && ls && cd ~/voltdb/tests/test_apps/tpcc/ && ./run.sh init && ./run.sh client 2> /root/${output_dir}/${file}"

        sudo docker cp ${docker_name}:/root/${output_dir}/ ./${output_dir}/${i}/
    done
done