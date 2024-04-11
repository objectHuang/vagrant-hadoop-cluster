#!/bin/bash 

######################################
# INSTALL HIVE
######################################

echo "Setup Hive"

# Make tar folder if it doesn't exist
mkdir -p ../../vagrant/tar/

# If Hive tar is not in system, download it
ls ../../vagrant/tar/ | 
grep ^apache-hive &> /dev/null || 
wget https://dlcdn.apache.org/hive/hive-3.1.3/apache-hive-3.1.3-bin.tar.gz -P ../../vagrant/tar/

ls ../../vagrant/tar/ | 
grep ^mysql-connector-java &> /dev/null || 
wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.29/mysql-connector-java-8.0.29.jar -P ../../vagrant/tar/

# If Hive is not installed, install Hive
hive --version &> /dev/null || {
ls /usr/local/hive &> /dev/null || {
sudo tar -xvf ../../vagrant/tar/apache-hive-3.1.3-bin.tar.gz -C /usr/local/
sudo mv -T /usr/local/apache-hive-3.1.3-bin /usr/local/hive
sudo cp ../../vagrant/tar/mysql-connector-java-8.0.29.jar /usr/local/hive/lib/
}
sudo chmod 777 /usr/local/hive/
sudo chmod 777 /usr/local/hive/conf/
}

# Set environmental variables
grep HIVE .bashrc &> /dev/null || cat >> .bashrc << 'EOF'

# Hive Variables START
export HIVE_HOME=/usr/local/hive
export HIVE_CONF_DIR=$HIVE_HOME/conf
export PATH=$PATH:$HIVE_HOME/bin:$HIVE_HOME/sbin
# Hive Variables END
EOF

######################################
# CONFIGURE HIVE
######################################

# Set temporary environmental variables
export HIVE_HOME=/usr/local/hive
export HADOOP_HOME=/usr/local/hadoop
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

# Deploy Hive configurations
sudo cp ../../vagrant/configs/hive/* $HIVE_HOME/conf/
sudo cp ../../vagrant/scripts/hive/* $HIVE_HOME/bin/

# Start Hive's Metastore
ls $HIVE_HOME/conf/metastore_db &> /dev/null || $HIVE_HOME/bin/schematool -initSchema -dbType mysql &> /dev/null


echo "Setup Hive Completed"