#!/bin/bash

user=bin_tang
nodes=(53 64 38 33 25 26)


for node in ${nodes[*]};do
    machine=apt0${node}.apt.emulab.net

    echo "${machine} pull..."
    ssh ${user}@${machine} "cd ~/myInfiniswap/setup && ./pull.sh"
done