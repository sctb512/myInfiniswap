#!/bin/bash

cd ..
git add -A
git commit -m "update files"
git push --all origin

cd setup
./remote_pull.sh