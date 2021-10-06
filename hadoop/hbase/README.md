# Quick usage for hbase-dev docker image
- Docker build and run
``` bash
git clone https://github.com/hibuz/ubuntu-docker
cd ubuntu-docker/hadoop/hbase

docker compose up
```

### Attach to running container
``` bash
docker exec -it hbase bash

~/hbase-2.4.6$ hdfs dfs -ls /hbase
Found 12 items
drwxr-xr-x   - hadoop supergroup          0 2021-10-06 13:33 /hbase/.hbck
drwxr-xr-x   - hadoop supergroup          0 2021-10-06 13:33 /hbase/.tmp
drwxr-xr-x   - hadoop supergroup          0 2021-10-06 13:33 /hbase/MasterData
drwxr-xr-x   - hadoop supergroup          0 2021-10-06 13:33 /hbase/WALs
drwxr-xr-x   - hadoop supergroup          0 2021-10-06 13:33 /hbase/archive
drwxr-xr-x   - hadoop supergroup          0 2021-10-06 13:33 /hbase/corrupt
drwxr-xr-x   - hadoop supergroup          0 2021-10-06 13:33 /hbase/data
-rw-r--r--   3 hadoop supergroup         42 2021-10-06 13:33 /hbase/hbase.id
-rw-r--r--   3 hadoop supergroup          7 2021-10-06 13:33 /hbase/hbase.version
drwxr-xr-x   - hadoop supergroup          0 2021-10-06 13:33 /hbase/mobdir
drwxr-xr-x   - hadoop supergroup          0 2021-10-06 13:33 /hbase/oldWALs
drwx--x--x   - hadoop supergroup          0 2021-10-06 13:33 /hbase/staging
```

### hbase shell example
``` bash

# Connect to HBase.
~/hbase-2.4.6$ hbase shell
HBase Shell
Use "help" to get list of supported commands.
Use "exit" to quit this interactive shell.
For Reference, please visit: http://hbase.apache.org/2.0/book.html#shell
Version 2.4.6, r7374d396c271d340d6600d2d6e9cfd61307d9ef8, Fri Sep  3 09:54:35 PDT 2021
Took 0.0683 seconds
hbase(main):001:0>

# Create a table.
hbase(main):001:0> create 'test', 'cf'
Created table test
Took 2.4907 seconds
=> Hbase::Table - test

# Put data into your table.
hbase(main):003:0> put 'test', 'row1', 'cf:a', 'value1'
Took 0.5981 seconds

# Scan the table for all data at once.
hbase(main):006:0> scan 'test'
ROW                                      COLUMN+CELL
 row1                                    column=cf:a, timestamp=2021-10-06T13:36:58.817, value=value1
1 row(s)
Took 0.1601 seconds

# Exit Beeline Shell
hbase(main):006:0> exit
```

### HBase, MapReduce
``` bash
# hbase rowcounter test or
~/hbase-2.4.6$ HADOOP_CLASSPATH=`hbase mapredcp` \
${HADOOP_HOME}/bin/hadoop jar ${HBASE_HOME}/lib/hbase-mapreduce-2.4.6.jar rowcounter test

...
2021-10-06 13:53:22,580 INFO mapreduce.Job:  map 100% reduce 0%
2021-10-06 13:53:22,591 INFO mapreduce.Job: Job job_local2145323075_0001 completed successfully
...

```

### Stops containers and removes containers, networks, and volumes created by `up`.
``` bash

docker compose down -v

[+] Running 3/3
 ⠿ Container hbase         Removed
 ⠿ Volume hbase_hbase-vol  Removed
 ⠿ Network hbase_default   Removed
```

# Visit hbase dashboard
- Master Info: http://localhost:16010

# Reference
- https://hbase.apache.org/book.html#_get_started_with_hbase