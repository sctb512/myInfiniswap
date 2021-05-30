#!/bin/bash

# ./install.sh daemon >/dev/null 2>&1
sudo ./install.sh daemon

sudo /etc/init.d/openibd restart

echo "sleep 20s..."
sleep 20

sudo ./ib_setup.sh $1
ifconfig ib0 | grep "inet addr"


cd ../infiniswap_daemon/
./infiniswap-daemon $1 9400