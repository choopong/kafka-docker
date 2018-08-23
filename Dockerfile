FROM openjdk:8
ENV KAFKA_FILENAME kafka_2.11-1.1.1.tgz
ENV APP_DIR /app/
ENV KAFKA_DIR kafka/
ADD http://www-us.apache.org/dist/kafka/1.1.1/${KAFKA_FILENAME} /tmp
RUN mkdir -p ${APP_DIR} && \
    tar -xvf /tmp/${KAFKA_FILENAME} -C ${APP_DIR} && \
    rm /tmp/${KAFKA_FILENAME} && \
    cd ${APP_DIR} && \
    mv $(ls) ${KAFKA_DIR}
COPY config/server.properties ${KAFKA_DIR}config/server.properties  
WORKDIR ${APP_DIR}${KAFKA_DIR}
EXPOSE 9092
ENTRYPOINT [ "/bin/bash","-c" ]
CMD [ "(bin/zookeeper-server-start.sh config/zookeeper.properties &) ; (bin/kafka-server-start.sh config/server.properties)" ]