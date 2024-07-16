import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../model/chat_message.dart';

class ChatController extends GetxController {
  late final GenerativeModel _model;
  late ChatSession _chat;
  final String _apikey = dotenv.env["API_KEY"]!;

  final ScrollController scrollController = ScrollController();
  final TextEditingController textController = TextEditingController();
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxList<String> sessions = <String>[].obs;
  final GetStorage storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: _apikey);

    // Load sessions from local storage
    sessions.value = storage.read<List>('sessions')?.cast<String>() ?? [];

    // Load current session messages
    String currentSession =
        storage.read<String>('currentSession') ?? 'session_0';
    loadSession(currentSession);
  }

  void scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 750),
            curve: Curves.easeOutCirc));
  }

  Future<void> sendChatMessage(String message) async {
    messages.add(ChatMessage(text: message, isUser: true));
    saveCurrentSession();
    try {
      final response = await _chat.sendMessage(Content.text(message));
      final text = response.text;
      messages.add(ChatMessage(text: text!, isUser: false));
      scrollDown();
      saveCurrentSession();
    } catch (e) {
      messages.add(ChatMessage(text: "Error: $e", isUser: false));
      saveCurrentSession();
    } finally {
      textController.clear();
    }
  }

  void startNewChat() {
    String newSessionId = 'session_${sessions.length}';
    sessions.add(newSessionId);
    storage.write('sessions', sessions);

    messages.clear();
    _chat = _model.startChat();
    scrollDown();

    storage.write('currentSession', newSessionId);
    saveCurrentSession();
  }

  void loadSession(String sessionId) {
    List? storedMessages = storage.read<List>('messages_$sessionId');
    if (storedMessages != null) {
      messages.value =
          storedMessages.map((e) => ChatMessage.fromMap(e)).toList();
    } else {
      messages.clear();
    }
    _chat = _model.startChat();
    scrollDown();
    storage.write('currentSession', sessionId);
  }

  void saveCurrentSession() {
    String currentSession =
        storage.read<String>('currentSession') ?? 'session_0';
    storage.write(
        'messages_$currentSession', messages.map((e) => e.toMap()).toList());
  }

  void deleteSession(String sessionId) {
    sessions.remove(sessionId);
    storage.remove('messages_$sessionId');
    storage.write('sessions', sessions);

    if (storage.read<String>('currentSession') == sessionId) {
      if (sessions.isNotEmpty) {
        loadSession(sessions.last);
      } else {
        startNewChat();
      }
    }
  }

  void renameSession(String oldName, String newName) {
    if (sessions.contains(oldName) && !sessions.contains(newName)) {
      int index = sessions.indexOf(oldName);
      sessions[index] = newName;
      storage.write('sessions', sessions);

      // Rename stored messages
      List? storedMessages = storage.read<List>('messages_$oldName');
      if (storedMessages != null) {
        storage.write('messages_$newName', storedMessages);
        storage.remove('messages_$oldName');
      }

      // Update current session if necessary
      String currentSession = storage.read<String>('currentSession') ?? '';
      if (currentSession == oldName) {
        storage.write('currentSession', newName);
      }
    }
  }
}
