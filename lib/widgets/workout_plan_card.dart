import 'package:flutter/material.dart';
import '../presentation/theme/app_colors.dart';
import '../domain/models/training_entry_model.dart';

class WorkoutPlanCard extends StatelessWidget {
  final WorkoutPlan workout;
  final VoidCallback? onTap;
  final Function(String exerciseId, bool completed)? onExerciseToggle;

  const WorkoutPlanCard({
    super.key,
    required this.workout,
    this.onTap,
    this.onExerciseToggle,
  });

  @override
  Widget build(BuildContext context) {
    final completedExercises = workout.exercises.where((e) => e.completed).length;
    final totalExercises = workout.exercises.length;
    final progress = totalExercises > 0 ? completedExercises / totalExercises : 0.0;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Card(
      elevation: 2,
      color: isDark ? AppColors.surface : Colors.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      workout.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.textPrimary : Colors.black87,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: workout.completed ? AppColors.success.withOpacity(0.2) : AppColors.accent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      workout.completed ? 'Completado' : 'Pendiente',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: workout.completed ? AppColors.success : AppColors.accent,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.fitness_center, size: 16, color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  Text(
                    '$completedExercises/$totalExercises ejercicios',
                    style: TextStyle(fontSize: 14, color: isDark ? AppColors.textSecondary : Colors.black54),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: AppColors.textSecondary.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    progress == 1.0 ? AppColors.success : AppColors.primary,
                  ),
                  minHeight: 4,
                ),
              ),
              const SizedBox(height: 12),
              ...workout.exercises.take(3).map((exercise) => _buildExerciseItem(exercise)),
              if (workout.exercises.length > 3)
                Text(
                  '+${workout.exercises.length - 3} más...',
                  style: TextStyle(fontSize: 12, color: isDark ? AppColors.textSecondary : Colors.black54),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseItem(PlannedExercise exercise) {
    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Icon(
                exercise.completed ? Icons.check_circle : Icons.radio_button_unchecked,
                size: 16,
                color: exercise.completed ? AppColors.success : (isDark ? AppColors.textSecondary : Colors.black54),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${exercise.name} - ${exercise.targetSets}x${exercise.targetReps} @ ${exercise.targetWeight}kg',
                  style: TextStyle(
                    fontSize: 12,
                    color: exercise.completed ? (isDark ? AppColors.textSecondary : Colors.black54) : (isDark ? AppColors.textPrimary : Colors.black87),
                    decoration: exercise.completed ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}