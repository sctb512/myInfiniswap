#!/bin/bash

headline="type,repetition,memory_used(kB)"

outfile=graph_benchmark_memory.csv
echo "${headline}" > ${outfile}

rm -rf test*.csv

# codes=(graphtool_profile.py lightgraphs.jl networkx_profile.py igraph_profile.py networkit_profile.py snap_profile.py)
codes=(graphtool_profile.py networkx_profile.py igraph_profile.py networkit_profile.py snap_profile.py)
# datas=(amazon.txt enron.txt google.txt pokec.txt)
datas=(amazon.txt google.txt enron.txt)
repetitions=(20 40 60 80 100)

curdir=`pwd`

tmpdir=graph_benchmark_time
if [ ! -d ${tmpdir} ];then
    mkdir ${tmpdir}
fi

for code in ${codes[*]};do
    for data in ${datas[*]};do
        for repetition in ${repetitions[*]};do
            cname=`echo ${code} | awk -F. '{print $1}'`
            dname=`echo ${data} | awk -F. '{print $1}'`
            line="${code}_${data},${repetition}"	
            for i in `seq 4`;do
                mem_base=`free | awk '/Mem/ {print $3}'`
                mem_max=0

                echo "abin 1111 ${curdir}/${tmpdir}/graph_benchmark_time_${cname}_${dname}_${repetition}.txt ok"
                # source /etc/profile && conda activate base && cd ~/graph-benchmarks && bash run_profiler.sh code/${code} data/${data} ${repetition} ${curdir}/${tmpdir}/graph_benchmark_time_${cname}_${dname}_${repetition}.txt &
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
done