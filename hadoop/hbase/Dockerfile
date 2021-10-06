# == Info =======================================
# hibuz/hadoop-dev(SIZE: 1.98GB) -> hibuz/hbase-dev(SIZE: 2.36GB)

# == Build ======================================
# docker build -t hibuz/hbase-dev .
# or
# docker build -t hibuz/hbase-dev --build-arg HBASE_VERSION=2.4.6 .

# == Run and Attatch ============================
# docker run --rm -it -p 9870:9870 -p 16010:16010 --name hbase-tmp hibuz/hbase-dev
# 
# docker exec -it hbase-tmp bash


# == Init =======================================
FROM hibuz/hadoop-dev
ARG HBASE_VERSION=2.4.6

# == Install ============================
RUN set -x \
    && DOWNLOAD_URL="https://archive.apache.org/dist/hbase/${HBASE_VERSION}/hbase-${HBASE_VERSION}-bin.tar.gz" \
    && curl -fSL "$DOWNLOAD_URL" -o download.tar.gz \
    && tar -xvf download.tar.gz \
    && rm download.tar.gz

# == Env Setting ============================
ARG DEFAULT_USER=hadoop
ENV HBASE_HOME /home/${DEFAULT_USER}/hbase-${HBASE_VERSION}
ENV PATH $PATH:$HBASE_HOME/bin

RUN echo "export HBASE_HOME=$HBASE_HOME" >> ~/.bash_profile \
    && echo "export PATH=\"\$PATH\":\$HBASE_HOME/bin" >> ~/.bash_profile \
    && echo "export HBASE_DISABLE_HADOOP_CLASSPATH_LOOKUP=\"true\"" >> $HBASE_HOME/conf/hbase-env.sh

RUN hbase_conf="<property><name>hbase.rootdir</name><value>hdfs://localhost:9000/hbase</value></property>" \
    && escaped_hbase_conf=$(echo $hbase_conf | sed 's/\//\\\//g') \
    && sed -i "/<\/configuration>/ s/.*/${escaped_hbase_conf}&/" $HBASE_HOME/conf/hbase-site.xml

COPY docker-entrypoint.sh /

WORKDIR ${HBASE_HOME}

EXPOSE 2181 16000 16010 16020 16030

ENTRYPOINT ["/docker-entrypoint.sh"]