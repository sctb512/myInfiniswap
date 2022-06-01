#!/bin/bash

if [ $# != 1 ]; then
    echo "useage: $0 server_num"
    exit
fi

servers_num=$1

docker_name=is-workloads

output_dir="is_iccd_graph_lxc_${servers_num}_servers"
cpu_rate_dir="${output_dir}_cpu_rate"
chunk_dir="${output_dir}_chunk"

once_file="${output_dir}_once.txt"
server_distribute="${output_dir}_distribute.csv"

memoryfile=graph_benchmark_memory.csv

# codes=(graphtool_profile.py igraph_profile.py snap_profile.py)
# datas=(amazon.txt enron.txt google.txt pokec.txt)
codes=(graphtool_profile.py igraph_profile.py)
datas=(livejournal.txt pokec.txt)
repetition=1

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

eval $(ssh-agent -s)
ssh-add /users/bin_tang/.ssh/cloud

cd ../setup
./run_infiniswap.sh ${servers_num}  ./config1.sh ${output_dir} ${cpu_rate_dir}
cd ../exp

sudo lxc start ${docker_name}

sudo lxc config set ${docker_name} limits.memory.swap.priority 50
sudo lxc config set ${docker_name} limits.memory.swap true

sudo bash -c "echo never > /sys/kernel/mm/transparent_hugepage/enabled"
sudo bash -c "echo never > /sys/kernel/mm/transparent_hugepage/defrag"

ps -ef | grep cpu_rate_lxc.sh | grep "/bin/bash" | awk '{print $2}' | xargs kill -9
ps -ef | grep cpu_rate.sh | grep /bin/bash | awk '{print $2}' | xargs kill -s 9
./cpu_rate.sh ${output_dir} ${cpu_rate_dir} &
./cpu_rate_lxc.sh ${output_dir} ${docker_name} ${cpu_rate_dir} &

# for i in $(seq 10); do
for i in $(seq 5); do
    mkdir -p ${output_dir}/${i}
    for code in ${codes[*]}; do
        for data in ${datas[*]}; do
            cname=$(echo ${code} | awk -F. '{print $1}')
            dname=$(echo ${data} | awk -F. '{print $1}')
            total_mem=$(awk -F, 'NR>1{print $1,$2,$3,$4,$5,$6,($3+$4+$5+$6)/4}' ${memoryfile} | grep ${cname} | grep ${dname} | awk '{print $7}')
            echo "total_mem: ${total_mem}"

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

                file="${cname}_${dname}_total${total_mem}_local${local}.txt"
                outpath="output/${file}"
                if [ -f "${output_dir}/${i}/${file}" ]; then
                    echo "${output_dir}/${i}/${file} existed."
                    continue
                fi

                local_mem=$((${total_mem} * ${local} / 100))

                sudo lxc config set ${docker_name} limits.memory ${local_mem}kB
                echo $((${local_mem} * 1024 + 32 * 1024 * 1024 * 1024)) | sudo tee /sys/fs/cgroup/memory/lxc/${docker_name}/memory.memsw.limit_in_bytes

                sleep 10
                sudo lxc list

                echo "install env in lxc..."

                sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic "cd /root/graph-benchmarks/output/ && rm -rf *"
                # echo output/${pfx}_${cname}_${data}
                cmd="conda activate base && cd /root/graph-benchmarks && bash run_profiler.sh code/${code} data/${data} ${repetition} ${outpath}"
                echo "command: ${cmd}"
                sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic "${cmd}"

                sudo lxc file pull ${docker_name}/root/graph-benchmarks/${outpath} ./${output_dir}/${i}/
            done
        done
    done
done
