FROM ubuntu:18.04

RUN apt update && apt install -y git make autoconf libtool

RUN git clone --branch v1.3.5 --depth 1 https://gitlab.xiph.org/xiph/ogg.git ~/source

RUN cd ~/source \
    && autoreconf -i \
    && ./configure \
    && make \
    && make check \
    && make install

RUN rm -rf ~/dist \
    && mkdir -p ~/dist/lib \
    && mkdir -p ~/dist/include \
    && cp -P /usr/local/lib/libogg.* ~/dist/lib/ \
    && cp -rH /usr/local/include/ogg ~/dist/include/
