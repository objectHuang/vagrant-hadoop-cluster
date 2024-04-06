#!/bin/bash
kill -9 $(netstat -nltp | grep 9083 | awk '{print $7}' | awk -F "/" '{print $1}')
kill -9 $(netstat -nltp | grep 10000 | awk '{print $7}' | awk -F "/" '{print $1}')