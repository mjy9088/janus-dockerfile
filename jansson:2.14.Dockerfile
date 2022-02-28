FROM ubuntu:18.04

RUN apt update && apt install -y git autoconf libtool make

RUN git clone --branch v2.14 --depth 1 https://github.com/akheron/jansson.git ~/source

RUN cd ~/source \
    && autoreconf -i \
    && ./configure \
    && make \
    && make check \
    && make install

RUN rm -rf ~/dist \
    && mkdir -p ~/dist/lib \
    && mkdir -p ~/dist/include \
    && cp -P /usr/local/lib/libjansson.* ~/dist/lib/ \
    && cp -rH /usr/local/include/jansson*.h ~/dist/include
