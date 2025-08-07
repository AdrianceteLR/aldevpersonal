import 'package:flutter/material.dart';
import '../../../../widgets/quick_suggestions.dart';
import '../../../theme/app_colors.dart';

class EmptyState extends StatelessWidget {
  final bool isDark;
  final List<String> suggestions;
  final Function(String) onSuggestionTap;

  const EmptyState({
    super.key,
    required this.isDark,
    required this.suggestions,
    required this.onSuggestionTap,
  });

  @override
  Widget build(BuildContext context) {
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
              suggestions: suggestions,
              onSuggestionTap: onSuggestionTap,
            ),
          ],
        ),
      ),
    );
  }
}