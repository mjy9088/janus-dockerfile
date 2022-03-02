FROM ubuntu:18.04

RUN apt update && apt install -y git cmake g++

RUN git clone --branch v1.7.3 --depth 1 https://github.com/hyperrealm/libconfig.git ~/source

RUN mkdir ~/builddir \
    && cd ~/builddir \
    && cmake ~/source \
    && make \
    && make test \
    && make install

RUN rm -rf ~/dist \
    && mkdir -p ~/dist/lib \
    && mkdir -p ~/dist/include \
    && cp -P /usr/local/lib/libconfig.* ~/dist/lib/ \
    && cp -P /usr/local/lib/libconfig++.* ~/dist/lib/ \
    && cp /usr/local/include/libconfig.* ~/dist/include/
