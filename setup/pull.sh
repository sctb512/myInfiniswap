#!/bin/bash

cd ..

echo "https://1506376703%40qq.com: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@github.com" > ~/.git-credentials
git config --local credential.helper store

git fetch --all
sudo git reset --hard origin/master
git pull