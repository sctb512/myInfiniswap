#!/bin/bash

servers_num=$1

output_dir="is_lxc_result_finch_${servers_num}"
out_dir="out"

if [ ! -d ${output_dir} ]; then
    mkdir -p ${output_dir}
fi

total_mem=19092340
# total_mem=5287770

docker_name=is-workloads
echo "total_mem: ${total_mem}"

eval $(ssh-agent -s)
ssh-add /users/bin_tang/.ssh/cloud

cd ../setup
./run_infiniswap.sh ${servers_num}
cd ../exp

sudo lxc start ${docker_name}

sudo lxc config set ${docker_name} limits.memory.swap.priority 50
sudo lxc config set ${docker_name} limits.memory.swap true

ps -ef | grep cpu_rate_lxc.sh | grep /bin/bash | awk '{print $2}' | xargs kill -s 9

./cpu_rate_lxc.sh ${output_dir} ${docker_name} &

# for i in $(seq 10); do
for i in $(seq 2); do
    sudo mkdir -p ${output_dir}/${i}
    for local in 100 95 90 85 80 75 70 65 60; do
        # for local in 55 50; do
        chunk_num=$(dmesg | grep "\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*" | wc -l)

        if [ ${chunk_num} -gt 27 ]; then
            sudo reboot
        fi

        # for local in 70 65 60 55 50;do
        local_mem=$(expr ${total_mem} \* ${local} / 100)

        file="total_mem${total_mem}_local_mem${local_mem}_local${local}.txt"

        if [ -f ${output_dir}/${i}/${file} ]; then
            echo "file ${file} existed, continue..."
            continue
        fi

        sudo lxc config set ${docker_name} limits.memory ${local_mem}kB
        echo $((${local_mem} * 1024 + 32 * 1024 * 1024 * 1024)) | sudo tee /sys/fs/cgroup/memory/lxc/${docker_name}/memory.memsw.limit_in_bytes

        sleep 10
        sudo lxc list

        echo "install env in lxc..."

        sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic "cd /root && rm -rf ${output_dir} && rm -rf ${out_dir}" >/dev/null 2>&1

        echo "total: ${total_mem} local: ${local} running..."
        sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic "cd /root && mkdir ${output_dir} && mkdir ${out_dir} && (time /usr/bin/python3 /root/FINCH-Clustering/python/finch.py --data-path /root/FINCH-Clustering/data/mnist10k/data.csv --output-path ${out_dir}) > ${output_dir}/${file} 2>&1"

        sudo lxc file pull ${docker_name}/root/${output_dir}/${file} ./${output_dir}/${i}/

    done
done
