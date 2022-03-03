FROM ubuntu:18.04

RUN apt update && apt install -y git make autoconf libtool

COPY --from=openssl:3.0.1 /root/dist/. /usr/

RUN git clone --branch curl-7_81_0 --depth 1 https://github.com/curl/curl.git ~/source

RUN cd ~/source \
    && autoreconf -fi \
    && ./configure --with-openssl \
    && make \
    && make test \
    && make install

RUN rm -rf ~/dist \
    && mkdir -p ~/dist/lib \
    && cp -P /usr/local/lib/libcurl.* ~/dist/lib/ \
    && cp -rH /usr/local/include/curl ~/dist/include/
