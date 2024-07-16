import 'package:flutter/material.dart';

import '../controller/chat_controller.dart';
import 'alert_dialog_box.dart';

class ListTileItem extends StatelessWidget {
  const ListTileItem({
    super.key,
    required this.sessionId,
    required this.controller,
  });

  final String sessionId;
  final ChatController controller;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      style: ListTileStyle.list,
      title: Text(sessionId),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: Colors.purple,
            ),
            onPressed: () {
              TextEditingController editController =
                  TextEditingController(text: sessionId);
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialogBox(
                      editController: editController,
                      controller: controller,
                      sessionId: sessionId);
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              controller.deleteSession(sessionId);
              Navigator.of(context).pop(); // Close drawer
            },
          ),
        ],
      ),
      onTap: () {
        controller.loadSession(sessionId);
        Navigator.of(context).pop(); // Close drawer
      },
    );
  }
}
