#!/bin/bash

docker_name=is_workloads

pfx=none

codes=(graphtool_profile.py lightgraphs.jl networkx_profile.py igraph_profile.py networkit_profile.py snap_profile.py)
datas=(amazon.txt enron.txt google.txt pokec.txt)

sudo docker exec -i ${docker_name} /bin/bash -c "cd /root/graph-benchmarks/output/ && rm -rf *"

for code in ${codes[*]};do
    for data in ${datas[*]};do
        cname=`echo ${code} | awk -F. '{print $1}'`
        outfile="output/${pfx}_${code}_${data}"
        # echo output/${pfx}_${cname}_${data}
        sudo docker exec -i ${docker_name} /bin/bash -c "bash /opt/conda/etc/profile.d/conda.sh && source /etc/profile && conda activate && cd /root/graph-benchmarks && bash run_profiler.sh code/${code} data/${data} 100 ${outfile}"
    done
done

mkdir ${pfx}_graph_benchmark
sudo docker cp ${docker_name}:/root/graph-benchmarks/output/ ${pfx}_graph_benchmark/