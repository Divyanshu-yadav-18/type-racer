import 'package:flutter/material.dart';
import 'package:tyrace/Pages/create_room_scream.dart';
import 'package:tyrace/Pages/home_page.dart';
import 'package:tyrace/Pages/join_room_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/create-room': (context) => const CreateRoomScream(),
        '/join-room': (context) => const JoinRoomScreen(),
      },
    );
  }
}
