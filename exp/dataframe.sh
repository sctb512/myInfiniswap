#!/bin/bash

output_dir="./result_dataframe"
if [ ! -d ${output_dir} ]; then
    mkdir -p ${output_dir}
fi

free_mem=`free -k | awk '/Mem/ {print $4}'`
echo "free_mem: ${free_mem}"

for local in 100 75 50;do
    dataframe_num=`expr ${free_mem} \* 100 / ${local} / 220851`
    echo "dataframe_num: ${dataframe_num}"
    (time python3 dataframe.py ${dataframe_num}) 2> ${output_dir}/lmemory${free_mem}_local${local}.txt
done