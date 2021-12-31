#!/bin/bash

docker_name=is-workloads

sudo lxc restart ${docker_name}

sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic 'apt-get update  && apt-get install -y wget git vim'

sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic 'cd ~ && wget https://enos.itcollege.ee/~jpoial/allalaadimised/jdk8/jdk-8u291-linux-x64.tar.gz && tar -zxvf jdk-8u291-linux-x64.tar.gz && mv jdk1.8.0_291 jdk-1.8'
sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic 'cd ~ && echo "export JAVA_HOME=$(pwd)/jdk-1.8" >> ~/.zshrc && source ~/.zshrc'
sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic 'cd ~ && echo "export JRE_HOME=$(pwd)/jdk-1.8/jre" >> ~/.zshrc && source ~/.zshrc'
sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic 'cd ~ && echo "export CLASSPATH=$(pwd)/jdk-1.8/lib:$(pwd)/jdk-1.8/lib:${CLASSPATH}" >> ~/.zshrc && source ~/.zshrc'
sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic 'cd ~ && echo "export PATH=$(pwd)/voltdb/bin:$(pwd)/jdk-1.8/bin:$(pwd)/jdk-1.8/jre/bin:${PATH}" >> ~/.zshrc && source ~/.zshrc'

sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic 'java -version'

sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic 'apt-get update && apt-get -y install ant build-essential ant-optional default-jdk python cmake valgrind ntp ccache git-completion git-core git-svn git-doc git-email python-httplib2 python-setuptools python-dev'


sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic 'apt-get install software-properties-common -y'
sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic 'add-apt-repository -y ppa:deadsnakes/ppa'
sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic 'apt-get update && apt-get install python3.6 -y'
sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic 'update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1 && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 2 && update-alternatives --install /usr/bin/python python /usr/bin/python3 100 && update-alternatives --install /usr/bin/python python /usr/bin/python2 150'
sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic 'apt-get install curl python3.6-gdbm -y && curl https://bootstrap.pypa.io/get-pip.py | python3'
# curl https://bootstrap.pypa.io/ez_setup.py | sudo python3


sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic 'ant -version && gcc -v && cmake -version && python --version'

# install voltdb
sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic 'cd ~ && git clone https://github.com/VoltDB/voltdb.git && cd voltdb && ant clean && ant -Djmemcheck=NO_MEMCHECK'

sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic 'cd ~ && echo "export PATH=$(pwd)/voltdb/bin:${PATH}" >> ~/.zshrc && source ~/.zshrc'

# enable transparent hugepage

echo never | sudo tee /sys/kernel/mm/transparent_hugepage/enabled
echo never | sudo tee /sys/kernel/mm/transparent_hugepage/defrag

# run tpc-c
sudo lxc exec ${docker_name} -- sudo --login --user root /usr/bin/zsh -ic 'cd ~/voltdb/tests/test_apps/tpcc/ && ./run.sh server'
