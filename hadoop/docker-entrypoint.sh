#!/bin/bash

sudo service ssh start

if [ ! -d "/tmp/hadoop-`whoami`/dfs/name" ]; then
    hdfs namenode -format
fi

start-dfs.sh

if [ "$1" == "yarn" ]; then
    start-yarn.sh
fi

jps

hdfs dfsadmin -report

tail -f $HADOOP_HOME/logs/*namenode*.log
