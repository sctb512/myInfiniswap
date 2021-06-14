#!/bin/bash

sudo apt-get install software-properties-common -y

sudo add-apt-repository -y ppa:deadsnakes/ppa

sudo apt-get update
sudo apt-get install python3.6 -y

sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.4 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 2

# sudo update-alternatives --install /usr/bin/python python /usr/bin/python2 100
# sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 150

sudo apt-get install curl python3.6-gdbm -y
# curl https://bootstrap.pypa.io/ez_setup.py | sudo python3
curl https://bootstrap.pypa.io/get-pip.py | sudo python3


# echo 'export PATH=$HOME/.local/bin:$PATH' >>~/.bashrc
# source ~/.bashrc

pip install pandas