#!/bin/bash

cd ~/myInfiniswap/setup

./pull.sh

pidof infiniswap-daemon | xargs kill -s 9

./daemon.sh 192.168.0.112