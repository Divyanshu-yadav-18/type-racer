import 'package:flutter/material.dart';
import 'package:tyrace/utils/socket_methods.dart';
import 'package:tyrace/widgets/custom_button.dart';
import 'package:tyrace/widgets/custom_text_field.dart';

class CreateRoomScrean extends StatefulWidget {
  const CreateRoomScrean({super.key});

  @override
  State<CreateRoomScrean> createState() => _CreateRoomScreamState();
}

class _CreateRoomScreamState extends State<CreateRoomScrean> {
  final TextEditingController _nameController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.updateGameListener(context);
    _socketMethods.notCorrectGameListener(context);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 600,
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Create Room',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: size.height * 0.08,
                ),
                CustomTextField(
                  controller: _nameController,
                  hintText: 'Enter Name',
                ),
                CustomButton(
                  text: 'Create',
                  onTap: () => _socketMethods.createGame(
                    _nameController.text,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
