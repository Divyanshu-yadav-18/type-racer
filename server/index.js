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
  socket.on("create-game", async ({ nickname }) => {
    try {
      let game = new Game();
      const sentence = await getSentence();
      game.words = sentence;

      let player = {
        socketID: socket.id,
        nickname,
        isPartyLeader: true,
      };
      game.players.push(player);
      game = await game.save();

      const gameId = game._id.toString();
      socket.join(gameId);
      io.to(gameId).emit("updateGame", game);
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
