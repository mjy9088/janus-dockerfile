FROM ubuntu:18.04

RUN apt update \
    && apt install -y git python3 python3-pip ninja-build \
        libglib2.0-dev pkg-config libssl-dev libgupnp-igd-1.0-dev libgstreamer1.0-dev \
    && pip3 install meson

COPY --from=libjansson:2.14 /root/dist/. /usr/

RUN git clone --branch 0.1.18 --depth 1 https://github.com/libnice/libnice.git ~/source

RUN cd ~/source \
    && meson --libdir=/usr/local/lib builddir \
    && ninja -C builddir \
    && ninja -C builddir test \
    && ninja -C builddir install

RUN rm -rf ~/dist \
    && mkdir -p ~/dist/lib/pkgconfig \
    && mkdir -p ~/dist/include \
    && cp -P /usr/local/lib/libnice.* ~/dist/lib/ \
    && cp -P /usr/local/lib/pkgconfig/nice.pc ~/dist/lib/pkgconfig/ \
    && cp -rH /usr/local/include/nice ~/dist/include/
