# Quick usage for hadoop-dev docker image
- Docker build and run
``` bash
git clone https://github.com/hibuz/ubuntu-docker
cd ubuntu-docker/hadoop

docker compose up
```

## Docker build & run for custom hadoop user and version
- see [Dockerfile](Dockerfile)

## Execute MapReduce jobs
- See https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html#Execution

### Attach to running container
``` bash
docker exec -it hadoop bash
```

### Prepare input files into the distributed filesystem
``` bash
cd $HADOOP_HOME
# Make the HDFS directories
hdfs dfs -mkdir -p /user/hadoop/input
# Copy the input files
hdfs dfs -put etc/hadoop/*.xml input
```

### Run some of the examples provided:
``` bash
hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.1.jar grep input output 'dfs[a-z.]+'
# View the output files on the distributed filesystem:
hdfs dfs -cat output/*
# Result of the output files 
1	dfsadmin
1	dfs.replication
```

# Visit hadoop dashboard
- http://localhost:9870
- http://localhost:8088 (run start-yarn.sh or uncomment command props in [docker-compose.yml](docker-compose.yml))

# Reference
- https://github.com/rancavil/hadoop-single-node-cluster
- https://github.com/big-data-europe/docker-hadoop