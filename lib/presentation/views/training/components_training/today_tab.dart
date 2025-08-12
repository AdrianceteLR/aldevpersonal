import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/models/training_entry_model.dart';
import '../../../../domain/providers/training_provider.dart';
import '../../../../widgets/training_summary_card.dart';
import '../../../../widgets/workout_plan_card.dart';
import '../../../theme/app_colors.dart';
import '../../../controllers/training_controller.dart';
import 'training_dialogs.dart';

class TodayTab extends ConsumerWidget {
  final Function(BuildContext, WorkoutPlan) onWorkoutTap;
  final TrainingState trainingState;

  const TodayTab({
    super.key,
    required this.onWorkoutTap,
    required this.trainingState,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayWorkouts = _getTodayWorkouts();
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 200,
                      child: TrainingSummaryCard(
                        title: 'Completados',
                        value: '${_getCompletedExercisesToday()}/${_getTotalExercisesToday()}',
                        subtitle: 'ejercicios hoy',
                        icon: Icons.check_circle,
                        color: AppColors.success,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 200,
                      child: TrainingSummaryCard(
                        title: 'Peso',
                        value: _getCurrentWeight(),
                        subtitle: 'actual',
                        icon: Icons.monitor_weight,
                        color: AppColors.primary,
                        onTap: () => _showWeightDialog(context, ref),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 200,
                      child: TrainingSummaryCard(
                        title: 'Sueño',
                        value: _getSleepHoursDisplay(),
                        subtitle: 'anoche',
                        icon: Icons.bedtime,
                        color: AppColors.accent,
                        onTap: () => _showSleepDialog(context, ref),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 200,
                      child: TrainingSummaryCard(
                        title: 'Recuperación',
                        value: _getRecoveryStatus(),
                        subtitle: _getRecoverySubtitle(),
                        icon: _getRecoveryIcon(),
                        color: _getRecoveryColor(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Plan de Hoy',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.textPrimary
                  : Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          if (todayWorkouts.isEmpty)
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Icon(
                    Icons.fitness_center,
                    size: 64,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.textSecondary
                        : Colors.black54,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No hay entrenamientos programados para hoy',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.textSecondary
                          : Colors.black54,
                    ),
                  ),
                ],
              ),
            )
          else
            ...todayWorkouts.map((workout) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: WorkoutPlanCard(
                workout: workout,
                onTap: () => onWorkoutTap(context, workout),
                onExerciseToggle: (exerciseName, completed) {
                  // This will be handled by the controller in the parent
                },
              ),
            )),
        ],
      ),
    );
  }

  List<WorkoutPlan> _getTodayWorkouts() {
    final today = DateTime.now();
    return trainingState.workoutPlans.where((workout) {
      return workout.scheduledDate.day == today.day &&
             workout.scheduledDate.month == today.month &&
             workout.scheduledDate.year == today.year;
    }).toList();
  }

  int _getCompletedExercisesToday() {
    return _getTodayWorkouts()
        .expand((workout) => workout.exercises)
        .where((exercise) => exercise.completed)
        .length;
  }

  int _getTotalExercisesToday() {
    return _getTodayWorkouts()
        .expand((workout) => workout.exercises)
        .length;
  }

  int _getStreakDays() {
    // Calcular días consecutivos de entrenamiento
    int streak = 0;
    DateTime currentDate = DateTime.now();
    
    while (true) {
      final dayWorkouts = trainingState.workoutPlans.where((workout) {
        return workout.scheduledDate.day == currentDate.day &&
               workout.scheduledDate.month == currentDate.month &&
               workout.scheduledDate.year == currentDate.year &&
               workout.completed;
      }).toList();
      
      if (dayWorkouts.isEmpty) break;
      streak++;
      currentDate = currentDate.subtract(const Duration(days: 1));
    }
    
    return streak;
  }

  String _getWatchCalories() {
    // TODO: Integrar con datos del reloj inteligente
    // Por ahora retorna datos simulados
    final completedExercises = _getCompletedExercisesToday();
    if (completedExercises == 0) return 'Sin datos';
    
    final estimatedCalories = completedExercises * 25; // 25 kcal por ejercicio
    return '${estimatedCalories} kcal';
  }

  String _getRecoveryStatus() {
    final lastSleep = _getLastSleepEntry();
    final daysSinceLastWorkout = _getDaysSinceLastWorkout();
    final sleepHours = _getSleepHours(lastSleep);
    
    if (lastSleep != null && sleepHours >= 7 && daysSinceLastWorkout <= 1) {
      return 'Óptima';
    } else if (lastSleep != null && sleepHours >= 6) {
      return 'Buena';
    } else {
      return 'Necesita descanso';
    }
  }

  double _getSleepHours(SleepEntry? sleepEntry) {
    if (sleepEntry == null) return 0;
    final duration = sleepEntry.wakeTime.difference(sleepEntry.bedTime);
    final hours = duration.inMinutes / 60.0;

    return hours;
  }

  String _getRecoverySubtitle() {
    final status = _getRecoveryStatus();
    switch (status) {
      case 'Óptima':
        return 'Listo para entrenar';
      case 'Buena':
        return 'Puedes entrenar';
      default:
        return 'Considera descansar';
    }
  }

  IconData _getRecoveryIcon() {
    final status = _getRecoveryStatus();
    switch (status) {
      case 'Óptima':
        return Icons.favorite;
      case 'Buena':
        return Icons.favorite_border;
      default:
        return Icons.heart_broken;
    }
  }

  Color _getRecoveryColor() {
    final status = _getRecoveryStatus();
    switch (status) {
      case 'Óptima':
        return AppColors.success;
      case 'Buena':
        return AppColors.primary;
      default:
        return AppColors.danger;
    }
  }

  SleepEntry? _getLastSleepEntry() {
    if (trainingState.sleepEntries.isEmpty) return null;
    // Obtener la entrada de sueño más reciente por fecha
    final sortedEntries = trainingState.sleepEntries.toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    return sortedEntries.first;
  }

  int _getDaysSinceLastWorkout() {
    final completedWorkouts = trainingState.workoutPlans
        .where((workout) => workout.completed)
        .toList();
    
    if (completedWorkouts.isEmpty) return 999;
    
    final lastWorkout = completedWorkouts.last;
    final daysDifference = DateTime.now().difference(lastWorkout.scheduledDate).inDays;
    return daysDifference;
  }

  String _getSleepHoursDisplay() {
    final lastSleep = _getLastSleepEntry();
    if (lastSleep == null) return 'Sin datos';
    
    final hours = _getSleepHours(lastSleep);
    return '${hours.toStringAsFixed(1)}h';
  }

  String _getCurrentWeight() {
    // TODO: Integrar con datos reales de peso
    // Por ahora retorna un valor simulado
    return '75.2 kg';
  }

  void _showSleepDialog(BuildContext context, WidgetRef ref) {
    final controller = TrainingController(ref);
    TrainingDialogs.showSleepDialog(context, controller);
  }

  void _showWeightDialog(BuildContext context, WidgetRef ref) {
    final controller = TrainingController(ref);
    TrainingDialogs.showWeightDialog(context, controller);
  }
}