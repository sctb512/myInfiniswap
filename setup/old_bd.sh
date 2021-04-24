#!/bin/bash

swapon -s
swapoff /dev/infiniswap0
swapon /dev/vda5
swapon -s

nbdxadm -o delete_device -d 0
nbdxadm -o delete_host -i 0

umount /sys/kernel/config

modprobe -r infiniswap
