FROM debian:12-slim

RUN mkdir /logs /scripts /default-server /data
COPY ./scripts /scripts
COPY ./server.tar.gz /default-server/server.tar.gz
COPY ./usr /usr
RUN chmod -R 777 /scripts

RUN echo '/usr/local/lib' >>/etc/ld.so.conf
RUN ldconfig
ENTRYPOINT ["/scripts/entrypoint.sh"]

