# 0: server -	/bin/bash

cd webserver
git clone https://github.com/meetecho/janus-gateway.git
npm init -y
npm i express

openssl genrsa 2048 > root.key
openssl req -new -x509 -nodes -sha256 -days 365 -key root.key -out root.crt

node index



# 1: main? -	/bin/bash

docker run -dit --name=janus-test -v $(pwd)/config/test:/root/janus/etc/janus:ro -p 0.0.0.0:8088:8088 -p 0.0.0.0:8188:8188 -p 7088:7088 -p 0.0.0.0:65200-65300:65200-65300 janus-test:0.0.2
docker logs janus-test --tail=10 --follow
