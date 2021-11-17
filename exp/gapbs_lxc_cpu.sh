#!/bin/bash

servers_num=$1

output_dir="is_lxc_result_gapbs_${servers_num}"
cpu_rate_dir="${output_dir}_cpu_rate"

gapbs_dir="/root/gapbs"

functions=(bc bfs cc_sv pr_spmv tc cc pr sssp)
total_memorys=(18186932 18188654 18132460 18232750 18218126 18133960 18131084 33498212)

if [ ! -d ${output_dir} ]; then
    mkdir -p ${output_dir}
fi
if [ ! -d ${cpu_rate_dir} ]; then
    mkdir -p ${cpu_rate_dir}
fi

docker_name=is-workloads

eval $(ssh-agent -s)
ssh-add /users/bin_tang/.ssh/cloud

# echo 0 | sudo tee  /proc/sys/kernel/hung_task_timeout_secs

cd ../setup
./run_infiniswap.sh ${servers_num}  ./config2.sh
cd ../exp

sudo lxc start ${docker_name}

sudo lxc config set ${docker_name} limits.memory.swap.priority 50
sudo lxc config set ${docker_name} limits.memory.swap true

ps -ef | grep cpu_rate_lxc.sh | grep /bin/bash | awk '{print $2}' | xargs kill -s 9
./watch_file_num.sh ${output_dir} &

for i in ${!functions[@]};do
    function=${functions[${i}]}
    total_memory=${total_memorys[${i}]}

    echo "function: ${function}, total_memory: ${total_memory}"

    ps -ef | grep cpu_rate_lxc.sh | grep "/bin/bash" | awk '{print $2}' | xargs kill -9
    ./cpu_rate_lxc.sh ${function} ${docker_name} ${cpu_rate_dir} &

    cur_output_dir=${output_dir}/${function}

    if [ ! -d ${cur_output_dir} ]; then
        mkdir -p ${cur_output_dir}
    fi

    for i in $(seq 10); do
        sudo mkdir -p ${cur_output_dir}/${i}
        for local in 100 95 90 85 80 75 70; do
            # for local in 65 60 55 50;do

            chunk_num=$(dmesg | grep "\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*" | wc -l)

            if [ ${chunk_num} -gt 26 ]; then
                sudo reboot
            fi

            echo "time: $(date "+%Y-%m-%d %H:%M:%S")"

            local_mem=$(expr ${total_memory} \* ${local} / 100)

            file="total_mem${total_memory}_local_mem${local_mem}_local${local}.txt"

            if [ -f ${cur_output_dir}/${i}/${file} ]; then
                continue
            fi

            sudo lxc config set ${docker_name} limits.memory ${local_mem}kB
            echo $((${local_mem} * 1024 + 32 * 1024 * 1024 * 1024)) | sudo tee /sys/fs/cgroup/memory/lxc/${docker_name}/memory.memsw.limit_in_bytes

            sleep 10
            sudo lxc list

            echo "install env in lxc..."

            sudo lxc exec ${docker_name} -- sudo --login --user root bash -ic "cd /root && rm -rf ${cur_output_dir}" >/dev/null 2>&1

            echo "total: ${total_memory} local: ${local} running..."
            sudo lxc exec ${docker_name} -- sudo --login --user root bash -ic "cd /root && mkdir -p ${cur_output_dir} && (time ${gapbs_dir}/${function} -u 26 -n 1) > ${cur_output_dir}/${file} 2>&1"

            sudo lxc file pull ${docker_name}/root/${cur_output_dir}/${file} ./${cur_output_dir}/${i}/

        done
    done

done


