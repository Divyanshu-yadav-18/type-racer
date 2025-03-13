import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tyrace/Pages/create_room_screan.dart';
import 'package:tyrace/Pages/game_screen.dart';
import 'package:tyrace/Pages/home_page.dart';
import 'package:tyrace/Pages/join_room_screen.dart';
import 'package:tyrace/providers/game_state_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GameStateProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const MyHomePage(),
          '/create-room': (context) => const CreateRoomScrean(),
          '/join-room': (context) => const JoinRoomScreen(),
          '/game-screen': (context) => const GameScreen(),
        },
      ),
    );
  }
}
