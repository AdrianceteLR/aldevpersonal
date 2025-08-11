import 'package:flutter/material.dart';
import '../../../../domain/models/finance/finance_movement_model.dart';
import '../../../theme/app_colors.dart';
import '../all_movements_view.dart';

class RecentMovementsSection extends StatelessWidget {
  final bool isDark;
  final List<FinanceMovement> movements;
  final Function(FinanceMovement) onEdit;
  final Function(String) onDelete;

  const RecentMovementsSection({
    super.key,
    required this.isDark,
    required this.movements,
    required this.onEdit,
    required this.onDelete,
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
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AllMovementsView(),
                    ),
                  ),
                  child: const Text(
                    'Ver todos',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (movements.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Icon(
                        Icons.receipt_long,
                        size: 48,
                        color: isDark ? AppColors.textSecondary : Colors.black54,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No hay movimientos',
                        style: TextStyle(
                          color: isDark ? AppColors.textSecondary : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              ...movements.map((movement) => _buildMovementItem(movement)),
          ],
        ),
      ),
    );
  }

  Widget _buildMovementItem(FinanceMovement movement) {
    final isIncome = movement.type == MovementType.income;
    
    return Dismissible(
      key: Key(movement.id),
      background: Container(
        color: AppColors.danger,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: AppColors.textPrimary),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => onDelete(movement.id),
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
                _getCategoryIcon(movement.category),
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
                    movement.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: isDark ? AppColors.textPrimary : Colors.black87,
                    ),
                  ),
                  Text(
                    movement.category.displayName,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppColors.textSecondary : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${isIncome ? '+' : '-'}${movement.amount.toStringAsFixed(0)}€',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isIncome ? AppColors.success : AppColors.danger,
                  ),
                ),
                Text(
                  _formatDate(movement.date),
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppColors.textSecondary : Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(MovementCategory category) {
    switch (category) {
      case MovementCategory.salary:
        return Icons.work;
      case MovementCategory.food:
        return Icons.restaurant;
      case MovementCategory.transport:
        return Icons.directions_car;
      case MovementCategory.entertainment:
        return Icons.movie;
      case MovementCategory.shopping:
        return Icons.shopping_cart;
      case MovementCategory.bills:
        return Icons.receipt;
      case MovementCategory.rent:
        return Icons.home;
      case MovementCategory.health:
        return Icons.local_hospital;
      default:
        return Icons.account_balance_wallet;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date).inDays;
    
    if (diff == 0) return 'Hoy';
    if (diff == 1) return 'Ayer';
    if (diff < 7) return '$diff días';
    return '${date.day}/${date.month}';
  }
}