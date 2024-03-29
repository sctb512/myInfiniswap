#!/bin/bash

servers_num=$1

output_dir="is_result_dataframe_${servers_num}_servers_cpu_more"

once_file="${output_dir}_once.txt"
server_distribute="${output_dir}_distribute.csv"

if [ ! -d ${output_dir} ]; then
    mkdir -p ${output_dir}
fi

if [ ! -f ${once_file} ]; then
    echo 1 > ${once_file}
fi
index=`cat ${once_file}`

if [ ! -f ${server_distribute} ]; then
    head="turn"
    for k in `seq ${servers_num}`;do
        head="${head},${k}"
    done
    echo ${head} > ${server_distribute}
fi
# sudo rm -rf ${output_dir}/*

total_mem=16777216
docker_name=is_workloads
echo "total_mem: ${total_mem}"

cd ../setup
./run_infiniswap.sh ${servers_num}
cd ../exp


# ps -ef | grep "cpu " | awk '{print $2}' | xargs kill -s 9

./compile_cpu.sh
# ./cpu ${cpu_useage} &

# ps -ef | grep cpu_rate_core.sh | grep /bin/bash | awk '{print $2}' | xargs kill -s 9
ps -ef | grep cpu_rate_docker.sh | grep /bin/bash | awk '{print $2}' | xargs kill -s 9

./cpu_rate_docker.sh ${output_dir} &
# ./cpu_rate_core.sh ${output_dir} &

sudo docker cp dataframe.py ${docker_name}:/root


for i in `seq 10`;do
    sudo mkdir -p ${output_dir}/${i}
    for cpu_useage in 50 55 60 65 70 75 80 85 90 95 100;do
        ps -ef | grep "cpu " | awk '{print $2}' | xargs kill -s 9
        sleep 10
        # ./compile_cpu.sh
        ./cpu ${cpu_useage} &

        echo "sleep 10s..."
        sleep 10

        local_mem=${total_mem}
        df_num=`expr ${local_mem} / 220851`
        echo "local_mem: ${local_mem}, df_num: ${df_num}"

        file="total_mem${total_mem}_local_mem${local_mem}_local${cpu_useage}.txt"

        if [ -f ${output_dir}/${i}/${output_dir}/${file} ];then
            continue
        fi

        # ssh ${user}@${server} "pidof infiniswap-daemon | xargs kill -s 9"
        # ssh ${user}@${server} "cd ~/myInfiniswap/setup && ./daemon.sh ${server_ib} 9400" &

        # echo "sleep 80s..."
        # sleep 80

        # cd ../setup
        # ./bd.sh ${client_ib}
        # cd ../exp
        # dmesg | tail

        sudo docker stop $(sudo docker ps -a -q)
        # sudo docker rm $(sudo docker ps -a -q)
        
        # sudo docker run -itd -m ${local_mem}K --name ${docker_name} ubuntu
        # sudo docker ps -a

        sudo docker update -m ${local_mem}K --memory-swap `expr 2 \* ${local_mem}`K ${docker_name}
        sleep 10
        sudo docker start ${docker_name}
        sudo docker ps -a

        echo "install env in docker..."
        # sudo docker exec -it ${docker_name} /bin/bash -c "apt-get update && apt-get install python3 -y && python3 -V && apt-get install python3-pip -y && pip3 install pandas" > /dev/null 2>&1
        # sudo docker cp dataframe.py ${docker_name}:/root
        sudo docker exec -it ${docker_name} /bin/bash -c "cd /root && rm -rf ${output_dir}"  >/dev/null 2>&1
        sudo docker exec -it ${docker_name} /bin/bash -c "cd /root && mkdir ${output_dir} && ls && (time python3 dataframe.py ${df_num}) 2> ${output_dir}/${file}"

        sudo docker cp ${docker_name}:/root/${output_dir}/ ./${output_dir}/${i}/

        # cd ../setup
        # ./old.sh
        # cd ../exp
    done
done

line="${index}"
ib=212
for m in `seq ${servers_num}`;do
    num=`dmesg | grep "bd done, daemon ip" | grep ${ib} | wc -l`
    line="${line},${num}"
    ib=`expr ${ib} + 1`
done
echo ${line} >> ${server_distribute}

index=`expr ${index} + 1`
echo ${index} > ${once_file}