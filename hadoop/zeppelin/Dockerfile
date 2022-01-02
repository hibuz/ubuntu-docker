# == Info =======================================
# hibuz/bash==hibuz/hadoop-base(SIZE: 295MB) -> hibuz/zeppelin-dev(SIZE: 2.79GB)

# == Build ======================================
# docker build -t hibuz/zeppelin-dev .
# or
# docker build -t hibuz/zeppelin-dev --build-arg ZEPPELIN_VERSION=0.10.0 .

# == Run and Attatch ============================
# docker run --rm -it -p 9995:9995 -p 18080:18080 --name zeppelin-tmp hibuz/zeppelin-dev
# 
# docker exec -it zeppelin-tmp bash


# == Init =======================================
FROM hibuz/hadoop-base

# == Package Setting ============================
ARG JDK_VERSION=8
RUN sudo apt-get update && DEBIAN_FRONTEND=noninteractive sudo apt-get install -y --no-install-recommends \
      openjdk-${JDK_VERSION}-jdk python3 python3-pip \
      ssh \
      netcat \
      libsnappy-dev \
    && sudo rm -rf /var/lib/apt/lists/*

# == Install ============================
ARG SPARK_VERSION=3.1.2
RUN set -x \
    && DOWNLOAD_URL="https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.2.tgz" \
    && curl -fSL "$DOWNLOAD_URL" -o download.tar.gz \
    && tar -xvf download.tar.gz \
    && mv spark-${SPARK_VERSION}-bin* spark-${SPARK_VERSION} \
    && mkdir /tmp/spark-events \
    && rm download.tar.gz

ARG ZEPPELIN_VERSION=0.10.0
RUN set -x \
    && DOWNLOAD_URL="https://dlcdn.apache.org/zeppelin/zeppelin-${ZEPPELIN_VERSION}/zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz" \
    && curl -fSL "$DOWNLOAD_URL" -o download.tar.gz \
    && tar -xvf download.tar.gz \
    && mv zeppelin-${ZEPPELIN_VERSION}-bin-all zeppelin-${ZEPPELIN_VERSION} \
    && rm download.tar.gz

# == Env Setting ============================
ARG DEFAULT_USER=hadoop
ENV SPARK_HOME /home/${DEFAULT_USER}/spark-${SPARK_VERSION}
ENV ZEPPELIN_HOME /home/${DEFAULT_USER}/zeppelin-${ZEPPELIN_VERSION}
ENV ZEPPELIN_ADDR 0.0.0.0
ENV ZEPPELIN_PORT 9995
ENV PATH $PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin:$ZEPPELIN_HOME/bin

RUN sudo ln -s /usr/bin/python3 /usr/bin/python

EXPOSE $ZEPPELIN_PORT

ENTRYPOINT $SPARK_HOME/sbin/start-history-server.sh; $ZEPPELIN_HOME/bin/zeppelin-daemon.sh start && bash