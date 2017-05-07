FROM centos:7

ENV SRC=https://downloads.sourceforge.net/project/opensearchserve/Stable_release/1.5.14/opensearchserver-1.5.14-d0d167e.tar.gz

RUN yum install -y java && \
    useradd -M oss -d /home/opensearchserver && \
    curl -L $SRC > /home/oss.tar.gz && \
    tar -xvzf /home/oss.tar.gz -C /home && \
    rm -f /home/oss.tar.gz && \
    chown -R oss:oss /home/opensearchserver

EXPOSE 9090

USER oss
WORKDIR /home/opensearchserver

ENV LANG=en_US.UTF-8 \
    JAVA_OPTS='-Dfile.encoding=UTF-8 -Djava.protocol.handler.pkgs=jcifs' \
    OPENSEARCHSERVER_DATA=data \
    SERVER_PORT=9090 \
    MEMORY_OPTS=''

CMD /usr/bin/java $JAVA_OPTS $MEMORY_OPTS -jar opensearchserver.jar -extractDirectory server -httpPort $SERVER_PORT -uriEncoding UTF-8
