import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class FinancesHeader extends StatelessWidget {
  final String selectedPeriod;
  final bool isDark;
  final double balance;
  final double income;
  final double expense;

  const FinancesHeader({
    super.key,
    required this.selectedPeriod,
    required this.isDark,
    required this.balance,
    required this.income,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Finanzas',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.textPrimary : Colors.black87,
                  ),
                ),
                Text(
                  'Resumen de $selectedPeriod',
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark ? AppColors.textSecondary : Colors.black54,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: isDark ? AppColors.textPrimary : Colors.black87,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: isDark ? AppColors.textPrimary : Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildBalanceCard(
                'Balance',
                '${balance.toStringAsFixed(0)}€',
                Icons.account_balance_wallet,
                AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildBalanceCard(
                'Ingresos',
                '${income.toStringAsFixed(0)}€',
                Icons.trending_up,
                AppColors.success,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildBalanceCard(
                'Gastos',
                '${expense.toStringAsFixed(0)}€',
                Icons.trending_down,
                AppColors.danger,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBalanceCard(String title, String amount, IconData icon, Color color) {
    return Card(
      color: isDark ? AppColors.surface : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              amount,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textPrimary : Colors.black87,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? AppColors.textSecondary : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}