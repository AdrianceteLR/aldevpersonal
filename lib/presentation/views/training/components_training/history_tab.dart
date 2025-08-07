import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class HistoryTab extends StatelessWidget {
  final bool isDark;

  const HistoryTab({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ...List.generate(5, (index) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Card(
              color: isDark ? AppColors.surface : Colors.white,
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.check,
                    color: AppColors.success,
                    size: 20,
                  ),
                ),
                title: Text(
                  'Entrenamiento ${index + 1}',
                  style: TextStyle(
                    color: isDark ? AppColors.textPrimary : Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  '${DateTime.now().subtract(Duration(days: index)).day}/${DateTime.now().month} - 45min',
                  style: TextStyle(
                    color: isDark ? AppColors.textSecondary : Colors.black54,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: isDark ? AppColors.textSecondary : Colors.black54,
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}