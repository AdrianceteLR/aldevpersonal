import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/chat_message_model.dart';
import '../views/assistant/components_assistant/ai_response_generator.dart';

part 'assistant_controller.g.dart';

@riverpod
class AssistantController extends _$AssistantController {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final List<ChatMessage> messages = [];
  bool isTyping = false;

  final List<String> suggestions = [
    '¿Cómo van mis finanzas?',
    'Consejos para entrenar',
    'Resumen de la semana',
    'Metas recomendadas',
  ];

  @override
  void build() {
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    final welcomeMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: '¡Hola! Soy tu asistente personal. Puedo ayudarte con consejos sobre tus finanzas, entrenamientos y hábitos. ¿En qué te puedo ayudar hoy?',
      type: MessageType.assistant,
      timestamp: DateTime.now(),
    );
    messages.add(welcomeMessage);
  }

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: text,
      type: MessageType.user,
      timestamp: DateTime.now(),
    );

    messages.add(userMessage);
    isTyping = true;
    ref.notifyListeners();

    messageController.clear();
    _scrollToBottom();

    Future.delayed(const Duration(seconds: 2), () {
      final response = AIResponseGenerator.generateResponse(text);
      final aiMessage = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: response,
        type: MessageType.assistant,
        timestamp: DateTime.now(),
      );

      messages.add(aiMessage);
      isTyping = false;
      ref.notifyListeners();
      _scrollToBottom();
    });
  }

  void sendSuggestion(String suggestion) {
    messageController.text = suggestion;
    sendMessage();
  }

  void clearChat() {
    messages.clear();
    _addWelcomeMessage();
    ref.notifyListeners();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}