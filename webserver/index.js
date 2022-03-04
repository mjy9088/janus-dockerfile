var fs = require("fs");
var http = require("http");
var https = require("https");

var privateKey = fs.readFileSync("root.key", "utf8");
var certificate = fs.readFileSync("root.crt", "utf8");

var credentials = { key: privateKey, cert: certificate };
var express = require("express");
var app = express();

app.use("/static", express.static("janus-gateway/html"));

const WEB_PORT = 3000;
// for http, use `var httpServer = http.createServer(app);`
var httpsServer = https.createServer(credentials, app);
httpsServer.listen(WEB_PORT, () => {
    console.log(`web: listening on https://localhost:${WEB_PORT}`);
});

const JANUS_PORT = 8089;
https.createServer(credentials, onRequest).listen(JANUS_PORT, () => {
    console.log(`janus: listening on https://localhost:${JANUS_PORT}`);
});
function onRequest(client_req, client_res) {
    console.log("serve: " + client_req.url);

    var options = {
        hostname: "localhost",
        port: 8088,
        path: client_req.url,
        method: client_req.method,
        headers: client_req.headers,
    };

    var proxy = http.request(options, function (res) {
        client_res.writeHead(res.statusCode, res.headers);
        res.pipe(client_res, {
            end: true,
        });
    });

    client_req.pipe(proxy, {
        end: true,
    });
}
