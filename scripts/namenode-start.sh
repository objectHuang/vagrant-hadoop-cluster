#!/bin/bash

export HADOOP_HOME=/usr/local/hadoop
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_YARN_HOME=$HADOOP_HOME
export SPARK_HOME=/usr/local/spark
export HIVE_HOME=/usr/local/hive
export PDSH_RCMD_TYPE=ssh

echo "############## Starting hadoop in the cluster"
$HADOOP_HOME/sbin/start-all.sh


echo "############## Starting hive meta service and hiveserver"
$HIVE_HOME/bin/hive-start.sh

echo "############## Create spark log folder under hdfs"
hdfs dfs -mkdir hdfs://namenode:9000/spark-logs

echo "############## Starting Spark in the cluster"
$SPARK_HOME/sbin/start-all.sh