import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/training_entry_model.dart';
import '../../domain/models/training_plan_model.dart';
import '../../domain/providers/training_provider.dart';

class TrainingController {
  final WidgetRef ref;

  TrainingController(this.ref);

  void toggleExercise(String workoutId, String exerciseName) {
    ref.read(trainingProvider.notifier).toggleExerciseCompletion(workoutId, exerciseName);
  }

  void addWorkout(WorkoutPlan workout) {
    ref.read(trainingProvider.notifier).addWorkoutPlan(workout);
  }

  void addSleepEntry(int hours, int quality) {
    final sleepEntry = SleepEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      bedTime: DateTime.now().subtract(Duration(hours: hours)),
      wakeTime: DateTime.now(),
      quality: quality,
      date: DateTime.now(),
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
    return [
      WorkoutPlan(
        id: 'template_1',
        name: 'Push (Pecho, Hombros, Tríceps)',
        exercises: [
          const PlannedExercise(name: 'Press de Banca', targetSets: 4, targetReps: 8, targetWeight: 80, completed: false),
          const PlannedExercise(name: 'Press Militar', targetSets: 3, targetReps: 10, targetWeight: 50, completed: false),
          const PlannedExercise(name: 'Press Inclinado', targetSets: 3, targetReps: 10, targetWeight: 60, completed: false),
          const PlannedExercise(name: 'Extensiones de Tríceps', targetSets: 3, targetReps: 12, targetWeight: 30, completed: false),
        ],
        scheduledDate: DateTime.now(),
        completed: false,
      ),
      WorkoutPlan(
        id: 'template_2',
        name: 'Pull (Espalda, Bíceps)',
        exercises: [
          const PlannedExercise(name: 'Dominadas', targetSets: 4, targetReps: 6, targetWeight: 0, completed: false),
          const PlannedExercise(name: 'Remo con Barra', targetSets: 4, targetReps: 8, targetWeight: 70, completed: false),
          const PlannedExercise(name: 'Curl de Bíceps', targetSets: 3, targetReps: 12, targetWeight: 20, completed: false),
        ],
        scheduledDate: DateTime.now(),
        completed: false,
      ),
      WorkoutPlan(
        id: 'template_3',
        name: 'Legs (Piernas)',
        exercises: [
          const PlannedExercise(name: 'Sentadillas', targetSets: 4, targetReps: 10, targetWeight: 100, completed: false),
          const PlannedExercise(name: 'Peso Muerto', targetSets: 4, targetReps: 6, targetWeight: 120, completed: false),
          const PlannedExercise(name: 'Prensa de Piernas', targetSets: 3, targetReps: 12, targetWeight: 150, completed: false),
        ],
        scheduledDate: DateTime.now(),
        completed: false,
      ),
    ];
  }
}