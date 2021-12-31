#!/bin/bash

tmpdir=graph_benchmark_memory

outfile=${tmpdir}.csv
if [ ! -f "${outfile}" ]; then
    headline="type,repetition,memory_used(kB)"
    echo "${headline}" >${outfile}
fi

# codes=(graphtool_profile.py lightgraphs.jl networkx_profile.py igraph_profile.py networkit_profile.py snap_profile.py)
codes=(graphtool_profile.py igraph_profile.py snap_profile.py)
# datas=(amazon.txt enron.txt google.txt pokec.txt)
datas=(google.txt livejournal.txt pokec.txt)
repetition=1

if [ ! -d "${tmpdir}" ]; then
    mkdir ${tmpdir}
fi

nohup sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic "cd ~ && mkdir ${tmpdir}"

for code in ${codes[*]}; do
    for data in ${datas[*]}; do
        cname=$(echo ${code} | awk -F. '{print $1}')
        dname=$(echo ${data} | awk -F. '{print $1}')
        line="${cname}_${dname},${repetition}"
        for i in $(seq 4); do
            mem_base=$(sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic "free" | awk '/Mem/ {print $3}')
            mem_max=0

            tmp_outfile="./${tmpdir}/graph_benchmark_time_${cname}_${dname}_${repetition}_times${i}.txt"
            if [ -f "${tmp_outfile}" ]; then
                echo "${tmp_outfile} existed."
                continue
            fi
            # source /etc/profile && conda activate base && cd ~/graph-benchmarks && bash run_profiler.sh code/${code} data/${data} ${repetition} ${tmp_outfile} &
            nohup sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic "cd ~ && conda activate base && cd ~/graph-benchmarks && bash run_profiler.sh code/${code} data/${data} ${repetition} ${tmp_outfile}" &
            sleep 10

            runpid=$(sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic "ps -ef | grep run_profiler.sh" | grep code | awk '{print $2}')
            while [ "${runpid}" ]; do
                runpid=$(sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic "ps -ef | grep run_profiler.sh" | grep code | awk '{print $2}')
                sleep 1
                mem_cur=$(free | awk '/Mem/ {print $3}')
                if [ ${mem_cur} -gt ${mem_max} ]; then
                    mem_max=${mem_cur}
                fi
            done
            used_kB=$(expr ${mem_max} - ${mem_base})
            line="${line},${used_kB}"
            sleep 10

            sudo lxc file pull ${docker_name}/root/${tmp_outfile} ./${tmpdir}/
        done
        echo "${line}"
        echo "${line}" >>${outfile}
    done
done
