#!/bin/bash

cd ..

# git config --local credential.helper store

git fetch --all
sudo git reset --hard origin/master
git pull