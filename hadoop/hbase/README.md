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

~/hbase-2.4.9$ hdfs dfs -ls /hbase
Found 12 items
drwxr-xr-x   - hadoop supergroup          0 2022-02-26 11:33 /hbase/.hbck
drwxr-xr-x   - hadoop supergroup          0 2022-02-26 11:33 /hbase/.tmp
drwxr-xr-x   - hadoop supergroup          0 2022-02-26 11:33 /hbase/MasterData
drwxr-xr-x   - hadoop supergroup          0 2022-02-26 11:33 /hbase/WALs
drwxr-xr-x   - hadoop supergroup          0 2022-02-26 11:33 /hbase/archive
drwxr-xr-x   - hadoop supergroup          0 2022-02-26 11:33 /hbase/corrupt
drwxr-xr-x   - hadoop supergroup          0 2022-02-26 11:33 /hbase/data
-rw-r--r--   3 hadoop supergroup         42 2022-02-26 11:33 /hbase/hbase.id
-rw-r--r--   3 hadoop supergroup          7 2022-02-26 11:33 /hbase/hbase.version
drwxr-xr-x   - hadoop supergroup          0 2022-02-26 11:33 /hbase/mobdir
drwxr-xr-x   - hadoop supergroup          0 2022-02-26 11:33 /hbase/oldWALs
drwx--x--x   - hadoop supergroup          0 2022-02-26 11:33 /hbase/staging
```

### HBase shell example
``` bash

# Connect to HBase.
~/hbase-2.4.9$ hbase shell
HBase Shell
Use "help" to get list of supported commands.
Use "exit" to quit this interactive shell.
For Reference, please visit: http://hbase.apache.org/2.0/book.html#shell
Version 2.4.9, rc49f7f63fca144765bf7c2da41791769286dfccc, Fri Dec 17 19:02:09 PST 2021
Took 0.0029 seconds

# Create a table.
hbase:001:0> create 'test', 'cf'
Created table test
Took 2.1528 seconds
=> Hbase::Table - test

# List your table.
hbase:002:0> list
TABLE
test
1 row(s)
Took 0.0137 seconds
=> ["test"]

# Put data into your table.
hbase:003:0> put 'test', 'row1', 'cf:a', 'value1'
Took 0.1318 second

# Scan the table for all data at once.
hbase:004:0> scan 'test'
ROW                                       COLUMN+CELL
 row1                                     column=cf:a, timestamp=2022-02-25T10:01:30.405, value=value1
1 row(s)
Took 0.0259 seconds

# Exit HBase Shell
hbase:005:0> exit
```

### HBase, MapReduce
``` bash
# hbase rowcounter test or
~/hbase-2.4.9$ hadoop jar $HBASE_HOME/lib/hbase-mapreduce-2.4.9.jar rowcounter test

...
2022-02-26 11:38:51,306 INFO mapreduce.Job: Job job_local756224404_0001 running in uber mode : false
2022-02-26 11:38:51,310 INFO mapreduce.Job:  map 100% reduce 0%
2022-02-26 11:38:51,317 INFO mapreduce.Job: Job job_local756224404_0001 completed successfully
2022-02-26 11:38:51,343 INFO mapreduce.Job: Counters: 33
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