FROM antrea/ubuntu:24.04
ARG OPENSSL_VERSION=1.0.2u
RUN apt update
RUN apt install -y zip wget libcurl4 mariadb-client
RUN apt install -y screen build-essential

RUN mkdir /logs /scripts  /data
COPY ./scripts /scripts
COPY ./server.zip /server.zip
COPY ./usr /usr
COPY ./lib/openssl-$OPENSSL_VERSION.tar.gz /openssl-$OPENSSL_VERSION.tar.gz

# chmod scripts
RUN chmod -R 777 /scripts

# for basic lib
RUN cp /usr/lib64/* /usr/local/lib
RUN echo '/usr/local/lib' >>/etc/ld.so.conf

# for openssl 1.0.0
RUN tar -xzf openssl-$OPENSSL_VERSION.tar.gz
WORKDIR /openssl-$OPENSSL_VERSION
RUN ./config --prefix=/usr/local/openssl --shared
RUN make -j4
RUN make install
RUN echo '/usr/local/openssl/lib' >>/etc/ld.so.conf
RUN ln -s /usr/local/openssl/lib/libssl.so.1.0.0 /usr/lib/x86_64-linux-gnu/libssl.so.10
RUN ln -s /usr/local/openssl/lib/libcrypto.so.1.0.0 /usr/lib/x86_64-linux-gnu/libcrypto.so.10

RUN apt remove -y build-essential
RUN apt autoclean

RUN ldconfig
WORKDIR /
ENTRYPOINT ["/scripts/entrypoint.sh"]

