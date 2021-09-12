# == Info =======================================
# hibuz/hadoop-dev(SIZE: 1.98GB) -> hibuz/hive-dev(SIZE: 2.3GB)

# == Build ======================================
# docker build -t hibuz/hive-dev .
# or
# docker build -t hibuz/hive-dev --build-arg HIVE_VERSION=3.1.2 .

# == Run and Attatch ============================
# docker run --rm -it -p 9870:9870 -p 10002:10002 --name hive-tmp hibuz/hive-dev
# 
# docker exec -it hive-tmp bash


# == Init =======================================
FROM hibuz/hadoop-dev

# == Hive Install ============================
ARG HIVE_VERSION=3.1.2
RUN set -x \
    && HIVE_URL="https://downloads.apache.org/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz" \
    && curl -fSL "$HIVE_URL" -o hive.tar.gz \
    && tar -xvf hive.tar.gz \
    && mv apache-hive-${HIVE_VERSION}-bin hive-${HIVE_VERSION} \
    && rm hive.tar.gz

# == Hive Env Setting ============================
ARG DEFAULT_USER=hadoop
ENV HIVE_HOME /home/${DEFAULT_USER}/hive-${HIVE_VERSION}
ENV PATH $PATH:$HIVE_HOME/bin

# https://issues.apache.org/jira/browse/HIVE-22915
RUN rm $HIVE_HOME/lib/guava-19.0.jar \
    && cp $HADOOP_HOME/share/hadoop/hdfs/lib/guava-27.0-jre.jar $HIVE_HOME/lib/ 

RUN cp $HIVE_HOME/conf/hive-env.sh.template $HIVE_HOME/conf/hive-env.sh \
    && cp $HIVE_HOME/conf/hive-default.xml.template $HIVE_HOME/conf/hive-default.xml \
    && echo "export HIVE_HOME=$HIVE_HOME" >> ~/.bash_profile \
    && echo "export PATH=\"\$PATH\":\$HIVE_HOME/bin" >> ~/.bash_profile \
    && echo "export HADOOP_HEAPSIZE=512" >> $HIVE_HOME/conf/hive-env.sh

RUN core_conf="<property><name>hadoop.proxyuser.${DEFAULT_USER}.hosts</name><value>*</value></property>\
            <property><name>hadoop.proxyuser.${DEFAULT_USER}.groups</name><value>*</value></property>" \
    && escaped_core_conf=$(echo $core_conf | sed 's/\//\\\//g') \
    && sed -i "/<\/configuration>/ s/.*/${escaped_core_conf}&/" $HADOOP_CONF_DIR/core-site.xml


COPY docker-entrypoint.sh /

WORKDIR ${HIVE_HOME}

EXPOSE 10002

ENTRYPOINT ["/docker-entrypoint.sh"]