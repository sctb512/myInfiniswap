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

pfx=is
localdir="${pfx}_graph_benchmark_servers${servers_num}"
memoryfile=graph_benchmark_memory.csv

# codes=(graphtool_profile.py lightgraphs.jl networkx_profile.py igraph_profile.py networkit_profile.py snap_profile.py)
codes=(graphtool_profile.py networkx_profile.py igraph_profile.py networkit_profile.py snap_profile.py)
# datas=(amazon.txt enron.txt google.txt pokec.txt)
datas=(amazon.txt google.txt enron.txt)

cd ../setup
./run_infiniswap.sh ${servers_num}
cd ../exp

if [ ! -d "${localdir}" ];then
    mkdir ${localdir}
fi

sudo bash -c "echo never > /sys/kernel/mm/transparent_hugepage/enabled"
sudo bash -c "echo never > /sys/kernel/mm/transparent_hugepage/defrag"

repetition=100
memorymin=1048576

ps -ef | grep cpu_rate_docker.sh | grep /bin/bash | awk '{print $2}' | xargs kill -s 9
./cpu_rate_docker.sh ${localdir} &

for code in ${codes[*]};do
    for data in ${datas[*]};do
        cname=`echo ${code} | awk -F. '{print $1}'`
        dname=`echo ${data} | awk -F. '{print $1}'`
        total_mem=`awk -F, 'NR>1{print $1,$2,$3,$4,$5,$6,($3+$4+$5+$6)/4}' ${memoryfile} | grep ${cname} | grep ${dname} | grep " 100 " | awk '{print $7}'`
        echo "total_mem: ${total_mem}"
        if [ ${total_mem} -lt ${memorymin} ];then
            total_mem=${memorymin}
        fi
        echo "total_mem: ${total_mem}"
        for local in 100 90 80 70 60 50;do
            
            outfile="output/${pfx}_${cname}_${dname}_total${total_mem}_local${local}.txt"
            if [ -f "${localdir}/${outfile}" ];then
                echo "${localdir}/${outfile} existed."
                continue
            fi

            local_mem=`expr ${total_mem} \* ${local} / 100`

            sudo docker stop ${docker_name}
            sudo docker update -m ${local_mem}K --memory-swap `expr 2 \* ${local_mem}`K ${docker_name}
            sleep 10
            sudo docker start ${docker_name}
            sudo docker ps -a

            sudo docker exec -i ${docker_name} /bin/bash -c "apt-get install libgdk3.0-cil" >/dev/null 2>&1
            sudo docker exec -i ${docker_name} /bin/bash -c "cd /root/graph-benchmarks/output/ && rm -rf *"
            # echo output/${pfx}_${cname}_${data}
            cmd="source /etc/profile && conda activate base && cd /root/graph-benchmarks && bash run_profiler.sh code/${code} data/${data} ${repetition} ${outfile}"
            echo "command: ${cmd}"
            sudo docker exec -i ${docker_name} /bin/bash -c "${cmd}"

            sudo docker cp ${docker_name}:/root/graph-benchmarks/output/ ${localdir}/
        done
    done
done