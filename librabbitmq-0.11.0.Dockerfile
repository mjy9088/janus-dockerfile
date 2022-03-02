FROM ubuntu:18.04

RUN apt update && apt install -y git cmake

COPY --from=openssl:3.0.1 /root/dist/. /usr/

RUN git clone --branch v0.11.0 --depth 1 https://github.com/alanxz/rabbitmq-c.git ~/source

RUN mkdir ~/builddir \
    && cd ~/builddir \
    && cmake ~/source -DCMAKE_INSTALL_PREFIX:PATH=~/tmp -DCMAKE_INSTALL_LIBDIR=lib \
    && make \
    && make test \
    && make install

RUN rm -rf ~/dist \
    && mkdir -p ~/dist/lib \
    && cp -P ~/tmp/lib/librabbitmq.* ~/dist/lib/ \
    && cp -rH ~/tmp/include ~/dist/
