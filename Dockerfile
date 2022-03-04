FROM ubuntu:18.04

# command: docker build -t janus-test:0.0.2 .


# install dependencies
RUN apt update && apt install -y \
    libjansson-dev \
    libconfig-dev \
    libnice-dev \
    libssl-dev \
    libmicrohttpd-dev \
    librabbitmq-dev \
    libnanomsg-dev \
    libcurl4-openssl-dev \
    libsofia-sip-ua-dev \
    libopus-dev \
    libogg-dev \
    liblua5.3-dev \
    libglib2.0-dev \
    zlib1g-dev \
    pkg-config \
    gengetopt \
    # # to build missing dependencies
    git cmake g++ autoconf libtool

# install libpaho-mqtt-dev alternative
RUN git clone --branch v1.3.9 --depth 1 https://github.com/eclipse/paho.mqtt.c.git ~/libpaho-mqtt-dev-source \
    && mkdir ~/libpaho-mqtt-dev-builddir \
    && cd ~/libpaho-mqtt-dev-builddir \
    && cmake ~/libpaho-mqtt-dev-source -DPAHO_WITH_SSL=true \
    && make \
    # # Test fail?
    # && make test \
    && make install

# install libusrsctp-dev alternative
RUN git clone --branch 0.9.5.0 --depth 1 https://github.com/sctplab/usrsctp.git ~/libusrsctp-dev-source \
    && mkdir ~/libusrsctp-dev-builddir \
    && cd ~/libusrsctp-dev-builddir \
    && cmake ~/libusrsctp-dev-source \
    && make \
    # # No test?
    && make install

# install libwebsockets-dev newer version
RUN git clone --branch v4.3.1 --depth 1 https://github.com/warmcat/libwebsockets.git ~/libwebsockets-dev-source \
    && mkdir ~/libwebsockets-dev-builddir \
    && cd ~/libwebsockets-dev-builddir \
    && cmake ~/libwebsockets-dev-source \
    && make \
    && make install

# install libsrtp2-dev with openssl
RUN git clone --branch v2.4.2 --depth 1 https://github.com/cisco/libsrtp.git ~/libsrtp2-dev \
    && cd ~/libsrtp2-dev \
    && ./configure --enable-openssl --enable-nss \
    && make \
    && make runtest \
    && make install


# install janus-gateway
RUN git clone --branch v0.11.8 --depth 1 https://github.com/meetecho/janus-gateway.git ~/janus-gateway \
    && cd ~/janus-gateway \
    && sh autogen.sh \
    && ./configure --prefix=/root/janus \
    && make \
    && make install

CMD /root/janus/bin/janus -d5
