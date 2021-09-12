#!/bin/bash

sudo service ssh start

if [ ! -d "/tmp/hadoop-`whoami`/dfs/name" ]; then
    hdfs namenode -format
fi

$HADOOP_HOME/sbin/start-dfs.sh

if [ ! -d "$HIVE_HOME/metastore_db" ]; then
    init-hive-dfs.sh
    schematool -dbType derby -initSchema
fi

if [ "$1" == "yarn" ]; then
$HADOOP_HOME/sbin/start-yarn.sh
fi

jps
hdfs dfsadmin -report

hiveserver2
