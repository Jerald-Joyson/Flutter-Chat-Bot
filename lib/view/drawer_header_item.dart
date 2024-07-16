import 'package:flutter/material.dart';

import '../controller/chat_controller.dart';

class DrawerHeaderItem extends StatelessWidget {
  const DrawerHeaderItem({
    super.key,
    required this.controller,
  });

  final ChatController controller;

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(color: Colors.purple),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Session History',
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.purple,
              size: 28,
            ),
            onPressed: controller.startNewChat,
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

