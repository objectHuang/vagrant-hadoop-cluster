#!/bin/bash

hive --service metastore > /dev/null 2>&1 &
echo -n "Starting metastore servece,please wait"
mt=1
while [ $mt -ne 0 ]
  do
    sleep 0.5
    echo -n "."
    netstat -nltp | grep 9083 > /dev/null 2>&1 
	mt=$?
done
echo ""
echo -e "\e[32mHiveMetastore service is running!\e[0m"

hive --service hiveserver2 > /dev/null 2>&1 &
echo -n "Starting hiveserver2 service,please wait"
hv2=1
while [ $hv2 -ne 0 ]
  do
    sleep 0.5
    echo -n "."
	netstat -nltp | grep 10000 > /dev/null 2>&1
	hv2=$?
done
echo ""
echo -e "\e[32mHiveServer2 service is running!\e[0m"
