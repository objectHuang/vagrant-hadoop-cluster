#!/bin/bash

echo "Setup Tez"

mkdir -p ../../vagrant/tar/

# If Spark tar is not in system, download it
ls ../../vagrant/tar/ | 
grep ^apache-tez &> /dev/null || 
wget https://downloads-he-de-2.apache.org/tez/0.10.3/apache-tez-0.10.3-bin.tar.gz -P ../../vagrant/tar/

# If Spark is not installed, install Spark

ls /usr/local/tez &> /dev/null || {
sudo tar -xvf ../../vagrant/tar/apache-tez-0.10.3-bin.tar.gz -C /usr/local/
sudo mv -T /usr/local/apache-tez-0.10.3-bin /usr/local/tez

sudo chmod 777 /usr/local/tez/
}

ln -s /usr/local/apache-tez-0.10.3-bin /usr/local/tez

echo "Copy Tez configuration"
sudo cp -f ../../vagrant/configs/tez/mapred-site.xml /usr/local/hadoop/etc/hadoop/.
sudo cp -f ../../vagrant/configs/tez/tez-site.xml /usr/local/tez/conf/.

echo "creating Tez environment variables"
sudo cp -f ../../vagrant/configs/tez/tez.sh /etc/profile.d/tez.sh
. /etc/profile.d/tez.sh

echo "Setup Tez completed"
