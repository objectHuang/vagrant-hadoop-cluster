#!/bin/bash

export HADOOP_HOME=/usr/local/hadoop
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_YARN_HOME=$HADOOP_HOME
export SPARK_HOME=/usr/local/spark
export HIVE_HOME=/usr/local/hive
export PDSH_RCMD_TYPE=ssh
export SPARK_DAEMON_JAVA_OPTS="-Dspark.history.fs.logDirectory=hdfs://namenode/user/spark/applicationHistory"

echo "############## Starting hadoop in the cluster"
$HADOOP_HOME/sbin/start-all.sh


echo "############## Starting hive meta data service and hiveserver"
$HIVE_HOME/bin/hive-start.sh

echo "############## Create spark files under hdfs"
hdfs dfs -mkdir /spark-logs
hdfs dfs -mkdir -p /user/spark/applicationHistory
hdfs dfs -chmod -R 777 /user/spark
jar cv0f /tmp/spark-libs.jar -C $SPARK_HOME/jars/ .
hdfs dfs -put /tmp/spark-libs.jar /user/spark/.

echo "############## Starting Spark in the cluster"
$SPARK_HOME/sbin/start-all.sh