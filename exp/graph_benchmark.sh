# #!/bin/bash

# docker_name=is_workloads

# pfx=none
# localdir="${pfx}_graph_benchmark"

# # codes=(graphtool_profile.py lightgraphs.jl networkx_profile.py igraph_profile.py networkit_profile.py snap_profile.py)
# codes=(graphtool_profile.py networkx_profile.py igraph_profile.py networkit_profile.py snap_profile.py)
# # datas=(amazon.txt enron.txt google.txt pokec.txt)
# datas=(amazon.txt google.txt enron.txt)

# if [ ! -d "${localdir}" ];then
#     mkdir ${localdir}
# fi

# for code in ${codes[*]};do
#     for data in ${datas[*]};do
#         cname=`echo ${code} | awk -F. '{print $1}'`
#         dname=`echo ${data} | awk -F. '{print $1}'`
#         outfile="output/${pfx}_${cname}_${dname}.txt"

#         # echo "${localdir}/${outfile}"
#         if [ -f "${localdir}/${outfile}" ];then
#             echo "${localdir}/${outfile} existed, continue..."
#             continue
#         fi
#         sudo docker exec -i ${docker_name} /bin/bash -c "cd /root/graph-benchmarks/output/ && rm -rf *"
#         # echo output/${pfx}_${cname}_${data}
#         cmd="source /etc/profile && conda activate base && cd /root/graph-benchmarks && bash run_profiler.sh code/${code} data/${data} 100 ${outfile}"
#         echo ${cmd}
#         sudo docker exec -i ${docker_name} /bin/bash -c "${cmd}"

#         sudo docker cp ${docker_name}:/root/graph-benchmarks/output/ ${localdir}/
#     done
# done



#!/bin/bash

if [ $# != 1 ];then
    echo "useage: $0 server_num"
    exit
fi

servers_num=$1

docker_name=is_workloads

pfx=none
localdir="${pfx}_graph_benchmark_servers${servers_num}"

# codes=(graphtool_profile.py lightgraphs.jl networkx_profile.py igraph_profile.py networkit_profile.py snap_profile.py)
codes=(graphtool_profile.py networkx_profile.py igraph_profile.py networkit_profile.py snap_profile.py)
# datas=(amazon.txt enron.txt google.txt pokec.txt)
datas=(amazon.txt google.txt enron.txt)

total_mem=14557477
docker_name=is_workloads
echo "total_mem: ${total_mem}"

# cd ../setup
# ./run_activeswap.sh ${servers_num}
# cd ../exp

if [ ! -d "${localdir}" ];then
    mkdir ${localdir}
fi

sudo bash -c "echo never > /sys/kernel/mm/transparent_hugepage/enabled"
sudo bash -c "echo never > /sys/kernel/mm/transparent_hugepage/defrag"

for code in ${codes[*]};do
    for data in ${datas[*]};do
        for local in 100 90 80 70 60 50;do
            cname=`echo ${code} | awk -F. '{print $1}'`
            dname=`echo ${data} | awk -F. '{print $1}'`
            outfile="output/${pfx}_${cname}_${dname}_total${total_mem}_local${local}.txt"
            if [ -f "${localdir}/${outfile}" ];then
                echo "${localdir}/${outfile} existed, continue..."
                continue
            fi

            local_mem=`expr ${total_mem} \* ${local} / 100`

            sudo docker stop ${docker_name}
            sudo docker update -m ${local_mem}K --memory-swap `expr 2 \* ${local_mem}`K ${docker_name}
            sleep 10
            sudo docker start ${docker_name}
            sudo docker ps -a

            sudo docker exec -i ${docker_name} /bin/bash -c "cd /root/graph-benchmarks/output/ && rm -rf *"
            # echo output/${pfx}_${cname}_${data}
            cmd="source /etc/profile && conda activate base && cd /root/graph-benchmarks && bash run_profiler.sh code/${code} data/${data} 100 ${outfile}"
            echo "command: ${cmd}"
            sudo docker exec -i ${docker_name} /bin/bash -c "${cmd}"

            sudo docker cp ${docker_name}:/root/graph-benchmarks/output/ ${localdir}/
        done
    done
done