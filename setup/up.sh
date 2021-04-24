#!/bin/bash

./install.sh

user=root
client=u224
server=u221

echo "copy to server:${server} client:${client}"

scp -r ../../Infiniswap root@${client}:~/ >/dev/null 2>&1
ssh ${user}@${server} "pidof activeswap-daemon | xargs kill -s 9"
ssh ${user}@${server} "pidof infiniswap-daemon | xargs kill -s 9"
scp -r ../../Infiniswap root@${server}:~/ >/dev/null 2>&1