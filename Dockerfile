FROM ubuntu:18.04

RUN apt update && apt install -y git autoconf libtool libglib2.0-dev pkg-config gengetopt

COPY --from=libconfig:1.7.3 /root/dist/. /usr/
COPY --from=openssl:3.0.1 /root/dist/. /usr/
COPY --from=libjansson:2.14 /root/dist/. /usr/
COPY --from=libnice:0.1.18 /root/dist/. /usr/
COPY --from=libsrtp:2.4.2 /root/dist/. /usr/
COPY --from=libusrsctp:0.9.5.0 /root/dist/. /usr/
COPY --from=libmicrohttpd:0.9.75 /root/dist/. /usr/
COPY --from=libwebsockets:4.3.1 /root/dist/. /usr/
COPY --from=librabbitmq:0.11.0 /root/dist/. /usr/
COPY --from=libpaho-mqtt:1.3.9 /root/dist/. /usr/
COPY --from=libnanomsg:1.1.5 /root/dist/. /usr/
COPY --from=libcurl:7.81.0 /root/dist/. /usr/
COPY --from=libsofia-sip-ua:1.13.7 /root/dist/. /usr/
COPY --from=libopus:1.3.1 /root/dist/. /usr/
COPY --from=libogg:1.3.5 /root/dist/. /usr/

RUN git clone --branch v0.11.8 --depth 1 https://github.com/meetecho/janus-gateway.git ~/source

RUN cd ~/source \
    && sh autogen.sh \
    # && ./configure \
    # && make \
    # # test ?
    # && make install
    echo 'WIP!'
