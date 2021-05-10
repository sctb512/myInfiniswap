#!/bin/bash

./install.sh daemon >/dev/null 2>&1

sudo /etc/init.d/openibd restart

ifconfig ib0 | grep "inet addr"
echo "sleep 10s..."
sleep 10

sudo ./ib_setup.sh $1

cd ../infiniswap_daemon/
./infiniswap-daemon $1 9400