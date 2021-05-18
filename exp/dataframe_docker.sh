#!/bin/bash

output_dir="is_result_dataframe"

if [ ! -d ${output_dir} ]; then
    mkdir -p ${output_dir}
fi
# sudo rm -rf ${output_dir}/*

total_mem=16777216
docker_name=is_workloads
echo "total_mem: ${total_mem}"

# cd ../setup
# ./run_infiniswap.sh
# cd ../exp


for i in `seq 10`;do
    sudo mkdir -p ${output_dir}/${i}
    for local in 100 75 50 25;do
        local_mem=`expr ${total_mem} \* ${local} / 100`
        df_num=`expr ${local_mem} / 220851`
        echo "local_mem: ${local_mem}, df_num: ${df_num}"

        file_name="total_mem${total_mem}_local_mem${local_mem}_local${local}.txt"

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
        sudo docker rm $(sudo docker ps -a -q)
        
        sudo docker run -itd -m ${local_mem}K --name ${docker_name} ubuntu
        sudo docker ps -a

        echo "install env in docker..."
        sudo docker exec -it ${docker_name} /bin/bash -c "apt-get update && apt-get install python3 -y && python3 -V && apt-get install python3-pip -y && pip3 install pandas" > /dev/null 2>&1
        sudo docker cp dataframe.py ${docker_name}:/root
        sudo docker exec -it ${docker_name} /bin/bash -c "cd /root && mkdir ${output_dir} && ls && (time python3 dataframe.py ${df_num}) 2> ${output_dir}/${file_name}"

        sudo docker cp ${docker_name}:/root/${output_dir}/ ./${output_dir}/${i}/

        # cd ../setup
        # ./old.sh
        # cd ../exp
    done
done