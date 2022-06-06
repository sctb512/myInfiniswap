#!/bin/bash

cd ..
git add -A
git commit -m "update files"
git push --all origin

./remote_pull.sh