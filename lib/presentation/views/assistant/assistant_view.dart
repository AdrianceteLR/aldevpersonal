import 'package:aldevpersonal/presentation/theme/app_colors.dart';
import 'package:aldevpersonal/widgets/chat_message_bubble.dart';
import 'package:aldevpersonal/widgets/quick_suggestions.dart';
import 'package:aldevpersonal/widgets/typing_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/assistant_controller.dart';
import 'components_assistant/assistant_app_bar.dart';
import 'components_assistant/empty_state.dart';
import 'components_assistant/message_input.dart';

class AssistantView extends ConsumerStatefulWidget {
  const AssistantView({super.key});

  @override
  ConsumerState<AssistantView> createState() => _AssistantViewState();
}

class _AssistantViewState extends ConsumerState<AssistantView> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final controller = ref.watch(assistantControllerProvider.notifier);
    
    return Scaffold(
      backgroundColor: isDark ? AppColors.background : Colors.grey[50],
      appBar: AssistantAppBar(
        isDark: isDark,
        onClearChat: () => controller.clearChat(),
      ),
      body: Column(
        children: [
          if (controller.messages.isEmpty)
            EmptyState(
              isDark: isDark,
              suggestions: controller.suggestions,
              onSuggestionTap: (suggestion) => controller.sendSuggestion(suggestion),
            )
          else
            Expanded(
              child: ListView.builder(
                controller: controller.scrollController,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: controller.messages.length + (controller.isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == controller.messages.length && controller.isTyping) {
                    return const TypingIndicator();
                  }
                  return ChatMessageBubble(message: controller.messages[index]);
                },
              ),
            ),
          if (controller.messages.isNotEmpty)
            QuickSuggestions(
              suggestions: controller.suggestions,
              onSuggestionTap: (suggestion) => controller.sendSuggestion(suggestion),
            ),
          MessageInput(
            controller: controller.messageController,
            isDark: isDark,
            onSend: () => controller.sendMessage(),
          ),
        ],
      ),
    );
  }
}