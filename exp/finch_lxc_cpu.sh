#!/bin/bash

servers_num=$1

output_dir="is_lxc_result_finch_${servers_num}"
out_dir="out"

if [ ! -d ${output_dir} ]; then
    mkdir -p ${output_dir}
fi

total_mem=19092340
# total_mem=5287770
total_mem=`expr ${total_mem} \* 1024`

docker_name=is-workloads
echo "total_mem: ${total_mem}"

# cd ../setup
# ./run_infiniswap.sh ${servers_num}
# cd ../exp


ps -ef | grep cpu_rate_lxc.sh | grep /bin/bash | awk '{print $2}' | xargs kill -s 9

# ./cpu_rate_lxc.sh ${output_dir} ${docker_name} &

sudo lxc start ${docker_name}

for i in `seq 10`;do
    sudo mkdir -p ${output_dir}/${i}
    for local in 100 95 90 85 80 75;do
    # for local in 70 65 60 55 50;do
        local_mem=`expr ${total_mem} \* ${local} / 100`

        file="total_mem${total_mem}_local_mem${local_mem}_local${local}.txt"

        if [ -f ${output_dir}/${i}/${output_dir}/${file} ];then
            continue
        fi

        sudo lxc config set ${docker_name} limits.memory ${local_mem}

        sleep 10
        sudo lxc list

        echo "install env in lxc..."

        sudo lxc exec ${docker_name} -- su ubuntu -c "cd /root && rm -rf ${output_dir} && rm -rf ${out_dir}"  >/dev/null 2>&1
        sudo lxc exec ${docker_name} -- su ubuntu -c "cd /root && mkdir ${output_dir} && mkdir ${out_dir} && (time /root/miniconda3/bin/python3 /root/FINCH-Clustering/python/finch.py --data-path /root/FINCH-Clustering/data/mnist10k/data.csv --output-path ${out_dir}) 2> ${output_dir}/${file}"

        sudo lxc file pull ${docker_name}/home/ubuntu/${output_dir}/${file} ./${output_dir}/${i}/

    done
done