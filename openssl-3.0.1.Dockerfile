FROM ubuntu:18.04

RUN apt update && apt install -y git make gcc

RUN git clone --branch openssl-3.0.1 --depth 1 https://github.com/openssl/openssl.git ~/source

RUN cd ~/source \
    && perl Configure \
    && make \
    && make test \
    && make install

RUN rm -rf ~/dist \
    && mkdir -p ~/dist/lib \
    && mkdir -p ~/dist/include \
    && cp -P /usr/local/lib64/libssl.* ~/dist/lib/ \
    && cp -P /usr/local/lib64/libcrypto.* ~/dist/lib/ \
    && cp -rH /usr/local/include/openssl ~/dist/include/
