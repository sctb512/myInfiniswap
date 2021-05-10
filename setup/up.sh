#!/bin/bash

# ./install.sh

project=myInfiniswap
user=bin_tang
machines=(apt050.apt.emulab.net	apt007.apt.emulab.net)

for machine in ${machines[*]};do
    echo "copy ${project} to ${machine}..."
    ssh ${user}@${machine} "pidof activeswap-daemon | xargs kill -s 9"
    ssh ${user}@${machine} "pidof infiniswap-daemon | xargs kill -s 9"
    scp -r ../../${project} ${user}@${machine}:~/ >/dev/null 2>&1
done

cd ..
git add -A
git commit -m "update files"
git push origin master