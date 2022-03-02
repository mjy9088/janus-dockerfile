FROM ubuntu:18.04

RUN apt update && apt install -y git make gcc

COPY --from=openssl:3.0.1 /root/dist/. /usr/

RUN git clone --branch v2.4.2 --depth 1 https://github.com/cisco/libsrtp.git ~/source

RUN ls -l /usr/local/lib && sleep 10

RUN cd ~/source \
    && ./configure --enable-openssl --enable-nss \
    && make \
    && make runtest \
    && make install

RUN rm -rf ~/dist \
    && mkdir -p ~/dist/lib \
    && mkdir -p ~/dist/include \
    && cp -P /usr/local/lib/libsrtp2.* ~/dist/lib/ \
    && cp -rH /usr/local/include/srtp2 ~/dist/include/
