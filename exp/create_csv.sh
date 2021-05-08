#!/bin/bash

output_dir="./result_create_csv"
if [ ! -d ${output_dir} ]; then
    mkdir -p ${output_dir}
fi

for local in 100 75 50 25;do
    (time python creaete_csv.py $1) 2 > ${output_dir}/total_$2local${local}.txt
done