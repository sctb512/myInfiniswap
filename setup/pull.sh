#!/bin/bash

cd ..
git fetch --all
sudo git reset --hard origin/master
git pull