#!/bin/bash

servers_num=$1

output_dir="is_lxc_result_memcached_${servers_num}"
cpu_rate_dir="${output_dir}_cpu_rate"

if [ ! -d ${output_dir} ]; then
    mkdir -p ${output_dir}
fi
if [ ! -d ${cpu_rate_dir} ]; then
    mkdir -p ${cpu_rate_dir}
fi

total_mem=1460099
docker_name=is-workloads
echo "total_mem: ${total_mem}"

eval $(ssh-agent -s)
ssh-add /users/bin_tang/.ssh/cloud

# echo 0 | sudo tee  /proc/sys/kernel/hung_task_timeout_secs

cd ../setup
./run_infiniswap.sh ${servers_num} ./config2.sh
cd ../exp

sudo lxc start ${docker_name}

sudo lxc config set ${docker_name} limits.memory.swap.priority 50
sudo lxc config set ${docker_name} limits.memory.swap true


./watch_file_num.sh ${output_dir} &

for i in $(seq 10); do
# for i in $(seq 2); do
    sudo mkdir -p ${output_dir}/${i}
    for local in 100 95 90 85 80 75 70 65 60 55 50; do
        ps -ef | grep cpu_rate.sh | grep /bin/bash | awk '{print $2}' | xargs kill -s 9
        ./cpu_rate.sh "${output_dir}_local${local}_i${i}" ${cpu_rate_dir} &
        
        # for local in 65 60 55 50; do
        chunk_num=$(dmesg | grep "\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*" | wc -l)

        if [ ${chunk_num} -gt 28 ]; then
            sudo reboot
            exit
        fi

        local_mem=$((${total_mem} * ${local} / 100))

        file="total_mem${total_mem}_local_mem${local_mem}_local${local}.txt"

        if [ -f ${output_dir}/${i}/${file} ]; then
            echo "file ${file} existed, continue..."
            continue
        fi
        echo "time: $(date "+%Y-%m-%d %H:%M:%S")"

        sudo lxc config set ${docker_name} limits.memory ${local_mem}kB
        echo $((${local_mem} * 1024 + 32 * 1024 * 1024 * 1024)) | sudo tee /sys/fs/cgroup/memory/lxc/${docker_name}/memory.memsw.limit_in_bytes

        sleep 10
        sudo lxc list

        echo "install env in lxc..."

        sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic "cd /root && rm -rf ${output_dir}" >/dev/null 2>&1

        echo "total: ${total_mem} local: ${local} running..."
        sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic "cd /root && mkdir ${output_dir} && memcached -p 11211 -m 64m -d -u root && sleep 5 && memtier_benchmark -s 127.0.0.1 -p 11211 -P memcache_text --clients 100 --threads 8 --data-size 256 --test-time 30 --pipeline 10240 --out-file ${output_dir}/${file} > /dev/null 2>&1"

        sudo lxc file pull ${docker_name}/root/${output_dir}/${file} ./${output_dir}/${i}/

    done
done
