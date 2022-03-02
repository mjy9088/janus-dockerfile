FROM ubuntu:18.04

RUN apt update && apt install -y git make libtool autoconf texinfo libcurl4-openssl-dev

# unofficial mirror
RUN git clone --branch v0.9.75 --depth 1 https://github.com/Karlson2k/libmicrohttpd.git ~/source

RUN cd ~/source \
    && ./bootstrap \
    && ./configure \
    && make \
    && make check \
    && make install

RUN rm -rf ~/dist \
    && mkdir -p ~/dist/lib \
    && mkdir -p ~/dist/include \
    && cp -P /usr/local/lib/libmicrohttpd.* ~/dist/lib/ \
    && cp /usr/local/include/microhttpd.h ~/dist/include/
