#!/bin/bash

if [ $# != 1 ]; then
    echo "useage: $0 server_num"
    exit
fi

servers_num=$1

docker_name=is-sworkloads

pfx=is
localdir="${pfx}_graph_benchmark_servers${servers_num}"
cpu_rate_dir="${localdir}_cpu_rate"
memoryfile=graph_benchmark_memory.csv

codes=(graphtool_profile.py igraph_profile.py snap_profile.py)
# datas=(amazon.txt enron.txt google.txt pokec.txt)
datas=(google.txt livejournal.txt pokec.txt)
repetition=1

eval $(ssh-agent -s)
ssh-add /users/bin_tang/.ssh/cloud

cd ../setup
./run_infiniswap.sh ${servers_num}  ./config1.sh
cd ../exp

sudo lxc start ${docker_name}

sudo lxc config set ${docker_name} limits.memory.swap.priority 50
sudo lxc config set ${docker_name} limits.memory.swap true

if [ ! -d "${localdir}" ]; then
    mkdir ${localdir}
fi

sudo bash -c "echo never > /sys/kernel/mm/transparent_hugepage/enabled"
sudo bash -c "echo never > /sys/kernel/mm/transparent_hugepage/defrag"

ps -ef | grep cpu_rate.sh | grep /bin/bash | awk '{print $2}' | xargs kill -s 9
./cpu_rate.sh ${localdir} ${cpu_rate_dir} &

for code in ${codes[*]}; do
    for data in ${datas[*]}; do
        cname=$(echo ${code} | awk -F. '{print $1}')
        dname=$(echo ${data} | awk -F. '{print $1}')
        total_mem=$(awk -F, 'NR>1{print $1,$2,$3,$4,$5,$6,($3+$4+$5+$6)/4}' ${memoryfile} | grep ${cname} | grep ${dname} | grep " 100 " | awk '{print $7}')
        echo "total_mem: ${total_mem}"

        for local in 100 90 80 70 60 50; do

            file="${pfx}_${cname}_${dname}_total${total_mem}_local${local}.txt"
            outpath="output/${file}"
            if [ -f "${localdir}/${file}" ]; then
                echo "${localdir}/${file} existed."
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

            sudo lxc file pull ${docker_name}/root/graph-benchmarks/${outpath} ./${localdir}/
        done
    done
done
