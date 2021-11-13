#!/bin/bash

cd ..

echo "https://1506376703%40qq.com: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@github.com" > ~/.git-credentials
git config --local credential.helper store

git fetch --all
sudo git reset --hard origin/master
git pull