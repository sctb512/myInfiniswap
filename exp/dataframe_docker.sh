#!/bin/bash

output_dir="./result_dataframe"
if [ ! -d ${output_dir} ]; then
    mkdir -p ${output_dir}
fi

total_mem=41943040
docker_name=is_workloads
echo "total_mem: ${total_mem}"

for local in 100 75 50;do
    local_mem=`expr ${total_mem} \* 100 / ${local}`
    df_num=`expr ${local_mem} / 220851`
    echo "local_mem: ${local_mem}, df_num: ${df_num}"

    sudo docker stop $(sudo docker ps -a -q)
    sudo docker rm $(sudo docker ps -a -q)
    
    sudo docker run -itd -m ${local_mem}K --name ${docker_name} ubuntu
    sudo docker ps -a

    echo "install env in docker..."
    sudo docker exec -it ${docker_name} /bin/bash -c "apt-get update && apt-get install python3 -y && python3 -V && apt-get install python3-pip -y && pip3 install pandas" > /dev/null 2>&1
    sudo docker cp dataframe.py ${docker_name}:/root
    sudo docker exec -it ${docker_name} /bin/bash -c "cd /root && mkdir ${output_dir} && ls && (time python3 dataframe.py ${df_num}) 2> ${output_dir}/total_mem${total_mem}_local_mem${local_mem}_local${local}.txt"

    sudo docker cp ${docker_name}:/root/${output_dir}/ ${output_dir}/
done