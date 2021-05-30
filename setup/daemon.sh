#!/bin/bash

cd ../infiniswap_daemon
sudo make clean >/dev/null 2>&1
sudo rm -rf .deps autom4te.cache aclocal.m4 compile config.* configure depcomp infiniswap-daemon infiniswap-daemon.o install-sh librdma.a Makefile Makefile.in missing rdma-common.o stamp-h1
cd ../setup

# ./install.sh daemon >/dev/null 2>&1
sudo ./install.sh daemon >/dev/null 2>&1

sudo /etc/init.d/openibd restart

echo "sleep 20s..."
sleep 20

sudo ./ib_setup.sh $1
ifconfig ib0 | grep "inet addr"


cd ../infiniswap_daemon/
./infiniswap-daemon $1 9400