import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class TrainingTabBar extends StatelessWidget {
  final TabController tabController;
  final bool isDark;

  const TrainingTabBar({
    super.key,
    required this.tabController,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surface : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: tabController,
        indicator: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        labelColor: AppColors.textPrimary,
        unselectedLabelColor: isDark ? AppColors.textSecondary : Colors.black54,
        tabs: const [
          Tab(text: 'Hoy'),
          Tab(text: 'Progreso'),
          Tab(text: 'Historial'),
        ],
      ),
    );
  }
}