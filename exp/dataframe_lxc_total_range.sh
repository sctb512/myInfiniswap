#!/bin/bash

cpu_useage=90
servers_num=$1

output_dir="is_result_dataframe_lxc_total_range_${servers_num}_servers_cpu_${cpu_useage}"
cpu_rate_dir="${output_dir}_cpu_rate"

once_file="${output_dir}_once.txt"
server_distribute="${output_dir}_distribute.csv"

if [ ! -d ${output_dir} ]; then
    mkdir -p ${output_dir}
fi
if [ ! -d ${cpu_rate_dir} ]; then
    mkdir -p ${cpu_rate_dir}
fi

if [ ! -f ${once_file} ]; then
    echo 1 >${once_file}
fi
index=$(cat ${once_file})

if [ ! -f ${server_distribute} ]; then
    head="turn"
    for k in $(seq ${servers_num}); do
        head="${head},${k}"
    done
    echo ${head} >${server_distribute}
fi
# sudo rm -rf ${output_dir}/*

total_mem=25165824
docker_name=is-workloads
echo "total_mem: ${total_mem}"

eval $(ssh-agent -s)
ssh-add /users/bin_tang/.ssh/cloud

cd ../setup
./run_infiniswap.sh ${servers_num} ./config1.sh
cd ../exp

sudo lxc start ${docker_name}

sudo lxc config set ${docker_name} limits.memory.swap.priority 50
sudo lxc config set ${docker_name} limits.memory.swap true

ps -ef | grep "cpu " | awk '{print $2}' | xargs kill -s 9

./compile_cpu.sh
./cpu ${cpu_useage} &

# ps -ef | grep cpu_rate_core.sh | grep /bin/bash | awk '{print $2}' | xargs kill -s 9
ps -ef | grep cpu_rate_docker.sh | grep /bin/bash | awk '{print $2}' | xargs kill -s 9

./cpu_rate_lxc.sh ${output_dir} ${docker_name} ${cpu_rate_dir} &
# ./cpu_rate_core.sh ${output_dir} &
./watch_file_num.sh ${output_dir} &

sudo lxc file push dataframe.py ${docker_name}/root/

local=60

for i in $(seq 10); do
# for i in $(seq 5); do
    sudo mkdir -p ${output_dir}/${i}
    for total_cur in 100 90 80 70 60; do
    # for local in 100 90 80 70 60 50 40; do
        local_cur=$((${total_mem} * ${total_cur} / 100))
        local_mem=$((${local_cur} * ${local} / 100))
        df_num=$((${local_cur} / 220851))
        echo "local_mem: ${local_mem}, df_num: ${df_num}"

        chunk_num=$(dmesg | grep "\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*" | wc -l)
        if [ ${chunk_num} -gt $((27 * ${servers_num})) ]; then
            ib=212
            line="${index}"
            for m in $(seq ${servers_num}); do
                num=$(dmesg | grep "bd done, daemon ip" | grep ${ib} | wc -l)
                line="${line},${num}"
                ib=$(expr ${ib} + 1)
            done
            echo ${line} >>${server_distribute}

            index=$((${index} + 1))
            echo ${index} >${once_file}

            sudo reboot
            exit
        fi

        file="total_mem${local_cur}_local_mem${local_mem}_local${local}.txt"

        if [ -f ${output_dir}/${i}/${file} ]; then
            continue
        fi

        sudo lxc config set ${docker_name} limits.memory ${local_mem}kB
        echo $((${local_mem} * 1024 + 32 * 1024 * 1024 * 1024)) | sudo tee /sys/fs/cgroup/memory/lxc/${docker_name}/memory.memsw.limit_in_bytes

        echo "install env in lxc..."
        sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic "cd /root && rm -rf ${output_dir}" >/dev/null 2>&1
        sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic "cd /root && mkdir ${output_dir} && ls && (time python3 dataframe.py ${df_num}) 2> ${output_dir}/${file}"

        sudo lxc file pull ${docker_name}/root/${output_dir}/${file} ./${output_dir}/${i}/

    done
done
