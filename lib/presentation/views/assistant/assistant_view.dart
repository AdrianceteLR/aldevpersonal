import 'package:aldevpersonal/domain/models/chat_message_model.dart';
import 'package:aldevpersonal/presentation/theme/app_colors.dart';
import 'package:aldevpersonal/widgets/chat_message_bubble.dart';
import 'package:aldevpersonal/widgets/quick_suggestions.dart';
import 'package:aldevpersonal/widgets/typing_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'components_assistant/assistant_app_bar.dart';
import 'components_assistant/empty_state.dart';
import 'components_assistant/message_input.dart';
import 'components_assistant/ai_response_generator.dart';

class AssistantView extends ConsumerStatefulWidget {
  const AssistantView({super.key});

  @override
  ConsumerState<AssistantView> createState() => _AssistantViewState();
}

class _AssistantViewState extends ConsumerState<AssistantView> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;

  final List<String> _suggestions = [
    '¿Cómo van mis finanzas?',
    'Consejos para entrenar',
    'Resumen de la semana',
    'Metas recomendadas',
  ];

  @override
  void initState() {
    super.initState();
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    final welcomeMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: '¡Hola! Soy tu asistente personal. Puedo ayudarte con consejos sobre tus finanzas, entrenamientos y hábitos. ¿En qué te puedo ayudar hoy?',
      type: MessageType.assistant,
      timestamp: DateTime.now(),
    );
    setState(() {
      _messages.add(welcomeMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppColors.background : Colors.grey[50],
      appBar: AssistantAppBar(
        isDark: isDark,
        onClearChat: _clearChat,
      ),
      body: Column(
        children: [
          if (_messages.isEmpty)
            EmptyState(
              isDark: isDark,
              suggestions: _suggestions,
              onSuggestionTap: _sendSuggestion,
            )
          else
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: _messages.length + (_isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _messages.length && _isTyping) {
                    return const TypingIndicator();
                  }
                  return ChatMessageBubble(message: _messages[index]);
                },
              ),
            ),
          if (_messages.isNotEmpty)
            QuickSuggestions(
              suggestions: _suggestions,
              onSuggestionTap: _sendSuggestion,
            ),
          MessageInput(
            controller: _messageController,
            isDark: isDark,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }



  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: text,
      type: MessageType.user,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(userMessage);
      _isTyping = true;
    });

    _messageController.clear();
    _scrollToBottom();

    // Simular respuesta de IA
    Future.delayed(const Duration(seconds: 2), () {
      final response = AIResponseGenerator.generateResponse(text);
      final aiMessage = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: response,
        type: MessageType.assistant,
        timestamp: DateTime.now(),
      );

      setState(() {
        _messages.add(aiMessage);
        _isTyping = false;
      });
      _scrollToBottom();
    });
  }

  void _sendSuggestion(String suggestion) {
    _messageController.text = suggestion;
    _sendMessage();
  }



  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _clearChat() {
    setState(() {
      _messages.clear();
    });
    _addWelcomeMessage();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
