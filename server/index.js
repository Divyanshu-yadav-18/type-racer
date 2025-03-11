const { Socket } = require("dgram");
const express = require("express");
const http = require("http");
const mongoose = require("mongoose");
require("dotenv").config();

const app = express();
const port = 3000;

var server = http.createServer(app);

var io = require("socket.io")(server);

app.use(express.json());

const dB = process.env.MONGO_URI;

io.on("connection", (socket) => {
  console.log(socket.id);

  socket.on("create-game", async (data) => {
    try {
    } catch (e) {
      console.log(e);
    }
  });
});

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
