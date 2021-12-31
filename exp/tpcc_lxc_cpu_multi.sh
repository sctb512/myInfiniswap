#!/bin/bash

cpu_useage=$1
servers_num=$2

output_dir="is_result_tpcc_${servers_num}_servers_cpu_${cpu_useage}"

if [ ! -d ${output_dir} ]; then
    mkdir -p ${output_dir}
fi
# sudo rm -rf ${output_dir}/*

total_mem=14557477
docker_name=is-workloads
echo "total_mem: ${total_mem}"

eval $(ssh-agent -s)
ssh-add /users/bin_tang/.ssh/cloud

cd ../setup
./run_infiniswap.sh ${servers_num} ./config2.sh
cd ../exp

sudo lxc start ${docker_name}

sudo lxc config set ${docker_name} limits.memory.swap.priority 50
sudo lxc config set ${docker_name} limits.memory.swap true

ps -ef | grep "cpu " | awk '{print $2}' | xargs kill -s 9

./compile_cpu.sh
./cpu ${cpu_useage} &

# ps -ef | grep cpu_rate_core.sh | grep /bin/bash | awk '{print $2}' | xargs kill -s 9
ps -ef | grep cpu_rate.sh | grep /bin/bash | awk '{print $2}' | xargs kill -s 9

./cpu_rate.sh ${output_dir} ${cpu_rate_dir} &
# ./cpu_rate_core.sh ${output_dir} &

sudo bash -c "echo never > /sys/kernel/mm/transparent_hugepage/enabled"
sudo bash -c "echo never > /sys/kernel/mm/transparent_hugepage/defrag"

for i in `seq 10`;do
    sudo mkdir -p ${output_dir}/${i}
    for local in 100 75 50 25;do
        chunk_num=$(dmesg | grep "\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*" | wc -l)

        if [ ${chunk_num} -gt $((27*${servers_num})) ]; then
            sudo reboot
            exit
        fi

        local_mem=`expr ${total_mem} \* ${local} / 100`
        echo "local_mem: ${local_mem}"

        file="total_mem${total_mem}_local_mem${local_mem}_local${local}.txt"

        if [ -f ${output_dir}/${i}/${output_dir}/${file} ];then
            echo "file ${file} existed, continue..."
            continue
        fi

        sudo lxc config set ${docker_name} limits.memory ${local_mem}kB
        echo $((${local_mem} * 1024 + 32 * 1024 * 1024 * 1024)) | sudo tee /sys/fs/cgroup/memory/lxc/${docker_name}/memory.memsw.limit_in_bytes

        sleep 10
        sudo lxc list

        echo "install env in lxc..."

        sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic "cd /root && rm -rf ${output_dir}"  >/dev/null 2>&1
        sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic "cd /root/voltdb/tests/test_apps/tpcc/ && ./run.sh server"
        echo "sleep 30s..."
        sleep 30
        sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic "cd /root/voltdb/tests/test_apps/tpcc/ && ./run.sh init"
        sleep 10
        sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic "cd /root && mkdir ${output_dir} && ls && cd /root/voltdb/tests/test_apps/tpcc/ && ./run.sh client 1> /root/${output_dir}/${file} 2>/dev/null"

        sudo lxc file pull ${docker_name}/root/${output_dir}/${file} ./${output_dir}/${i}/
    done
done