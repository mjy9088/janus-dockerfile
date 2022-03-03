FROM ubuntu:18.04

RUN apt update && apt install -y git make autoconf libtool check

COPY --from=openssl:3.0.1 /root/dist/. /usr/

RUN git clone --branch v1.13.7 --depth 1 https://github.com/freeswitch/sofia-sip.git ~/source

RUN cd ~/source \
    && sh autogen.sh \
    && ./configure \
    && make \
    # # test fail?
    # && make check \
    && make install

RUN rm -rf ~/dist \
    && mkdir -p ~/dist/lib \
    && cp -P /usr/local/lib/libsofia-sip-ua.* ~/dist/lib/ \
    && cp -rH /usr/local/include/sofia-sip-1.13 ~/dist/include
