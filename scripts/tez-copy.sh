#!/bin/bash

echo "copy Tez to HDFS"

export HADOOP_HOME=/usr/local/hadoop
export PATH=$PATH:$HADOOP_HOME/bin
export PATH=$PATH:$HADOOP_HOME/sbin

hdfs dfs -mkdir /tez
hdfs dfs -mkdir /tmp
hdfs dfs -put -f /usr/local/tez /tez
hdfs dfs -chmod -R 755 /tez
hdfs dfs -chmod -R 755 /tmp

echo "Copy Tez complete"
