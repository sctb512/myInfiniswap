#!/bin/bash

docker_name=is_workloads

pfx=none
localdir="${pfx}_graph_benchmark"

codes=(graphtool_profile.py lightgraphs.jl networkx_profile.py igraph_profile.py networkit_profile.py snap_profile.py)
datas=(amazon.txt enron.txt google.txt pokec.txt)

sudo docker exec -i ${docker_name} /bin/bash -c "cd /root/graph-benchmarks/output/ && rm -rf *"

for code in ${codes[*]};do
    for data in ${datas[*]};do
        cname=`echo ${code} | awk -F. '{print $1}'`
        outfile="output/${pfx}_${cname}_${data}"
        if [ -f "${localdir}/${outfile}" ];then
            continue
        fi
        # echo output/${pfx}_${cname}_${data}
        cmd="source /etc/profile && conda activate base && cd /root/graph-benchmarks && bash run_profiler.sh code/${code} data/${data} 100 ${outfile}"
        echo ${cmd}
        sudo docker exec -i ${docker_name} /bin/bash -c "${cmd}"
    done
done

if [ ! -d "${localdir}" ];then
    mkdir ${localdir}
fi
sudo docker cp ${docker_name}:/root/graph-benchmarks/output/ ${localdir}/