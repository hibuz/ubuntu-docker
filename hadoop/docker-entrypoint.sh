#!/bin/bash

sudo service ssh start

if [ ! -d "/tmp/hadoop-`whoami`/dfs/name" ]; then
hdfs namenode -format
fi

$HADOOP_HOME/sbin/start-dfs.sh

if [ "$1" == "yarn" ]; then
$HADOOP_HOME/sbin/start-yarn.sh
fi

jps

tail -f $HADOOP_HOME/logs/*namenode*.log
