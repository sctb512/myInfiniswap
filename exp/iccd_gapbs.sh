#!/bin/bash

servers_num=$1

output_dir="is_iccd_gapbs_lxc_${servers_num}_servers"
cpu_rate_dir="${output_dir}_cpu_rate"
chunk_dir="${output_dir}_chunk"

once_file="${output_dir}_once.txt"
server_distribute="${output_dir}_distribute.csv"

gapbs_dir="/root/gapbs"

# functions=(bc bfs cc_sv pr_spmv tc cc pr sssp)
# total_memorys=(18186932 18188654 18132460 18232750 18218126 18133960 18131084 33498212)
functions=(cc_sv pr_spmv cc sssp)
total_memorys=(18132460 18232750 18133960 33498212)


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

docker_name=is-workloads

eval $(ssh-agent -s)
ssh-add /users/bin_tang/.ssh/cloud

# echo 0 | sudo tee  /proc/sys/kernel/hung_task_timeout_secs

cd ../setup
./run_infiniswap.sh ${servers_num}  ./config2.sh ${output_dir} ${cpu_rate_dir}
cd ../exp

sudo lxc start ${docker_name}

sudo lxc config set ${docker_name} limits.memory.swap.priority 50
sudo lxc config set ${docker_name} limits.memory.swap true

ps -ef | grep cpu_rate.sh | grep /bin/bash | awk '{print $2}' | xargs kill -s 9
./cpu_rate.sh ${output_dir} ${cpu_rate_dir} &

./watch_file_num.sh ${output_dir} &

for i in ${!functions[@]};do
    function=${functions[${i}]}
    total_memory=${total_memorys[${i}]}

    echo "function: ${function}, total_memory: ${total_memory}"

    ps -ef | grep cpu_rate_lxc.sh | grep "/bin/bash" | awk '{print $2}' | xargs kill -9
    ./cpu_rate_lxc.sh ${output_dir} ${docker_name} ${cpu_rate_dir} &

    cur_output_dir=${output_dir}/${function}

    if [ ! -d ${cur_output_dir} ]; then
        mkdir -p ${cur_output_dir}
    fi

    # for i in $(seq 10); do
    for i in $(seq 5); do
        sudo mkdir -p ${cur_output_dir}/${i}
        # for local in 100 95 90 85 80 75 70 65 60 55 50; do
        for local in 100 90 80 70 60 50; do
            chunk_num=$(dmesg | grep "\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*" | wc -l)
            if [ ${chunk_num} -gt 28 ]; then
                ib=212
                line="${index}"
                for m in $(seq ${servers_num}); do
                    num=$(dmesg | grep "bd done, daemon ip" | grep ${ib} | wc -l)
                    line="${line},${num}"
                    ib=$(expr ${ib} + 1)
                done
                echo ${line} >>${chunk_dir}/${server_distribute}

                index=$((${index} + 1))
                echo ${index} >${once_file}

                sudo reboot
                exit
            fi

            local_mem=$(expr ${total_memory} \* ${local} / 100)

            file="total_mem${total_memory}_local_mem${local_mem}_local${local}.txt"

            if [ -f ${cur_output_dir}/${i}/${file} ]; then
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

            sudo lxc exec ${docker_name} -- sudo --login --user root bash -ic "cd /root && rm -rf ${cur_output_dir}" >/dev/null 2>&1

            echo "total: ${total_mem} local: ${local} running..."
            sudo lxc exec ${docker_name} -- sudo --login --user root bash -ic "cd /root && mkdir -p ${cur_output_dir} && (time ${gapbs_dir}/${function} -u 26 -n 1) > ${cur_output_dir}/${file} 2>&1"

            sudo lxc file pull ${docker_name}/root/${cur_output_dir}/${file} ./${cur_output_dir}/${i}/

        done
    done

done


