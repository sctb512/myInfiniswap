#!/bin/bash

sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:deadsnakes/ppa

sudo apt-get update
sudo apt-get install python3.6 -y

sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.4 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 2

sudo update-alternatives --install /usr/bin/python python /usr/bin/python2 100
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 150

curl https://bootstrap.pypa.io/get-pip.py | sudo python3
curl https://bootstrap.pypa.io/ez_setup.py | sudo python3

echo 'export PATH=/users/bin_tang/.local/bin:$PATH' >>~/.bashrc
source ~/.bashrc

sudo apt-get install python3.6-gdbm

pip install pandas

output_dir="./result_dataframe"
if [ ! -d ${output_dir} ]; then
    mkdir -p ${output_dir}
fi

for local in 100 75 50 25;do
    (time python dataframe.py $1) 2 > ${output_dir}/total_$2local${local}.txt
done