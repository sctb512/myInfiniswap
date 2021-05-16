#!/bin/bash

sudo apt-get remove docker docker-engine docker-ce docker.io
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce

# sudo apt-get install -y docker.io

# sudo docker search ubuntu
# sudo docker pull ubuntu

# wget https://get.docker.com/builds/Linux/x86_64/docker-1.9.1
# sudo chmod +x docker-1.9.1
# sudo mv docker-1.9.1 /usr/bin/docker
# sudo service docker restart

docker --version