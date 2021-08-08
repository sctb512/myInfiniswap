#!/bin/bash

headline="graph_benchmark"

headline="type,memory_used(kB)"

outfile=${graph_benchmark}_memory.csv
echo "${headline}" > ${outfile}

rm -rf test*.csv

# codes=(graphtool_profile.py lightgraphs.jl networkx_profile.py igraph_profile.py networkit_profile.py snap_profile.py)
codes=(graphtool_profile.py networkx_profile.py igraph_profile.py networkit_profile.py snap_profile.py)
# datas=(amazon.txt enron.txt google.txt pokec.txt)
datas=(amazon.txt google.txt enron.txt)

for code in ${codes[*]};do
    for data in ${datas[*]};do
    line="${code}_${data}"	
    for i in `seq 5`;do
        mem_base=`free | awk '/Mem/ {print $3}'`
        mem_max=0
        source /etc/profile && conda activate base && cd ~/graph-benchmarks && bash run_profiler.sh code/${code} data/${data} 100 graph_benchmark_time_tmp.txt &
        sleep 10

        runpid=`ps -ef | grep run_profiler.sh | grep code | awk '{print $2}'`
        while [ ${runpid} ];do
            runpid=`ps -ef | grep run_profiler.sh | grep code | awk '{print $2}'`
            sleep 1
            mem_cur=`free | awk '/Mem/ {print $3}'`
            if [ ${mem_cur} -gt ${mem_max} ];then
                mem_max=${mem_cur}
            fi
        done
        used_kB=`expr ${mem_max} - ${mem_base}`
        line="${line},${used_kB}"
        sleep 10
    done
    echo "${line}"
    echo "${line}" >> ${outfile}
    done
done