#!/bin/bash

if [ $# != 2 ]; then
    echo "useage: $0 file_name file_dir"
    exit
fi

dir=$2
cpu_rate_file="${dir}/$1_cpu_rate.csv"

interval=1

start_idle=()
start_total=()
cpu_rate=()

echo -n "turn," >${cpu_rate_file}

echo -n "cpu_avg,cpu_user,cpu_sys,mem_rate" >>${cpu_rate_file}
echo "" >>${cpu_rate_file}

turn=0
while [ True ]; do
    echo -n "${turn}," >>${cpu_rate_file}

    start=$(cat /proc/stat | grep "cpu " | awk '{print $2" "$3" "$4" "$5" "$6" "$7" "$8}')

    start_idle=$(echo ${start} | awk '{print $4}')
    start_total=$(echo ${start} | awk '{printf "%.f",$1+$2+$3+$4+$5+$6+$7}')
    start_user=$(echo ${start} | awk '{print $1}')
    start_sys=$(echo ${start} | awk '{print $3}')
    sleep ${interval}

    end=$(cat /proc/stat | grep "cpu " | awk '{print $2" "$3" "$4" "$5" "$6" "$7" "$8}')
    end_idle=$(echo ${end} | awk '{print $4}')
    end_total=$(echo ${end} | awk '{printf "%.f",$1+$2+$3+$4+$5+$6+$7}')
    end_user=$(echo ${end} | awk '{print $1}')
    end_sys=$(echo ${end} | awk '{print $3}')

    idle=$((${end_idle} - ${start_idle}))
    total=$((${end_total} - ${start_total}))
    user=$((${end_user} - ${start_user}))
    sys=$((${end_sys} - ${start_sys}))

    idle_normal=$((${idle} * 100))
    user_normal=$((${user} * 100))
    sys_normal=$((${sys} * 100))

    cpu_usage=$((${idle_normal} / ${total}))
    cpu_rate=$((100 - ${cpu_usage}))
    user_rate=$((${user_normal} / ${total}))
    sys_rate=$((${sys_normal} / ${total}))

    echo -n "${cpu_rate},${user_rate},${sys_rate}," >>${cpu_rate_file}

    mem_rate=$(free -m | awk -F '[ :]+' 'NR==2{printf("%.2f\n"), $3/$2*100}')
    echo -n "${mem_rate}" >>${cpu_rate_file}
    echo "" >>${cpu_rate_file}
    turn=$(expr ${turn} + 1)
done
