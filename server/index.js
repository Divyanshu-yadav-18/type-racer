const express = require("express");
const http = require("http");
const mongoose = require("mongoose");

const app = express();
const port = 3000;

var server = http.createServer(app);

app.use(express.json());

const dB = `mongodb+srv://ryuk:${mongo_password}@cluster0.eor9i.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0`;

mongoose
  .connect(dB)
  .then(() => {
    console.log("connection Successful");
  })
  .catch((e) => {
    console.log(e);
  });

server.listen(port, "0.0.0.0", () => {
  console.log("server started");
});
