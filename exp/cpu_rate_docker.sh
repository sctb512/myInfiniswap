#!/bin/bash

file="$1_cpu_rate.csv"

echo "num,cpu_rate,mm_rate" > ${file}

i=0
while [ True ];do
    echo "${i},`sudo docker stats --no-stream is_workloads |awk 'NR==2 {printf("%s,%s\n",$2,$8)}'`" >> ${file}
    sleep 1
    i=`expr ${i} + 1`
done