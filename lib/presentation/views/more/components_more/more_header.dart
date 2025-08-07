import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class MoreHeader extends StatelessWidget {
  final bool isDarkMode;

  const MoreHeader({
    super.key,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Más',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? AppColors.textPrimary : Colors.black87,
          ),
        ),
        Text(
          'Configuración y perfil',
          style: TextStyle(
            fontSize: 16,
            color: isDarkMode ? AppColors.textSecondary : Colors.black54,
          ),
        ),
      ],
    );
  }
}