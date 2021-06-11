#!/bin/bash

docker_name=is_workloads

sudo docker restart ${docker_name}

sudo docker exec -i ${docker_name} /bin/bash -c 'apt-get update  && apt-get install -y wget git vim'

sudo docker exec -i ${docker_name} /bin/bash -c 'cd ~ && wget https://enos.itcollege.ee/~jpoial/allalaadimised/jdk8/jdk-8u291-linux-x64.tar.gz && tar -zxvf jdk-8u291-linux-x64.tar.gz && mv jdk1.8.0_291 jdk-1.8'
sudo docker exec -i ${docker_name} /bin/bash -c 'cd ~ && echo "export JAVA_HOME=$(pwd)/jdk-1.8" >> ~/.bashrc && echo "export JRE_HOME=$(pwd)/jdk-1.8" >> ~/.bashrc && echo "export CLASSPATH=$(pwd)/jdk-1.8/lib:$(pwd)/jdk-1.8/lib:${CLASSPATH}" >> ~/.bashrc && echo "export PATH=$(pwd)/jdk-1.8/bin:$(pwd)/jdk-1.8/bin:${PATH}" >> ~/.bashrc'

sudo docker restart ${docker_name}

sudo docker exec -i ${docker_name} /bin/bash -c 'java -version'
sudo docker exec -i ${docker_name} /bin/bash -c 'apt-get -y install ant build-essential ant-optional default-jdk python cmake valgrind ntp ccache git-completion git-core git-svn git-doc git-email python-httplib2 python-setuptools python-dev apt-show-versions'

sudo docker exec -i ${docker_name} /bin/bash -c 'ln -s /usr/bin/python3 /usr/bin/python'
sudo docker exec -i ${docker_name} /bin/bash -c 'ant -version && gcc -v && cmake -version && python --version'

# install voltdb
sudo docker exec -i ${docker_name} /bin/bash -c 'cd ~ && git clone https://github.com/VoltDB/voltdb.git && cd voltdb && ant clean && ant'

# enable transparent hugepage
sudo docker exec -i ${docker_name} /bin/bash -c 'echo never > /sys/kernel/mm/transparent_hugepage/enabled && echo never > /sys/kernel/mm/transparent_hugepage/defrag'

# run tpc-c
sudo docker exec -i ${docker_name} /bin/bash -c 'cd ~/voltdb/tests/test_apps/tpcc/ && ./run.sh server'
