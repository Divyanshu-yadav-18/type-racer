const { Socket } = require("dgram");
const express = require("express");
const http = require("http");
const mongoose = require("mongoose");
require("dotenv").config();

const Game = require("./models/game");
const getSentence = require("./api/getSentences");
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
      let game = new Game();
      const sentence = await getSentence();
      game.words = sentence;
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
