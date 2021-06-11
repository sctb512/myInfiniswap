#!/bin/bash

cd ~
wget https://enos.itcollege.ee/~jpoial/allalaadimised/jdk8/jdk-8u291-linux-x64.tar.gz
tar -zxvf jdk-8u291-linux-x64.tar.gz
mv jdk1.8.0_291 jdk-1.8

echo "export JAVA_HOME=$(pwd)/jdk-1.8" >> ~/.bashrc
echo "export JRE_HOME=$(pwd)/jdk-1.8" >> ~/.bashrc
echo "export CLASSPATH=${JAVA_HOME}/lib:${JRE_HOME}/lib:${CLASSPATH}" >> ~/.bashrc
echo "export PATH=${JAVA_HOME}/bin:${JRE_HOME}/bin:${PATH}" >> ~/.bashrc

source ~/.bashrc

# echo "export JAVA_HOME=$(pwd)/jdk-1.8" | sudo tee -a /etc/profile
# echo "export JRE_HOME=$(pwd)/jdk-1.8" | sudo tee -a /etc/profile
# echo "export CLASSPATH=${JAVA_HOME}/lib:${JRE_HOME}/lib:${CLASSPATH}" | sudo tee -a /etc/profile
# echo "export PATH=${JAVA_HOME}/bin:${JRE_HOME}/bin:${PATH}" | sudo tee -a /etc/profile

# source /etc/profile

java -version

sudo apt-get -y install ant build-essential ant-optional default-jdk python cmake \
    valgrind ntp ccache git-arch git-completion git-core git-svn git-doc \
    git-email python-httplib2 python-setuptools python-dev apt-show-versions


# change python to 3.6
sudo apt-get install software-properties-common -y

sudo add-apt-repository ppa:deadsnakes/ppa

sudo apt-get update
sudo apt-get install python3.6 -y

sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.4 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 2
sudo update-alternatives --install /usr/bin/python python /usr/bin/python2 100
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 150

sudo apt-get install curl python3.6-gdbm -y
# curl https://bootstrap.pypa.io/ez_setup.py | sudo python3
curl https://bootstrap.pypa.io/get-pip.py | sudo python3

ant -version
gcc -v
make -version
python --version

# install voltdb
git clone https://github.com/VoltDB/voltdb.git

cd voltdb
ant clean
ant

# enable transparent hugepage
sudo bash -c "echo never > /sys/kernel/mm/transparent_hugepage/enabled"
sudo bash -c "echo never > /sys/kernel/mm/transparent_hugepage/defrag"

# run tpc-c
cd ~/voltdb/tests/test_apps/tpcc/
./run.sh server &
./run.sh init
./run.sh client
