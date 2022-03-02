FROM ubuntu:18.04

RUN apt update && apt install -y git cmake g++

COPY --from=openssl:3.0.1 /root/dist/. /usr/

RUN git clone --branch v4.3.1 --depth 1 https://github.com/warmcat/libwebsockets.git ~/source

RUN mkdir ~/builddir \
    && cd ~/builddir \
    && cmake ~/source -DCMAKE_INSTALL_PREFIX:PATH=~/tmp \
    && make \
    && make install

RUN rm -rf ~/dist \
    && cp -rH ~/tmp/lib ~/dist/ \
    && cp -rH ~/tmp/include ~/dist/
