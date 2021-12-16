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
            if [ -f ${DAEMON}/${RW}-${IODEPTH}.txt ]; then
                echo "file ${DAEMON}/${RW}-${IODEPTH}.txt existed, continue..."
                continue
            fi
            nohup sudo fio -bs=4k -rw=${RW} -ioengine=libaio -numjobs=1 -runtime=60 -iodepth=${OIDEPTH} -filename=/dev/infiniswap0 -name=${RW}-${IODEPTH} -ramp_time=10 -output=${DAEMON}/${RW}-${IODEPTH}.txt &
            if [ "${DAEMON}" == "down" ];then
                sleep 30
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
                    ssh ${user}@128.110.96.${ip} "reboot" 
                done
            fi
            echo "rw: ${RW}, iodepth: ${IODEPTH} running..."
            sleep 100

            sudo reboot
        done
    done
done