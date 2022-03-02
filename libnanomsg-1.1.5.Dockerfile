FROM ubuntu:18.04

RUN apt update && apt install -y git cmake

RUN git clone --branch 1.1.5 --depth 1 https://github.com/nanomsg/nanomsg.git ~/source

RUN mkdir ~/builddir \
    && cd ~/builddir \
    && cmake ~/source -DCMAKE_INSTALL_PREFIX:PATH=~/tmp -DCMAKE_INSTALL_LIBDIR=lib \
    && make \
    && make test \
    && make install

RUN rm -rf ~/dist \
    && mkdir -p ~/dist/lib \
    && cp -rH ~/tmp/lib/libnanomsg.* ~/dist/lib/ \
    && cp -rH ~/tmp/include ~/dist/
