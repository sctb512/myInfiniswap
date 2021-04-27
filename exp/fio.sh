#!/bin/bash

output_dir="./result"
if [ ! -d ${output_dir} ]; then
    mkdir -p ${output_dir}
fi

ok="\033[32m[√] \033[0m"
err="\033[31m[x] \033[0m"
info="[.] "

for rw in "randread" "randwrite"; do
    for block_size in 4 8 16 32 64 128; do
        for thread in 1 2 4 8 16 32 64 128; do
            for iodepth in 1 2 3 8 16 32 64 128; do
                # echo -e "${info} running ${rw} bs=${block_size}k thread=${thread} iodepth=${iodepth}"
                name="${rw}_bs=${block_size}k_thread=${thread}_iodepth=${iodepth}"
                # TODO: check filename
				if [ -f ${output_dir}/${name} ];then
					filesize=`wc -c ${output_dir}/${name} | awk '{ print $1 }'`
					# echo -e "${info} file ${name} exist, size: ${filesize}"
					if [ ${filesize} -lt 1500 ]; then
						echo -e "${err} filesze less than 1500, run fio..."
								fio -filename=/dev/infiniswap0 -direct=1 -iodepth ${iodepth} -thread -rw=${rw} -ioengine=psync -bs=${block_size}k -size=10G -numjobs=${thread} -runtime=30 -group_reporting -name=${name} 1>${output_dir}/${name} 2>&1
					fi
					if [ ${filesize} -gt 2500 ]; then
						echo -e "${err} filesze more than 2500, run fio..."
								fio -filename=/dev/infiniswap0 -direct=1 -iodepth ${iodepth} -thread -rw=${rw} -ioengine=psync -bs=${block_size}k -size=10G -numjobs=${thread} -runtime=30 -group_reporting -name=${name} 1>${output_dir}/${name} 2>&1
					fi
				
				else
					echo -e "${ok} ${rw}: bs=${block_size}k, thread=${thread}, iodepth=${iodepth}, run fio..."
							fio -filename=/dev/infiniswap0 -direct=1 -iodepth ${iodepth} -thread -rw=${rw} -ioengine=psync -bs=${block_size}k -size=10G -numjobs=${thread} -runtime=30 -group_reporting -name=${name} 1>${output_dir}/${name} 2>&1
				fi
            done
        done
    done
done