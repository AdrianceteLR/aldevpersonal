import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class FinancesHeader extends StatelessWidget {
  final String selectedPeriod;
  final bool isDark;

  const FinancesHeader({
    super.key,
    required this.selectedPeriod,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}