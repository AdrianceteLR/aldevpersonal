import 'package:aldevpersonal/domain/models/chat_message_model.dart';
import 'package:aldevpersonal/presentation/theme/app_colors.dart';
import 'package:aldevpersonal/widgets/chat_message_bubble.dart';
import 'package:aldevpersonal/widgets/quick_suggestions.dart';
import 'package:aldevpersonal/widgets/typing_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.surface : Colors.white,
        elevation: 1,
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primary.withOpacity(0.2),
              child: const Icon(Icons.smart_toy, size: 16, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Asistente IA',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.textPrimary : Colors.black87,
                  ),
                ),
                Text(
                  'Siempre disponible',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _clearChat,
            icon: Icon(Icons.refresh, color: isDark ? AppColors.textPrimary : Colors.black87),
          ),
        ],
      ),
      body: Column(
        children: [
          if (_messages.isEmpty)
            _buildEmptyState(isDark)
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
          _buildMessageInput(isDark),
        ],
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.smart_toy,
                size: 48,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Tu Asistente Personal',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textPrimary : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Pregúntame sobre tus finanzas,\nentrenamientos o cualquier consejo',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: isDark ? AppColors.textSecondary : Colors.black54,
              ),
            ),
            const SizedBox(height: 32),
            QuickSuggestions(
              suggestions: _suggestions,
              onSuggestionTap: _sendSuggestion,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surface : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.textSecondary.withOpacity(0.2) : Colors.black12,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              style: TextStyle(color: isDark ? AppColors.textPrimary : Colors.black87),
              decoration: InputDecoration(
                hintText: 'Escribe tu mensaje...',
                hintStyle: TextStyle(color: isDark ? AppColors.textSecondary : Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: isDark ? AppColors.background : Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              maxLines: null,
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            onPressed: _sendMessage,
            backgroundColor: AppColors.primary,
            mini: true,
            child: const Icon(Icons.send, color: AppColors.textPrimary, size: 20),
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
      final response = _generateAIResponse(text);
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

  String _generateAIResponse(String userMessage) {
    final message = userMessage.toLowerCase();
    
    if (message.contains('finanzas') || message.contains('dinero') || message.contains('gastos')) {
      return 'Basándome en tus datos, veo que has gastado \$750 este mes. Te recomiendo reducir los gastos en entretenimiento y aumentar tus ahorros en un 15%. ¿Te gustaría que te ayude a crear un plan de ahorro?';
    }
    
    if (message.contains('entrenar') || message.contains('ejercicio') || message.contains('gym')) {
      return 'Has completado 4 entrenamientos esta semana, ¡excelente! Para optimizar tus resultados, te sugiero aumentar el peso en press de banca gradualmente y añadir más cardio los días de descanso.';
    }
    
    if (message.contains('resumen') || message.contains('semana')) {
      return 'Esta semana has tenido un buen rendimiento: 4 entrenamientos completados, gastos controlados en \$750, y 7.2h promedio de sueño. Te recomiendo mantener esta consistencia y enfocarte en mejorar la calidad del sueño.';
    }
    
    if (message.contains('meta') || message.contains('objetivo')) {
      return 'Basándome en tus patrones, te sugiero estas metas para el próximo mes: Ahorrar \$200 adicionales, aumentar a 5 entrenamientos semanales, y mantener 8h de sueño diarias. ¿Te parece alcanzable?';
    }
    
    return 'Entiendo tu consulta. Basándome en tus datos de la app, puedo ayudarte a optimizar tus finanzas, entrenamientos y hábitos. ¿Hay algo específico en lo que te gustaría que me enfoque?';
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
