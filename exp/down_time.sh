#!/bin/bash

servers_num=$1

output_dir="down_time_${servers_num}"
down_dir="${output_dir}/down"
nodown_dir="${output_dir}/nodown"

if [ ! -d ${down_dir} ]; then
    mkdir -p ${down_dir}
fi
if [ ! -d ${nodown_dir} ]; then
    mkdir -p ${nodown_dir}
fi

eval $(ssh-agent -s)
ssh-add /users/bin_tang/.ssh/cloud

cd ../setup
./run_infiniswap.sh ${servers_num}  ./config1.sh
cd ../exp


echo "StrictHostKeyChecking no" > ~/.ssh/config

for RW in randread randwrite read write;do
    for IODEPTH in 1 4 16 32 64;do
        for DAEMON in down nodown;do
            if [ "${DAEMON}" == "down" ];then
                out_file="${down_dir}/${RW}-${IODEPTH}.txt"
            else
                out_file="${nodown_dir}/${RW}-${IODEPTH}.txt"
            fi

            if [ -f ${out_file} ]; then
                echo "file ${out_file} existed, continue..."
                continue
            fi

            echo "rw: ${RW}, iodepth: ${IODEPTH} running..."

            

            echo "sudo fio -bs=4k -rw=${RW} -ioengine=libaio -numjobs=1 -runtime=100 -iodepth=${IODEPTH} -filename=/dev/infiniswap0 -name=${RW}-${IODEPTH} -ramp_time=10 -output=${out_file}"
            nohup sudo fio -bs=4k -rw=${RW} -ioengine=libaio -numjobs=1 -runtime=100 -iodepth=${IODEPTH} -filename=/dev/infiniswap0 -name=${RW}-${IODEPTH} -ramp_time=10 -output=${out_file} &
            if [ "${DAEMON}" == "down" ];then
                sleep 60
                cd ../setup
                source ./config1.sh ${servers_num}
                cd ../exp

                for i in ${!servers[@]};do
                    server=${servers[${i}]}
                    ip=${ips[${i}]}
                    ib=${ibs[${i}]}

                    echo "cp-${server}, ib: 192.168.0.${ib}, reboot..."
                    ssh ${user}@128.110.96.${ip} "ps -ef | grep run_daemon.sh | grep /bin/bash | awk '{print \$2}' | xargs kill -s 9"
                    sleep 2
                    ssh ${user}@128.110.96.${ip} "sudo reboot" 
                done
            fi
            
            sleep 100

            sudo reboot
            exit
        done
    done
done