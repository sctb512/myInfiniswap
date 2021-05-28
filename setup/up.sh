#!/bin/bash

# ./install.sh

project=myInfiniswap
user=bin_tang

# machine_nums=(055 047 062 046 063 039 043 048 061)
machine_nums=(039 043 048 061)

echo "StrictHostKeyChecking no" > ~/.ssh/config

for machine_num in ${machine_nums[*]};do
    machine=apt${machine_num}.apt.emulab.net
    echo "copy ${project} to ${machine}..."
    ssh ${user}@${machine} "pidof activeswap-daemon | xargs kill -s 9"
    ssh ${user}@${machine} "pidof infiniswap-daemon | xargs kill -s 9"
    scp -r ../../${project} ${user}@${machine}:~/ >/dev/null 2>&1
done