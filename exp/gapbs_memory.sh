#!/bin/bash

gapbs_dir="/users/bin_tang/gapbs"

headline="functoin"
for i in $(seq 5); do
    headline="${headline},${i}_memory_used(kB)"
done
echo "${headline}" >gapbs_memory_u24.csv

# functoins=(bc bfs cc_sv converter pr_spmv tc cc pr sssp)
# functoins=(bc bfs cc_sv pr_spmv tc cc pr sssp)
functoins=(cc_sv pr_spmv cc sssp)

for func in ${functoins[*]}; do
    line="${func}"
    for i in $(seq 10); do
        mem_base=$(free | awk '/Mem/ {print $3}')
        mem_max=0
        ${gapbs_dir}/${func} -u 24 -n 1 &
        sleep 0.1
        mem_cur=$(free | awk '/Mem/ {print $3}')
        used=$(expr ${mem_cur} - ${mem_base})
        gb=$(expr 1024 \* 1024)
        mb=$((1024 * 200))
        while [ ${used} -gt ${mb} ]; do
            sleep 0.1
            mem_cur=$(free | awk '/Mem/ {print $3}')
            if [ ${mem_cur} -gt ${mem_max} ]; then
                mem_max=${mem_cur}
            fi
            used=$(expr ${mem_cur} - ${mem_base})
        done
        used_kB=$(expr ${mem_max} - ${mem_base})
        line="${line},${used_kB}"
        pkill ${func}
        sleep 6
    done
    echo "${line}"
    echo "${line}" >>gapbs_memory.csv
done
