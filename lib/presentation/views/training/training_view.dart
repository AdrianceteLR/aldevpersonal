import 'package:aldevpersonal/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'components_training/training_header.dart';
import 'components_training/training_tab_bar.dart';
import 'components_training/today_tab.dart';
import 'components_training/progress_tab.dart';
import 'components_training/history_tab.dart';
import 'components_training/training_dialogs.dart';

class TrainingView extends ConsumerStatefulWidget {
  const TrainingView({super.key});

  @override
  ConsumerState<TrainingView> createState() => _TrainingViewState();
}

class _TrainingViewState extends ConsumerState<TrainingView> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppColors.background : Colors.grey[50],
      body: Column(
        children: [
          TrainingHeader(
            isDark: isDark,
            onSleepTap: () => TrainingDialogs.showSleepDialog(context),
          ),
          TrainingTabBar(
            tabController: _tabController,
            isDark: isDark,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                TodayTab(
                  onWorkoutTap: TrainingDialogs.showWorkoutDetails,
                ),
                const ProgressTab(),
                HistoryTab(isDark: isDark),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => TrainingDialogs.showAddWorkoutDialog(context),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: AppColors.textPrimary),
        label: const Text('Nuevo', style: TextStyle(color: AppColors.textPrimary)),
      ),
    );
  }



  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}