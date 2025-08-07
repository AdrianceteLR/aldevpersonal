import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isDark;
  final VoidCallback onSend;

  const MessageInput({
    super.key,
    required this.controller,
    required this.isDark,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surface : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark
                ? AppColors.textSecondary.withOpacity(0.2)
                : Colors.black12,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(
                color: isDark ? AppColors.textPrimary : Colors.black87,
              ),
              decoration: InputDecoration(
                hintText: 'Escribe tu mensaje...',
                hintStyle: TextStyle(
                  color: isDark ? AppColors.textSecondary : Colors.black54,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: isDark ? AppColors.background : Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              maxLines: null,
              onSubmitted: (_) => onSend(),
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            onPressed: onSend,
            backgroundColor: AppColors.primary,
            mini: true,
            child: const Icon(
              Icons.send,
              color: AppColors.textPrimary,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}