#!/bin/bash

docker_name=is_workloads

pfx=is

codes=(graphtool_profile.py lightgraphs.jl networkx_profile.py igraph_profile.py networkit_profile.py snap_profile.py)
datas=(amazon.txt enron.txt google.txt pokec.txt)

for code in ${codes[*]};do
    for data in ${datas[*]};do
        cname=`echo ${code} | awk -F. '{print $1}'`
        # echo output/${pfx}_${cname}_${data}
        sudo docker exec -i ${docker_name} /bin/bash -c "source /etc/profile && conda activate && bash run_profiler.sh code/${code} data/${data} 100 output/${pfx}_${code}_${data}"
    done
done