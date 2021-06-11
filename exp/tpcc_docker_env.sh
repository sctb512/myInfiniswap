#!/bin/bash

docker_name=is_workloads

sudo docker restart ${docker_name}

sudo docker cp /etc/apt/sources.list ${docker_name}:/etc/apt/

sudo docker exec -i ${docker_name} /bin/bash -c 'apt-get update  && apt-get install -y wget git vim'

sudo docker exec -i ${docker_name} /bin/bash -c 'cd ~ && wget https://enos.itcollege.ee/~jpoial/allalaadimised/jdk8/jdk-8u291-linux-x64.tar.gz && tar -zxvf jdk-8u291-linux-x64.tar.gz && mv jdk1.8.0_291 jdk-1.8'
sudo docker exec -i ${docker_name} /bin/bash -c 'cd ~ && echo "export JAVA_HOME=$(pwd)/jdk-1.8" >> ~/.bashrc && source ~/.bashrc'
sudo docker exec -i ${docker_name} /bin/bash -c 'cd ~ && echo "export JRE_HOME=$(pwd)/jdk-1.8/jre" >> ~/.bashrc && source ~/.bashrc'
sudo docker exec -i ${docker_name} /bin/bash -c 'cd ~ && echo "export CLASSPATH=$(pwd)/jdk-1.8/lib:$(pwd)/jdk-1.8/lib:${CLASSPATH}" >> ~/.bashrc && source ~/.bashrc'
sudo docker exec -i ${docker_name} /bin/bash -c 'cd ~ && echo "export PATH=$(pwd)/jdk-1.8/bin:$(pwd)/jdk-1.8/jre/bin:${PATH}" >> ~/.bashrc && source ~/.bashrc'

sudo docker exec -i ${docker_name} /bin/bash -c 'java -version'
# sudo docker exec -i ${docker_name} /bin/bash -c 'dpkg --configure -a'
sudo docker exec -i ${docker_name} /bin/bash -c 'apt-get update'

sudo docker exec -i ${docker_name} /bin/bash -c 'apt-get -y install ant build-essential ant-optional default-jdk python cmake valgrind ntp ccache git-completion git-core git-svn git-doc git-email python-httplib2 python-setuptools python-dev'

sudo docker exec -i ${docker_name} /bin/bash -c 'apt-get install software-properties-common -y'
sudo docker exec -i ${docker_name} /bin/bash -c 'add-apt-repository ppa:deadsnakes/ppa'
sudo docker exec -i ${docker_name} /bin/bash -c 'apt-get update && apt-get install python3.6 -y'
sudo docker exec -i ${docker_name} /bin/bash -c 'update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1 && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 2 && update-alternatives --install /usr/bin/python python /usr/bin/python3 100 && update-alternatives --install /usr/bin/python python /usr/bin/python2 150'
sudo docker exec -i ${docker_name} /bin/bash -c 'apt-get install curl python3.6-gdbm -y && curl https://bootstrap.pypa.io/get-pip.py | python3'
curl https://bootstrap.pypa.io/ez_setup.py | sudo python3

# sudo docker exec -i ${docker_name} /bin/bash -c 'rm -rf /usr/bin/python && ln -s /usr/bin/python3 /usr/bin/python'
sudo docker exec -i ${docker_name} /bin/bash -c 'ant -version && gcc -v && cmake -version && python --version'

# install voltdb
sudo docker exec -i ${docker_name} /bin/bash -c 'cd ~ && git clone https://github.com/VoltDB/voltdb.git && cd voltdb && ant clean && ant -Djmemcheck=NO_MEMCHECK'

sudo docker exec -i ${docker_name} /bin/bash -c 'cd ~ && echo "export PATH=$(pwd)/voltdb/bin:${PATH}" >> ~/.bashrc && source ~/.bashrc'

# enable transparent hugepage

echo never | sudo tee /sys/kernel/mm/transparent_hugepage/enabled
echo never | sudo tee /sys/kernel/mm/transparent_hugepage/defrag

# run tpc-c
sudo docker exec -i ${docker_name} /bin/bash -c 'cd ~/voltdb/tests/test_apps/tpcc/ && ./run.sh server'
