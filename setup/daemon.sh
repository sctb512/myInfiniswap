#!/bin/bash

cd ../infiniswap_daemon
sudo make clean
cd ../setup

# ./install.sh daemon >/dev/null 2>&1
sudo ./install.sh daemon

sudo /etc/init.d/openibd restart

echo "sleep 10s..."
sleep 10
ifconfig ib0 | grep "inet addr"

sudo ./ib_setup.sh $1

cd ../infiniswap_daemon/
./infiniswap-daemon $1 9400