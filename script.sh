#!/bin/sh

# ! WIP

docker build -t libconfig:1.7.3 - < libconfig-1.7.3.Dockerfile
docker build -t openssl:3.0.1 - < openssl-3.0.1.Dockerfile
docker build -t libjansson:2.14 - < libjansson-2.14.Dockerfile
docker build -t libnice:0.1.18 - < libnice-0.1.18.Dockerfile
docker build -t libsrtp:2.4.2 - < libsrtp-2.4.2.Dockerfile
docker build -t libusrsctp:0.9.5.0 - < libusrsctp-0.9.5.0.Dockerfile
docker build -t libmicrohttpd:0.9.75 - < libmicrohttpd-0.9.75.Dockerfile
docker build -t libwebsockets:4.3.1 - < libwebsockets-4.3.1.Dockerfile
docker build -t librabbitmq:0.11.0 - < librabbitmq-0.11.0.Dockerfile
docker build -t libpaho-mqtt:1.3.9 - < libpaho-mqtt-1.3.9.Dockerfile
docker build -t libnanomsg:1.1.5 - < libnanomsg-1.1.5.Dockerfile
docker build -t libcurl:7.81.0 - < libcurl-7.81.0.Dockerfile
docker build -t libsofia-sip-ua:1.13.7 - < libsofia-sip-ua-1.13.7.Dockerfile
docker build -t libopus:1.3.1 - < libopus-1.3.1.Dockerfile
docker build -t libogg:1.3.5 - < libogg-1.3.5.Dockerfile
# lua?
# duktape?

docker build -t janus-test:0.0.2-wip .
