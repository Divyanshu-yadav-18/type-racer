const express = require("express");
const http = require("http");
const mongoose = require("mongoose");

const app = express();
const port = 3000;

var server = http.createServer(app);

server.listen(port, "0.0.0.0", () => {
  console.log("server started");
});
