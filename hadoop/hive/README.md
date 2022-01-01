# Quick usage for hive-dev docker image
- Docker build and run
``` bash
git clone https://github.com/hibuz/ubuntu-docker
cd ubuntu-docker/hadoop/hive

docker compose up

# Wait until 4 Hive sessions are created
hive  | 2021-09-12 03:48:25: Starting HiveServer2
...
hive  | Hive Session ID = 2ffe9e77-c95b-4951-b7b7-080710594503
hive  | Hive Session ID = 405b164b-bf28-4b43-bdc1-3fb9d764efe4
hive  | Hive Session ID = 0b62145a-0c32-4636-9ffe-08ba387f99c3
hive  | Hive Session ID = a9a32ed8-a96f-4d7f-9958-15f82cfae28f
```

### Attach to running container
``` bash
docker exec -it hive bash
```

### Hive DDL Operation example
``` bash

# Connect to HiveServer2 with Beeline from shell:
~/hive-3.1.2$ beeline -n hadoop -u jdbc:hive2://localhost:10000
...
Connecting to jdbc:hive2://localhost:10000
Connected to: Apache Hive (version 3.1.2)
Driver: Hive JDBC (version 3.1.2)
Transaction isolation: TRANSACTION_REPEATABLE_READ
Beeline version 3.1.2 by Apache Hive

# Beeline is started with the JDBC URL of the HiveServer2
# First, create a table with tab-delimited text file format:
0: jdbc:hive2://localhost:10000> CREATE TABLE pokes (foo INT, bar STRING);
...
INFO  : OK
INFO  : Concurrency mode is disabled, not creating a lock manager
No rows affected (0.334 seconds)

# Show table
0: jdbc:hive2://localhost:10000> show tables;
...
+-----------+
| tab_name  |
+-----------+
| pokes     |
+-----------+
1 row selected (0.257 seconds)

# Loading data from flat example file into Hive:
0: jdbc:hive2://localhost:10000> LOAD DATA LOCAL INPATH './examples/files/kv1.txt' OVERWRITE INTO TABLE pokes;
...
INFO  : OK
INFO  : Concurrency mode is disabled, not creating a lock manager
No rows affected (1.336 seconds

# Count the number of rows in table pokes:
0: jdbc:hive2://localhost:10000> SELECT COUNT(*) FROM pokes;
...
+------+
| _c0  |
+------+
| 500  |
+------+
1 row selected (5.163 seconds)

# Exit Beeline Shell
0: jdbc:hive2://localhost:10000> !q
Closing: 0: jdbc:hive2://localhost:10000
```

### Stops containers and removes containers, networks, and volumes created by `up`.
``` bash

docker compose down -v

[+] Running 3/3
 ⠿ Container hive          Removed
 ⠿ Network hive_default    Removed
 ⠿ Volume hive_hive-vol    Removed
```

# Visit hive dashboard
- http://localhost:9002

# Reference
- https://cwiki.apache.org/confluence/display/Hive/GettingStarted
- https://github.com/tech4242/docker-hadoop-hive-parquet