import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/training_entry_model.dart';
import '../../domain/models/training_plan_model.dart';
import '../../domain/providers/training_provider.dart';

part 'training_controller.g.dart';

@riverpod
class TrainingController extends _$TrainingController {
  @override
  void build() {}

  void toggleExercise(String workoutId, String exerciseId) {
    ref.read(trainingProvider.notifier).toggleExerciseCompletion(workoutId, exerciseId);
  }

  void addWorkout(WorkoutPlan workout) {
    ref.read(trainingProvider.notifier).addWorkoutPlan(workout);
  }

  void addSleepEntry(int hours, int quality) {
    final now = DateTime.now();
    final bedTime = now.subtract(Duration(hours: hours));
    final sleepEntry = SleepEntry(
      id: now.millisecondsSinceEpoch.toString(),
      bedTime: bedTime,
      wakeTime: now,
      quality: quality,
      date: now,
    );

    ref.read(trainingProvider.notifier).addSleepEntry(sleepEntry);
  }

  void addTrainingEntry(String exerciseName, int sets, int reps, double weight) {
    final entry = TrainingEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      exerciseName: exerciseName,
      sets: sets,
      reps: reps,
      weight: weight,
      date: DateTime.now(),
      completed: true,
    );
    ref.read(trainingProvider.notifier).addTrainingEntry(entry);
  }

  WorkoutPlan createCustomWorkout(String name, List<PlannedExercise> exercises) {
    return WorkoutPlan(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      exercises: exercises,
      scheduledDate: DateTime.now(),
      completed: false,
    );
  }

  void createWeeklyPlan(String name, List<WeeklyWorkout> weeklyWorkouts, int weeksToRepeat) {
    final plan = TrainingPlan(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      weeklyWorkouts: weeklyWorkouts,
      startDate: DateTime.now(),
      weeksToRepeat: weeksToRepeat,
      isActive: true,
    );
    
    // Generate individual workouts for each week
    for (int week = 0; week < weeksToRepeat; week++) {
      for (final weeklyWorkout in weeklyWorkouts) {
        final workoutDate = _getNextWeekday(DateTime.now().add(Duration(days: week * 7)), weeklyWorkout.dayOfWeek);
        final workout = WorkoutPlan(
          id: '${plan.id}_${week}_${weeklyWorkout.id}',
          name: '${weeklyWorkout.name} (Semana ${week + 1})',
          exercises: weeklyWorkout.exercises,
          scheduledDate: workoutDate,
          completed: false,
        );
        ref.read(trainingProvider.notifier).addWorkoutPlan(workout);
      }
    }
  }

  DateTime _getNextWeekday(DateTime from, int weekday) {
    final daysUntilWeekday = (weekday - from.weekday) % 7;
    return from.add(Duration(days: daysUntilWeekday));
  }

  List<WorkoutPlan> getWorkoutTemplates() {
    return [];
  }

  void addSleepEntryWithTimes(DateTime bedTime, DateTime wakeTime, int quality) {
    final sleepEntry = SleepEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      bedTime: bedTime,
      wakeTime: wakeTime,
      quality: quality,
      date: DateTime.now(),
    );
    ref.read(trainingProvider.notifier).addSleepEntry(sleepEntry);
  }

  void addWeightEntry(double weight) {
    // TODO: Crear modelo WeightEntry y guardarlo en Firebase
    // Por ahora solo mostramos confirmación
    print('Weight entry: $weight kg at ${DateTime.now()}');
  }
}