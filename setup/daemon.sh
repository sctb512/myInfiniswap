#!/bin/bash

./install.sh daemon

sudo ./ib_setup.sh $1

cd ../infiniswap_daemon/
./infiniswap-daemon $1 9400