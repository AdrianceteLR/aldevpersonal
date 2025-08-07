import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class UserStatsCard extends StatelessWidget {
  const UserStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      color: isDark ? AppColors.surface : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tu Actividad',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textPrimary : Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    icon: Icons.fitness_center,
                    label: 'Entrenamientos',
                    value: '24',
                    color: AppColors.primary,
                    isDark: isDark,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    icon: Icons.account_balance_wallet,
                    label: 'Gastos',
                    value: '\$2,450',
                    color: AppColors.accent,
                    isDark: isDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    icon: Icons.chat,
                    label: 'Consultas IA',
                    value: '156',
                    color: AppColors.success,
                    isDark: isDark,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    icon: Icons.calendar_today,
                    label: 'Días activo',
                    value: '45',
                    color: AppColors.danger,
                    isDark: isDark,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textPrimary : Colors.black87,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? AppColors.textSecondary : Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}