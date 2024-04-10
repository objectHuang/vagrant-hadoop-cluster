#!/bin/bash 

######################################
# INSTALL SPARK
######################################

echo "Setup Spark"

# Make tar folder if it doesn't exist
mkdir -p ../../vagrant/tar/

# If Spark tar is not in system, download it
ls ../../vagrant/tar/ | 
grep ^spark &> /dev/null || 
wget https://dlcdn.apache.org/spark/spark-3.4.2/spark-3.4.2-bin-hadoop3.tgz -P ../../vagrant/tar/

# If Spark is not installed, install Spark
spark-submit --version &> /dev/null || {
ls /usr/local/spark &> /dev/null || {
sudo tar -xvf ../../vagrant/tar/spark-3.4.2-bin-hadoop3.tgz -C /usr/local/
sudo mv -T /usr/local/spark-3.4.2-bin-hadoop3 /usr/local/spark
}
sudo chmod 777 /usr/local/spark/
}

# Set environmental variables
grep SPARK .bashrc &> /dev/null || cat >> .bashrc << 'EOF'

# Spark Variables START
export SPARK_HOME=/usr/local/spark
export SPARK_CONF_DIR=$SPARK_HOME/conf
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export SPARK_DAEMON_JAVA_OPTS="-Dspark.history.fs.logDirectory=hdfs://namenode/user/spark/applicationHistory"
export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
export PYSPARK_PYTHON=python3
# Spark Variables END
EOF

######################################
# CONFIGURE SPARK
######################################

# Set temporary environmental variables
export HADOOP_HOME=/usr/local/hadoop
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
export SPARK_HOME=/usr/local/spark

# Deploy Spark configurations
sudo cp ../../vagrant/configs/spark/* $SPARK_HOME/conf/

echo "Setup Spark Completed"
