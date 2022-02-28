#!/bin/sh

docker build -t openssl:3.0.1 - < openssl-3.0.1.Dockerfile
docker build -t jansson:2.14 - < jansson-2.14.Dockerfile
docker build -t nice:0.1.18 - < nice-0.1.18.Dockerfile
docker build -t srtp:2.4.2 - < srtp-2.4.2.Dockerfile
