import 'package:aldevpersonal/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/training_controller.dart';
import '../../../domain/providers/training_provider.dart';
import 'components_training/training_header.dart';
import 'components_training/training_tab_bar.dart';
import 'components_training/today_tab.dart';
import 'components_training/progress_tab.dart';
import 'components_training/history_tab.dart';
import 'components_training/monthly_calendar_tab.dart';
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
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final trainingState = ref.watch(trainingProvider);
    final controller = TrainingController(ref);
    
    if (trainingState.isLoading) {
      return Scaffold(
        backgroundColor: isDark ? AppColors.background : Colors.grey[50],
        body: const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );
    }
    
    return Scaffold(
      backgroundColor: isDark ? AppColors.background : Colors.grey[50],
      body: Column(
        children: [
          TrainingHeader(
            isDark: isDark,
            onSleepTap: () => TrainingDialogs.showSleepDialog(context, controller),
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
                  onWorkoutTap: (context, workout) => TrainingDialogs.showWorkoutDetails(context, workout, controller),
                  trainingState: trainingState,
                ),
                MonthlyCalendarTab(
                  trainingState: trainingState,
                  onWorkoutTap: (context, workout) => TrainingDialogs.showWorkoutDetails(context, workout, controller),
                ),
                const ProgressTab(),
                HistoryTab(
                  isDark: isDark,
                  trainingState: trainingState,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => TrainingDialogs.showAddWorkoutDialog(context, controller),
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