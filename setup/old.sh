#!/bin/bash

swapon -s
sudo swapoff /dev/infiniswap0
sudo swapon /dev/sda3
swapon -s

sudo nbdxadm -o delete_device -d 0
sudo nbdxadm -o delete_host -i 0

sudo umount /sys/kernel/config

sudo modprobe -r infiniswap
