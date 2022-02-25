# 0: server -	/bin/bash
git clone https://github.com/meetecho/janus-gateway.git
npm init -y
npm i express
node index

# 1: main? -	/bin/bash
docker run -dit --name=janus-test --rm -p 0.0.0.0:8088:8088 -p 0.0.0.0:8188:8188 janus-test:0.0.1
docker logs janus-test --tail --follow
