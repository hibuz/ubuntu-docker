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
    # Hadoop history server
    mapred --daemon start historyserver
    # Spark history server
    start-history-server.sh
fi

if [[ "$1" == *"hbase"* ]]; then
    start-hbase.sh
fi

if [[ "$1" == *"spark"* ]]; then
    start-master.sh
    start-workers.sh spark://localhost:7077
fi

zeppelin-daemon.sh start

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
    tail -f $ZEPPELIN_HOME/logs/zeppelin--*.log
fi
