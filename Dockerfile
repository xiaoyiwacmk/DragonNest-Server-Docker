FROM debian:12-slim
RUN apt update
RUN apt install -y zip
RUN apt install -y mysql-client

RUN mkdir /logs /scripts  /data
COPY ./scripts /scripts
COPY ./server.zip /server.zip
COPY ./usr /usr
RUN chmod -R 777 /scripts

RUN echo '/usr/local/lib' >>/etc/ld.so.conf
RUN ldconfig
ENTRYPOINT ["/scripts/entrypoint.sh"]

