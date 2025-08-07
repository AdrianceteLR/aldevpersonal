import 'package:flutter/material.dart';
import '../presentation/theme/app_colors.dart';

class CategoryProgressCard extends StatelessWidget {
  final String category;
  final String spent;
  final String budget;
  final double progress;
  final IconData icon;
  final Color color;

  const CategoryProgressCard({
    super.key,
    required this.category,
    required this.spent,
    required this.budget,
    required this.progress,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Card(
      elevation: 2,
      color: isDark ? AppColors.surface : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.textPrimary : Colors.black87,
                        ),
                      ),
                      Text(
                        '$spent de $budget',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? AppColors.textSecondary : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: progress > 0.8 ? AppColors.danger : (isDark ? AppColors.textPrimary : Colors.black87),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: AppColors.textSecondary.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(
                  progress > 0.8 ? AppColors.danger : color,
                ),
                minHeight: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}