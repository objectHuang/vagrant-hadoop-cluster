#!/bin/bash

export HADOOP_HOME=/usr/local/hadoop
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_YARN_HOME=$HADOOP_HOME
export HIVE_HOME=/usr/local/hive
export PDSH_RCMD_TYPE=ssh
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin


echo "############## Starting hadoop in the cluster"
$HADOOP_HOME/sbin/start-all.sh

echo "copy Tez to HDFS"

hdfs dfs -mkdir /tez
hdfs dfs -mkdir /tmp
hdfs dfs -put -f /usr/local/tez /tez
hdfs dfs -chmod -R 755 /tez
hdfs dfs -chmod -R 755 /tmp

echo "Copy Tez complete"

$HADOOP_HOME/sbin/stop-all.sh