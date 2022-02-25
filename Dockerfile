FROM ubuntu:18.04

# following instructions on https://facsiaginsa.com/janus/install-janus-webrtc-server-on-ubuntu

RUN apt update

RUN apt install -y libmicrohttpd-dev libjansson-dev \
    libssl-dev libsofia-sip-ua-dev libglib2.0-dev \
    libopus-dev libogg-dev libcurl4-openssl-dev liblua5.3-dev \
    libconfig-dev pkg-config gengetopt libtool automake \
    wget git python3 python3-pip make cmake ninja-build \
    && pip3 install meson

# install libnice
RUN mkdir -p ~/tmp_install && cd ~/tmp_install \
    && git clone https://gitlab.freedesktop.org/libnice/libnice.git \
    && cd libnice \
    && meson --prefix=/usr build \
    && ninja -C build \
    && ninja -C build install

# install libsrtp
RUN mkdir -p ~/tmp_install && cd ~/tmp_install \
    && apt remove --purge libsrtp* \
    && wget https://github.com/cisco/libsrtp/archive/v2.2.0.tar.gz \
    && tar xfv v2.2.0.tar.gz \
    && cd libsrtp-2.2.0 \
    && ./configure --prefix=/usr --enable-openssl \
    && make shared_library \
    && make install

# install usrsctp
RUN mkdir -p ~/tmp_install && cd ~/tmp_install \
    && git clone https://github.com/sctplab/usrsctp \
    && cd usrsctp \
    && ./bootstrap \
    && ./configure --prefix=/usr --disable-programs --disable-inet --disable-inet6 \
    && make \
    && make install

# install libwebsockets
RUN mkdir -p ~/tmp_install && cd ~/tmp_install \
    && git clone https://github.com/warmcat/libwebsockets.git \
    && cd libwebsockets \
    && git checkout v3.2-stable \
    && mkdir build \
    && cd build \
    && cmake -DLWS_MAX_SMP=1 -DLWS_WITHOUT_EXTENSIONS=0 -DCMAKE_INSTALL_PREFIX:PATH=/usr -DCMAKE_C_FLAGS="-fpic" .. \
    && make \
    && make install

# install janus_gateway
RUN mkdir -p ~/tmp_install && cd ~/tmp_install \
    && git clone https://github.com/meetecho/janus-gateway.git \
    && cd janus-gateway \
    && sh autogen.sh \
    && ./configure --prefix=/opt/janus \
    && make \
    && make install \
    && make configs

CMD /opt/janus/bin/janus -d7
