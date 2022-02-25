#!/bin/bash

sudo service ssh start

if [ ! -d "/tmp/hadoop-`whoami`/dfs/name" ]; then
    hdfs namenode -format
fi

start-dfs.sh

if [[ "$1" == *"yarn"* ]]; then
    start-yarn.sh
fi

if [[ "$1" == *"historyserver"* ]]; then
    # hadoop history server
    mapred --daemon start historyserver
    # Spark history server
    start-history-server.sh
fi

# Spark server
start-master.sh
start-workers.sh spark://localhost:7077

hdfs dfsadmin -report

jps

if [[ "$1" == *"hive"* ]]; then
    cd $HIVE_HOME

    if [ ! -d "$HIVE_HOME/metastore_db" ]; then
        init-hive-dfs.sh
        schematool -dbType derby -initSchema
    fi
    hiveserver2
else
    tail -f $SPARK_HOME/logs/*master*.out
fi
