import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class QuickActionsSection extends StatelessWidget {
  final bool isDark;
  final VoidCallback onAddIncome;
  final VoidCallback onAddExpense;
  final VoidCallback onTransfer;
  final VoidCallback onExport;

  const QuickActionsSection({
    super.key,
    required this.isDark,
    required this.onAddIncome,
    required this.onAddExpense,
    required this.onTransfer,
    required this.onExport,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: isDark ? AppColors.surface : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Acciones Rápidas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textPrimary : Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(
                  icon: Icons.add_circle,
                  label: 'Ingreso',
                  color: AppColors.success,
                  onTap: onAddIncome,
                ),
                _buildActionButton(
                  icon: Icons.remove_circle,
                  label: 'Gasto',
                  color: AppColors.danger,
                  onTap: onAddExpense,
                ),
                _buildActionButton(
                  icon: Icons.swap_horiz,
                  label: 'Transferir',
                  color: AppColors.accent,
                  onTap: onTransfer,
                ),
                _buildActionButton(
                  icon: Icons.file_download,
                  label: 'Exportar',
                  color: AppColors.primary,
                  onTap: onExport,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.textSecondary : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}