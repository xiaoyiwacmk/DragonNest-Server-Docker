FROM ubuntu:24.04
RUN apt update

RUN mkdir -p /logs /scripts /data
COPY ./scripts /scripts
COPY ./data /data
COPY ./usr /usr
RUN find /scripts -type f -exec chmod +x {} \;

RUN echo '/usr/local/lib' >>/etc/ld.so.conf
RUN ldconfig
ENTRYPOINT ["/scripts/entrypoint.sh"]

