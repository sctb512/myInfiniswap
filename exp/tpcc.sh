#!/bin/bash

cd ~
wget https://enos.itcollege.ee/~jpoial/allalaadimised/jdk8/jdk-8u291-linux-x64.tar.gz
tar -zxvf jdk-8u65-linux-x64.tar.gz
mv jdk1.8.0_65 jdk-1.8

echo export JAVA_HOME=$(pwd)/jdk-1.8 >> ~/.bashrc
echo export JRE_HOME=$(pwd)/jdk-1.8 >> ~/.bashrc
echo export CLASSPATH=$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH >> ~/.bashrc
echo export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH >> ~/.bashrc

source ~/.bashrc
java -version

sudo apt-get -y install ant build-essential ant-optional default-jdk python cmake \
    valgrind ntp ccache git-arch git-completion git-core git-svn git-doc \
    git-email python-httplib2 python-setuptools python-dev apt-show-versions

ant -version
gcc -v
python --version
cmake -h

# install voltdb
git clone https://github.com/VoltDB/voltdb.git

cd voltdb
ant clean
ant

# run tpc-c
cd ~/voltdb/tests/test_apps/tpcc/
./run.sh