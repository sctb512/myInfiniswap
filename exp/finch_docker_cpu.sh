#!/bin/bash

servers_num=$1

output_dir="is_result_finch_${servers_num}"
out_dir="out"

if [ ! -d ${output_dir} ]; then
    mkdir -p ${output_dir}
fi

total_mem=19092340
# total_mem=5287770
docker_name=is_workloads
echo "total_mem: ${total_mem}"

# cd ../setup
# ./run_infiniswap.sh ${servers_num}
# cd ../exp


ps -ef | grep cpu_rate_docker.sh | grep /bin/bash | awk '{print $2}' | xargs kill -s 9

# ./cpu_rate_docker.sh ${output_dir} &

for i in `seq 10`;do
    sudo mkdir -p ${output_dir}/${i}
    for local in 100 95 90 85 80 75;do
    # for local in 70 65 60 55 50;do
        local_mem=`expr ${total_mem} \* ${local} / 100`

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
        sudo docker exec -i ${docker_name} /usr/bin/zsh -c "cd /root && rm -rf ${output_dir} && rm -rf ${out_dir}"  >/dev/null 2>&1
        sudo docker exec -i ${docker_name} /usr/bin/zsh -c "cd /root && mkdir ${output_dir} && mkdir ${out_dir} && (time /root/miniconda3/bin/python3 /root/FINCH-Clustering/python/finch.py --data-path /root/FINCH-Clustering/data/mnist10k/data.csv --output-path ${out_dir}) 2> ${output_dir}/${file}"

        sudo docker cp ${docker_name}:/root/${output_dir}/ ./${output_dir}/${i}/

    done
done