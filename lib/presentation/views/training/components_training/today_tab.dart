import 'package:flutter/material.dart';
import '../../../../domain/models/training_entry_model.dart';
import '../../../../widgets/training_summary_card.dart';
import '../../../../widgets/workout_plan_card.dart';
import '../../../theme/app_colors.dart';

class TodayTab extends StatelessWidget {
  final Function(BuildContext, WorkoutPlan) onWorkoutTap;

  const TodayTab({
    super.key,
    required this.onWorkoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TrainingSummaryCard(
                  title: 'Completados',
                  value: '2/4',
                  subtitle: 'Ejercicios hoy',
                  icon: Icons.check_circle,
                  color: AppColors.success,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TrainingSummaryCard(
                  title: 'Tiempo',
                  value: '45min',
                  subtitle: 'Entrenando',
                  icon: Icons.timer,
                  color: AppColors.accent,
                ),
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
          ...List.generate(2, (index) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: WorkoutPlanCard(
              workout: _getMockWorkouts()[index],
              onTap: () => onWorkoutTap(context, _getMockWorkouts()[index]),
            ),
          )),
        ],
      ),
    );
  }

  List<WorkoutPlan> _getMockWorkouts() {
    return [
      WorkoutPlan(
        id: '1',
        name: 'Pecho y Tríceps',
        exercises: [
          const PlannedExercise(
            name: 'Press de Banca',
            targetSets: 4,
            targetReps: 8,
            targetWeight: 80,
            completed: true,
          ),
          const PlannedExercise(
            name: 'Press Inclinado',
            targetSets: 3,
            targetReps: 10,
            targetWeight: 60,
            completed: true,
          ),
          const PlannedExercise(
            name: 'Fondos',
            targetSets: 3,
            targetReps: 12,
            targetWeight: 0,
            completed: false,
          ),
        ],
        scheduledDate: DateTime.now(),
        completed: false,
      ),
      WorkoutPlan(
        id: '2',
        name: 'Espalda y Bíceps',
        exercises: [
          const PlannedExercise(
            name: 'Dominadas',
            targetSets: 4,
            targetReps: 6,
            targetWeight: 0,
            completed: false,
          ),
          const PlannedExercise(
            name: 'Remo con Barra',
            targetSets: 4,
            targetReps: 8,
            targetWeight: 70,
            completed: false,
          ),
        ],
        scheduledDate: DateTime.now().add(const Duration(days: 1)),
        completed: false,
      ),
    ];
  }
}