#!/bin/bash

cd ..

# echo "https://1506376703%40qq.com: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@github.com" > ~/.git-credentials
# git config --global credential.helper store
# sudo git config --global credential.helper store

# git pull --all -f

git branch -r | grep -v '\->' | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | while read remote; do git branch --track "${remote#origin/}" "$remote"; done
git fetch --all
git pull --all