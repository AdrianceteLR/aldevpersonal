import 'package:flutter/material.dart';
import '../../../../domain/models/training_entry_model.dart';
import '../../../theme/app_colors.dart';

class TrainingDialogs {
  static void showWorkoutDetails(BuildContext context, WorkoutPlan workout) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? AppColors.surface : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                workout.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimary : Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: workout.exercises.length,
                  itemBuilder: (context, index) {
                    final exercise = workout.exercises[index];
                    return Card(
                      color: isDark ? AppColors.background : Colors.grey[50],
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  exercise.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? AppColors.textPrimary : Colors.black87,
                                  ),
                                ),
                                Checkbox(
                                  value: exercise.completed,
                                  onChanged: (value) {},
                                  activeColor: AppColors.success,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                _buildMetricChip('${exercise.targetSets} series'),
                                const SizedBox(width: 8),
                                _buildMetricChip('${exercise.targetReps} reps'),
                                const SizedBox(width: 8),
                                _buildMetricChip('${exercise.targetWeight}kg'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildMetricChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static void showSleepDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? AppColors.surface : Colors.white,
        title: Text(
          'Registrar Sueño',
          style: TextStyle(
            color: isDark ? AppColors.textPrimary : Colors.black87,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              style: TextStyle(
                color: isDark ? AppColors.textPrimary : Colors.black87,
              ),
              decoration: InputDecoration(
                labelText: 'Horas dormidas',
                labelStyle: TextStyle(
                  color: isDark ? AppColors.textSecondary : Colors.black54,
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Text(
              'Calidad del sueño',
              style: TextStyle(
                color: isDark ? AppColors.textSecondary : Colors.black54,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) => IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.star,
                  color: index < 3
                      ? AppColors.accent
                      : (isDark ? AppColors.textSecondary : Colors.black54),
                ),
              )),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Guardar', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  static void showAddWorkoutDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? AppColors.surface : Colors.white,
        title: Text(
          'Nuevo Entrenamiento',
          style: TextStyle(
            color: isDark ? AppColors.textPrimary : Colors.black87,
          ),
        ),
        content: Text(
          '¿Qué tipo de entrenamiento quieres crear?',
          style: TextStyle(
            color: isDark ? AppColors.textSecondary : Colors.black54,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Personalizado', style: TextStyle(color: AppColors.primary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Plantilla', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }
}