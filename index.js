const express = require("express");
const app = express();
const port = 3000;

app.use(express.static("janus-gateway/html"));

app.listen(port, () => {
    console.log(`Test webserver listening on port ${port}`);
});
