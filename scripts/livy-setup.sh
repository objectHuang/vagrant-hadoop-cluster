#!/bin/bash

echo "Setup Livy"

mkdir -p ../../vagrant/tar/

# If Spark tar is not in system, download it
ls ../../vagrant/tar/ | 
grep ^apache-livy &> /dev/null || 
wget https://dlcdn.apache.org/incubator/livy/0.8.0-incubating/apache-livy-0.8.0-incubating_2.12-bin.zip -P ../../vagrant/tar/

# If Spark is not installed, install Spark

ls /usr/local/livy &> /dev/null || {
sudo unzip ../../vagrant/tar/apache-livy-0.8.0-incubating_2.12-bin.zip -d /usr/local/
sudo mv -T /usr/local/apache-livy-0.8.0-incubating_2.12-bin /usr/local/livy

sudo chmod 777 /usr/local/livy/
}

ln -s /usr/local/apache-livy-0.8.0-incubating_2.12-bin /usr/local/livy


grep LIVY .bashrc &> /dev/null || cat >> .bashrc << 'EOF'

# Livy Variables START
export LIVY_HOME=/usr/local/livy
# Livy Variables END
EOF

echo "Copy Livy configuration"
sudo cp -f ../../vagrant/configs/livy/* /usr/local/livy/conf/


echo "Setup Livy completed"
