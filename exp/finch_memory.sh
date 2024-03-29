#!/bin/bash

headline="finch"
for i in `seq 5`;do
	headline="${headline},${i}_memory_used(kB)"
done
echo "${headline}" > finch_memory.csv

for data in `seq 8 8 32`;do
	rm -rf test*.csv
	line="${data}"	
	for i in `seq 5`;do
		mem_base=`free | awk '/Mem/ {print $3}'`
		mem_max=0
		python3 /users/bin_tang/FINCH-Clustering/python/finch.py --data-path /users/bin_tang/FINCH-Clustering/data/mnist10k/data.csv --output-path out &
		sleep 10
		mem_cur=`free | awk '/Mem/ {print $3}'`
		used=`expr ${mem_cur} - ${mem_base}`
		gb=`expr 1024 \* 1024`
		mb=$((1024*200))
		while [ ${used} -gt ${mb} ];do
			sleep 1
			mem_cur=`free | awk '/Mem/ {print $3}'`
			if [ ${mem_cur} -gt ${mem_max} ];then
				mem_max=${mem_cur}
			fi
			used=`expr ${mem_cur} - ${mem_base}`
		done
		used_kB=`expr ${mem_max} - ${mem_base}`
		line="${line},${used_kB}"
        pkill python3
		sleep 10
	done
	echo "${line}"
	echo "${line}" >> finch_memory.csv
done