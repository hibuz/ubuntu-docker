#!/bin/bash

sudo service ssh start

if [ ! -d "/tmp/hadoop-`whoami`/dfs/name" ]; then
    hdfs namenode -format
fi

start-dfs.sh

if [[ "$1" == *"yarn"* ]]; then
    sed -i s/local/yarn/ $HADOOP_CONF_DIR/mapred-site.xml
    start-yarn.sh
fi

if [[ "$1" == *"historyserver"* ]]; then
    mapred --daemon start historyserver
fi

if [ ! -d "$HIVE_HOME/metastore_db" ]; then
    init-hive-dfs.sh
    schematool -dbType derby -initSchema
fi

if [[ "$1" == *"hbase"* ]]; then
    start-hbase.sh
fi

hdfs dfsadmin -report

jps

hiveserver2
