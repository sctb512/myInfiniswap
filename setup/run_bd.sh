#!/bin/bash

dmesg -C

swapon -s
swapoff /dev/vda5
swapon -s

./install.sh

./infiniswap_bd_setup.sh
swapon -s

