import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class TrainingHeader extends StatelessWidget {
  final bool isDark;

  const TrainingHeader({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Entrenamiento',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimary : Colors.black87,
                ),
              ),
              Text(
                'Tu rutina de hoy',
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? AppColors.textSecondary : Colors.black54,
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}