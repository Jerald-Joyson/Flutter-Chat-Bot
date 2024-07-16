import 'package:flutter/material.dart';

import '../controller/chat_controller.dart';

class AlertDialogBox extends StatelessWidget {
  const AlertDialogBox({
    super.key,
    required this.editController,
    required this.controller,
    required this.sessionId,
  });

  final TextEditingController editController;
  final ChatController controller;
  final String sessionId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Rename Session'),
      content: TextField(
        controller: editController,
        decoration: const InputDecoration(
          hintText: 'Enter new session name',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            controller.renameSession(sessionId, editController.text.trim());
            Navigator.of(context).pop();
          },
          child: const Text('Rename'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
