# Quick usage for zeppelin-dev docker image
- Docker build and run
``` bash
git clone https://github.com/hibuz/ubuntu-docker
cd ubuntu-docker/hadoop/zeppelin

docker compose up
```

### Attach to running container
``` bash
docker exec -it zeppelin bash
```

### Prepare input data
``` bash

# prepare input data
hdfs dfs -mkdir -p /user/hadoop
hdfs dfs -put $SPARK_HOME/README.md
```

### Interactive Analysis with the PySpark
``` bash

~/spark-3.1.3$ pyspark

Welcome to
      ____              __
     / __/__  ___ _____/ /__
    _\ \/ _ \/ _ `/ __/  '_/
   /__ / .__/\_,_/_/ /_/\_\   version 3.1.3
      /_/

Using Python version 3.8.10 (default, Nov 26 2021 20:14:08)
Spark context Web UI available at http://886166433d4e:4040
Spark context available as 'sc' (master = local[*], app id = local-1645887524271).
SparkSession available as 'spark'.

# Read text file in the HDFS
>>> textFile = spark.read.text("README.md")

# Number of rows in this DataFrame
>>> textFile.count()
108

# First row in this DataFrame
>>> textFile.first()
Row(value='# Apache Spark')

# Count words in the text file
>>> from pyspark.sql.functions import explode, split
>>> wordCounts = textFile.select(explode(split(textFile.value, "\s+")).alias("word")).groupBy("word").count()
>>> wordCounts.collect()
[Row(word='[![PySpark', count=1), Row(word='online', count=1), Row(word='graphs', count=1)...

>>> quit()
```

### Interactive Analysis in the Zeppelin Notebook
```python
%spark.pyspark

# Show spark dataframe by reading textfile in the HDFS
textFile = spark.read.text("README.md")
textFile.show()

# Show workd count
from pyspark.sql.functions import explode, split
wordCounts = textFile.select(explode(split(textFile.value, "\s+")).alias("word")).groupBy("word").count()
wordCounts.show()
```

### Stops containers and removes containers, networks, and volumes created by `up`.
``` bash

docker compose down -v

[+] Running 4/4
 ⠿ Container zeppelin-spark-base-1  Removed
 ⠿ Container zeppelin               Removed
 ⠿ Volume zeppelin_zeppelin-vol     Removed
 ⠿ Network zeppelin_default         Removed
```

# Visit zeppelin dashboards

- Spark Jobs : http://localhost:4040
- Zeppelin Tutorials: http://localhost:9995
![Zeppelin Tutorials](.assets/zeppelin_dev.jpg)
