#!/bin/bash

for i in `seq 1 $(cat /proc/cpuinfo |grep "processor" |wc -l)`; do dd if=/dev/zero of=/dev/null; done