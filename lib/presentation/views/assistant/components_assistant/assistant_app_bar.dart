import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class AssistantAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDark;
  final VoidCallback onClearChat;

  const AssistantAppBar({
    super.key,
    required this.isDark,
    required this.onClearChat,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
              const Text(
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
          onPressed: onClearChat,
          icon: Icon(
            Icons.refresh,
            color: isDark ? AppColors.textPrimary : Colors.black87,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}