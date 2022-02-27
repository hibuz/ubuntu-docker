# == Info =======================================
# hibuz/spark-dev(SIZE: 3.09GB) -> hibuz/zeppelin-dev(SIZE: 5.28GB)

# == Build ======================================
# docker build -t hibuz/zeppelin-dev .
# or
# docker build -t hibuz/zeppelin-dev --build-arg ZEPPELIN_VERSION=0.10.0 --build-arg SPARK_IMAGE_TAG=3.1.3 .

# == Run and Attatch ============================
# docker run --rm -it -p 9995:9995 -p 4040:4040 --name zeppelin-tmp hibuz/zeppelin-dev
# 
# docker exec -it zeppelin-tmp bash


# == Init =======================================
ARG SPARK_IMAGE_TAG
FROM hibuz/spark-dev:${SPARK_IMAGE_TAG:-latest}

# == Install ============================
ARG ZEPPELIN_VERSION=${ZEPPELIN_VERSION:-0.10.0}
ENV ZEPPELIN_HOME /home/${DEFAULT_USER}/zeppelin-${ZEPPELIN_VERSION}

RUN set -x \
    && DOWNLOAD_URL="https://dlcdn.apache.org/zeppelin/zeppelin-${ZEPPELIN_VERSION}/zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz" \
    && curl -fSL "$DOWNLOAD_URL" -o download.tar.gz \
    && tar -xvf download.tar.gz \
    && mv zeppelin-${ZEPPELIN_VERSION}-bin-all $ZEPPELIN_HOME \
    && rm download.tar.gz

RUN pip install jupyter grpcio protobuf matplotlib pandas

# == Env Setting ============================
ENV PATH $PATH:$ZEPPELIN_HOME/bin
ENV ZEPPELIN_ADDR 0.0.0.0
ENV ZEPPELIN_PORT 9995

RUN cp $HIVE_HOME/lib/hive-jdbc-*.jar $ZEPPELIN_HOME/interpreter/jdbc/ \
    && cp $HADOOP_HOME/share/hadoop/common/hadoop-common-*.jar $ZEPPELIN_HOME/interpreter/jdbc/ \
    && rm $ZEPPELIN_HOME/interpreter/jdbc/hadoop-common-*-tests.jar

RUN cp $ZEPPELIN_HOME/conf/zeppelin-env.sh.template $ZEPPELIN_HOME/conf/zeppelin-env.sh \
    && echo "export ZEPPELIN_HOME=$ZEPPELIN_HOME" >> ~/.bash_profile \
    && echo "export PATH=\$PATH:\$ZEPPELIN_HOME/bin" >> ~/.bash_profile \
    && echo "export PYSPARK_PYTHON=/usr/bin/python" >> $ZEPPELIN_HOME/conf/zeppelin-env.sh


COPY docker-entrypoint.sh /

WORKDIR ${ZEPPELIN_HOME}

EXPOSE $ZEPPELIN_PORT

ENTRYPOINT ["/docker-entrypoint.sh"]