#!/bin/bash

if [ $# != 2 ]; then
    echo "useage: $0 server_num config_file"
    exit
fi

servers_num=$1
conf=$2

output_dir="is_iccd_memcached_lxc_${servers_num}_servers"
cpu_rate_dir="${output_dir}_cpu_rate"
chunk_dir="${output_dir}_chunk"

once_file="${output_dir}_once.txt"
server_distribute="${output_dir}_distribute.csv"

if [ ! -d ${output_dir} ]; then
    mkdir -p ${output_dir}
fi
if [ ! -d ${cpu_rate_dir} ]; then
    mkdir -p ${cpu_rate_dir}
fi
if [ ! -d ${chunk_dir} ]; then
    mkdir -p ${chunk_dir}
fi
if [ ! -f ${once_file} ]; then
    echo 1 >${once_file}
fi
index=$(cat ${once_file})
if [ ! -f ${chunk_dir}/${server_distribute} ]; then
    head="turn"
    for k in $(seq ${servers_num}); do
        head="${head},${k}"
    done
    echo ${head} >${chunk_dir}/${server_distribute}
fi

ib_start=$(cat ../setup/${conf} | grep client | tail -n 1 | awk -F= '{print $2}')
ib_start=$((${ib_start} + 1))

total_mem=1460099
docker_name=is-workloads
echo "total_mem: ${total_mem}"

eval $(ssh-agent -s)
ssh-add /users/bin_tang/.ssh/cloud

# echo 0 | sudo tee  /proc/sys/kernel/hung_task_timeout_secs

cd ../setup
./run_infiniswap.sh ${servers_num} ${conf} ${output_dir} ${cpu_rate_dir}
cd ../exp

ps -ef | grep cpu_rate.sh | grep /bin/bash | awk '{print $2}' | xargs kill -s 9
ps -ef | grep cpu_rate_lxc.sh | grep "/bin/bash" | awk '{print $2}' | xargs kill -9

sudo lxc start ${docker_name}

sudo lxc config set ${docker_name} limits.memory.swap.priority 50
sudo lxc config set ${docker_name} limits.memory.swap true

./watch_file_num.sh ${output_dir} ${index} ${server_num} ${chunk_dir}/${server_distribute} ${ib_start} &

# for i in $(seq 10); do
for i in $(seq 5); do
    sudo mkdir -p ${output_dir}/${i}
    # for local in 100 95 90 85 80 75 70 65 60 55 50; do
    for local in 100 90 80 70 60 50; do
        chunk_num=$(dmesg | grep "\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*" | wc -l)
        if [ ${chunk_num} -gt 28 ]; then
            echo "chunk_num gt 28, reboot..."
            echo "ib_start: ${ib_start}"
            ib=${ib_start}
            line="${index}"
            for m in $(seq ${servers_num}); do
                num=$(dmesg | grep "bd done, daemon ip" | grep ${ib} | wc -l)
                line="${line},${num}"
                echo "ib: ${ib}, num: ${num}"
                ib=$(expr ${ib} + 1)
            done
            echo ${line} >>${chunk_dir}/${server_distribute}

            index=$((${index} + 1))
            echo ${index} >${once_file}

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

        sudo lxc stop ${docker_name}
        sudo lxc start ${docker_name}

        sudo lxc config set ${docker_name} limits.memory ${local_mem}kB
        echo $((${local_mem} * 1024 + 32 * 1024 * 1024 * 1024)) | sudo tee /sys/fs/cgroup/memory/lxc/${docker_name}/memory.memsw.limit_in_bytes

        sleep 10
        sudo lxc list

        echo "install env in lxc..."

        sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic "cd /root && rm -rf ${output_dir}" >/dev/null 2>&1

        echo "total: ${total_mem} local: ${local} running..."
        ps -ef | grep cpu_rate.sh | grep /bin/bash | awk '{print $2}' | xargs kill -s 9
        ps -ef | grep cpu_rate_lxc.sh | grep "/bin/bash" | awk '{print $2}' | xargs kill -9
        ./cpu_rate.sh "local_${local}_${output_dir}" ${cpu_rate_dir}/${i} &
        ./cpu_rate_lxc.sh "local_${local}_${output_dir}" ${docker_name} ${cpu_rate_dir}/${i} &

        sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic "cd /root && mkdir ${output_dir} && memcached -p 11211 -m 64m -d -u root && sleep 5 && memtier_benchmark -s 127.0.0.1 -p 11211 -P memcache_text --clients 100 --threads 8 --data-size 256 --test-time 30 --pipeline 10240 --out-file ${output_dir}/${file} > /dev/null 2>&1"
        ps -ef | grep cpu_rate.sh | grep /bin/bash | awk '{print $2}' | xargs kill -s 9
        ps -ef | grep cpu_rate_lxc.sh | grep "/bin/bash" | awk '{print $2}' | xargs kill -9

        sudo lxc file pull ${docker_name}/root/${output_dir}/${file} ./${output_dir}/${i}/

    done
done
