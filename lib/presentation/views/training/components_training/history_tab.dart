import 'package:flutter/material.dart';
import '../../../../domain/providers/training_provider.dart';
import '../../../theme/app_colors.dart';

class HistoryTab extends StatelessWidget {
  final bool isDark;
  final TrainingState trainingState;

  const HistoryTab({
    super.key,
    required this.isDark,
    required this.trainingState,
  });

  @override
  Widget build(BuildContext context) {
    final completedWorkouts = trainingState.workoutPlans
        .where((workout) => workout.completed)
        .toList()
      ..sort((a, b) => b.scheduledDate.compareTo(a.scheduledDate));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (completedWorkouts.isEmpty)
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Icon(
                    Icons.history,
                    size: 64,
                    color: isDark ? AppColors.textSecondary : Colors.black54,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No hay entrenamientos completados',
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark ? AppColors.textSecondary : Colors.black54,
                    ),
                  ),
                ],
              ),
            )
          else
            ...completedWorkouts.map((workout) => Padding(
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
                    workout.name,
                    style: TextStyle(
                      color: isDark ? AppColors.textPrimary : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    '${workout.scheduledDate.day}/${workout.scheduledDate.month} - ${workout.exercises.length} ejercicios',
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
          // Mock historical data for demonstration
          ...List.generate(3, (index) => Padding(
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
                  '${DateTime.now().subtract(Duration(days: index + 1)).day}/${DateTime.now().month} - 45min',
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