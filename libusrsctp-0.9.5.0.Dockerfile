FROM ubuntu:18.04

RUN apt update && apt install -y git cmake

RUN git clone --branch 0.9.5.0 --depth 1 https://github.com/sctplab/usrsctp.git ~/source

RUN mkdir ~/builddir \
    && cd ~/builddir \
    && cmake ~/source \
    && make \
    # No test?
    && make install

RUN rm -rf ~/dist \
    && mkdir -p ~/dist/lib \
    && mkdir -p ~/dist/include \
    && cp -P /usr/local/lib/libusrsctp.* ~/dist/lib/ \
    && cp /usr/local/include/usrsctp.* ~/dist/include/
