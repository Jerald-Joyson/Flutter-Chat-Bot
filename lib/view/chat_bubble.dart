import 'package:flutter/material.dart';
import '../model/chat_message.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width / 1.25,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 14,
        ),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.purple : Colors.grey,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft:
                message.isUser ? const Radius.circular(12) : Radius.zero,
            bottomRight:
                message.isUser ? Radius.zero : const Radius.circular(12),
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            fontSize: 16,
            color: message.isUser ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
