# == Info =======================================
# hibuz/hive-dev(SIZE: 2.3GB) -> hibuz/spark-dev(SIZE: 2.57GB)

# == Build ======================================
# docker build -t hibuz/spark-dev .
# or
# docker build -t hibuz/spark-dev --build-arg SPARK_VERSION=3.2.0 .

# == Run and Attatch ============================
# docker run --rm -it -p 8080:8080 -p 4040:4040 --name spark-tmp hibuz/spark-dev
# 
# docker exec -it spark-tmp bash


# == Init =======================================
FROM hibuz/hive-dev
ARG DEFAULT_USER=hadoop
WORKDIR /home/${DEFAULT_USER}

# == Package Setting ============================
RUN sudo apt-get update && sudo apt-get install -y python3 \
    && sudo rm -rf /var/lib/apt/lists/*

# == Install ============================
ARG SPARK_VERSION=3.2.0
RUN set -x \
    && DOWNLOAD_URL="https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-without-hadoop.tgz" \
    && curl -fSL "$DOWNLOAD_URL" -o download.tar.gz \
    && tar -xvf download.tar.gz \
    && mv spark-${SPARK_VERSION}-bin-without-hadoop spark-${SPARK_VERSION} \
    && mkdir /tmp/spark-events \
    && rm download.tar.gz

# == Env Setting ============================
ENV SPARK_HOME /home/${DEFAULT_USER}/spark-${SPARK_VERSION}
ENV PATH $PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin

RUN cp $SPARK_HOME/conf/spark-env.sh.template $SPARK_HOME/conf/spark-env.sh \
    && echo "export SPARK_HOME=$SPARK_HOME" >> ~/.bash_profile \
    && echo "export HADOOP_HOME=$HADOOP_HOME" >> $SPARK_HOME/conf/spark-env.sh \
    && echo "export SPARK_DIST_CLASSPATH=\$(\$HADOOP_HOME/bin/hadoop classpath)" >> $SPARK_HOME/conf/spark-env.sh

COPY docker-entrypoint.sh /

EXPOSE 8080

ENTRYPOINT ["/docker-entrypoint.sh"]