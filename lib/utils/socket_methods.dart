import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tyrace/providers/client_state_provider.dart';
import 'package:tyrace/providers/game_state_provider.dart';
import 'package:tyrace/utils/socket_client.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;
  bool _isPlaying = false;

  createGame(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('create-game', {
        'nickname': nickname,
      });
    }
  }

  joinGame(String gameId, String nickname) {
    if (nickname.isNotEmpty && gameId.isNotEmpty) {
      _socketClient.emit('join-game', {
        'nickname': nickname,
        'gameId': gameId,
      });
    }
  }

  sendUserInput(String value, String gameID) {
    _socketClient.emit('userInput', {
      'userInput': value,
      'gameID': gameID,
    });
  }

//listeners
  updateGameListener(BuildContext context) {
    _socketClient.on('updateGame', (data) {
      final gameStateProvider =
          Provider.of<GameStateProvider>(context, listen: false)
              .updateGameState(
        id: data['_id'],
        players: data['players'],
        isJoin: data['isJoin'],
        isOver: data['isOver'],
        words: data['words'],
      );

      if (data['_id'].isNotEmpty && !_isPlaying) {
        Navigator.pushNamed(context, '/game-screen');
        _isPlaying = true;
      }
    });
  }

  startTimer(playerId, gameId) {
    _socketClient.emit(
      'timer',
      {
        'playerId': playerId,
        'gameID': gameId,
      },
    );
  }

  notCorrectGameListener(BuildContext context) {
    _socketClient.on(
      'notCorrectGame',
      (data) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data),
        ),
      ),
    );
  }

  updateTimer(BuildContext context) {
    final clientStateProvider =
        Provider.of<ClientStateProvider>(context, listen: false);
    _socketClient.on('timer', (data) {
      clientStateProvider.setClientState(data);
    });
  }

  updateGame(BuildContext context) {
    _socketClient.on('updateGame', (data) {
      final gameStateProvider =
          Provider.of<GameStateProvider>(context, listen: false)
              .updateGameState(
        id: data['_id'],
        players: data['players'],
        isJoin: data['isJoin'],
        isOver: data['isOver'],
        words: data['words'],
      );
    });
  }

  gameFinishedListener() {
    _socketClient.on(
      'done',
      (data) => _socketClient.off('timer'),
    );
  }
}
