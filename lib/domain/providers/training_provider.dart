import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/training_entry_model.dart';
import '../../data/remote_services/training/training_service.dart';

class TrainingState {
  final List<WorkoutPlan> workoutPlans;
  final List<TrainingEntry> trainingEntries;
  final List<SleepEntry> sleepEntries;
  final bool isLoading;

  const TrainingState({
    this.workoutPlans = const [],
    this.trainingEntries = const [],
    this.sleepEntries = const [],
    this.isLoading = false,
  });

  TrainingState copyWith({
    List<WorkoutPlan>? workoutPlans,
    List<TrainingEntry>? trainingEntries,
    List<SleepEntry>? sleepEntries,
    bool? isLoading,
  }) {
    return TrainingState(
      workoutPlans: workoutPlans ?? this.workoutPlans,
      trainingEntries: trainingEntries ?? this.trainingEntries,
      sleepEntries: sleepEntries ?? this.sleepEntries,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class TrainingNotifier extends StateNotifier<TrainingState> {
  final TrainingService _trainingService = TrainingService();
  
  TrainingNotifier() : super(const TrainingState()) {
    _loadInitialData();
  }

  void _loadInitialData() async {
    state = state.copyWith(isLoading: true);
    
    try {
      final workouts = await _trainingService.getWorkoutPlans();
      final entries = await _trainingService.getTrainingEntries();
      final sleepEntries = await _trainingService.getSleepEntries();
      
      state = state.copyWith(
        workoutPlans: workouts,
        trainingEntries: entries,
        sleepEntries: sleepEntries,
        isLoading: false,
      );
    } catch (e) {
      // En caso de error (sin conexión), mantener listas vacías
      state = state.copyWith(
        workoutPlans: [],
        trainingEntries: [],
        sleepEntries: [],
        isLoading: false,
      );
    }
  }

  void toggleExerciseCompletion(String workoutId, String exerciseId) async {
    print('Toggling exercise: $exerciseId in workout: $workoutId');
    
    final updatedWorkouts = state.workoutPlans.map((workout) {
      if (workout.id == workoutId) {
        final updatedExercises = workout.exercises.map((exercise) {
          if (exercise.id == exerciseId) {
            final newCompleted = !exercise.completed;
            print('Exercise ${exercise.name} changed from ${exercise.completed} to $newCompleted');
            return exercise.copyWith(completed: newCompleted);
          }
          return exercise;
        }).toList();
        
        final allCompleted = updatedExercises.every((e) => e.completed);
        return workout.copyWith(
          exercises: updatedExercises,
          completed: allCompleted,
        );
      }
      return workout;
    }).toList();

    state = state.copyWith(workoutPlans: updatedWorkouts);
    print('State updated with ${updatedWorkouts.length} workouts');
    
    // Update in service
    try {
      final updatedWorkout = updatedWorkouts.firstWhere((w) => w.id == workoutId);
      await _trainingService.updateWorkoutPlan(updatedWorkout);
    } catch (e) {
      print('Error updating workout in service: $e');
    }
  }

  void addWorkoutPlan(WorkoutPlan workout) async {
    state = state.copyWith(
      workoutPlans: [...state.workoutPlans, workout],
    );
    await _trainingService.addWorkoutPlan(workout);
  }

  void addSleepEntry(SleepEntry sleepEntry) async {
    state = state.copyWith(
      sleepEntries: [...state.sleepEntries, sleepEntry],
    );
    await _trainingService.addSleepEntry(sleepEntry);
  }

  void addTrainingEntry(TrainingEntry entry) async {
    state = state.copyWith(
      trainingEntries: [...state.trainingEntries, entry],
    );
    await _trainingService.addTrainingEntry(entry);
  }

  List<WorkoutPlan> get todayWorkouts {
    final today = DateTime.now();
    return state.workoutPlans.where((workout) {
      return workout.scheduledDate.day == today.day &&
             workout.scheduledDate.month == today.month &&
             workout.scheduledDate.year == today.year;
    }).toList();
  }

  int get completedExercisesToday {
    return todayWorkouts
        .expand((workout) => workout.exercises)
        .where((exercise) => exercise.completed)
        .length;
  }

  int get totalExercisesToday {
    return todayWorkouts
        .expand((workout) => workout.exercises)
        .length;
  }
}

final trainingProvider = StateNotifierProvider<TrainingNotifier, TrainingState>((ref) {
  return TrainingNotifier();
});