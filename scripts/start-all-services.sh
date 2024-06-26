#!/bin/bash

export HADOOP_HOME=/usr/local/hadoop
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_YARN_HOME=$HADOOP_HOME
export SPARK_HOME=/usr/local/spark
export HIVE_HOME=/usr/local/hive
export PDSH_RCMD_TYPE=ssh
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
export PATH=$PATH:$HIVE_HOME/bin:$HIVE_HOME/sbin
export ZEPPELIN_HOME=/usr/local/zeppelin
export LIVY_HOME=/usr/local/livy
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64


echo "############## Starting hadoop in the cluster"
$HADOOP_HOME/sbin/start-all.sh


echo "############## Waitng hadoop services in the cluster"
sleep 10

echo "############## Starting spark in the cluster"
$SPARK_HOME/sbin/start-all.sh
$SPARK_HOME/sbin/start-history-server.sh

echo "############## Starting zeppelin services in the cluster"
$ZEPPELIN_HOME/bin/zeppelin-daemon.sh start

echo "############## Starting livy services in the cluster"
$LIVY_HOME/bin/livy-server start

echo "############## Waitng hadoop services in the cluster one more time"
sleep 10

echo "############## Starting hive services in the cluster"
$HIVE_HOME/bin/hive-start.sh

echo "############## Starting spark thrift server in the cluster"
$SPARK_HOME/bin/start-thriftserver.sh