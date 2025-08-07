import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class RecentMovementsSection extends StatelessWidget {
  final bool isDark;

  const RecentMovementsSection({
    super.key,
    required this.isDark,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Movimientos Recientes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.textPrimary : Colors.black87,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Ver todos',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...List.generate(3, (index) => _buildMovementItem(
              title: ['Salario', 'Supermercado', 'Gasolina'][index],
              amount: ['+\$2,500.00', '-\$120.50', '-\$45.00'][index],
              category: ['Trabajo', 'Alimentación', 'Transporte'][index],
              isIncome: [true, false, false][index],
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildMovementItem({
    required String title,
    required String amount,
    required String category,
    required bool isIncome,
  }) {
    return Dismissible(
      key: Key(title),
      background: Container(
        color: AppColors.danger,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: AppColors.textPrimary),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (isIncome ? AppColors.success : AppColors.danger)
                    .withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                color: isIncome ? AppColors.success : AppColors.danger,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: isDark ? AppColors.textPrimary : Colors.black87,
                    ),
                  ),
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppColors.textSecondary : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              amount,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isIncome ? AppColors.success : AppColors.danger,
              ),
            ),
          ],
        ),
      ),
    );
  }
}