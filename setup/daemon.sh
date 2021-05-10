#!/bin/bash

./install.sh daemon >/dev/null 2>&1

sudo /etc/init.d/openibd restart

sudo ./ib_setup.sh $1
ifconfig ib0 | grep "inet addr"
echo "sleep 10s..."
sleep 10

cd ../infiniswap_daemon/
./infiniswap-daemon $1 9400