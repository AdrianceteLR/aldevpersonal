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
      // Load existing data
      final workouts = await _trainingService.getWorkoutPlans();
      final entries = await _trainingService.getTrainingEntries();
      final sleepEntries = await _trainingService.getSleepEntries();
      
      // If no workouts exist, add some initial mock data
      if (workouts.isEmpty) {
        final mockWorkouts = [
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
        
        for (final workout in mockWorkouts) {
          await _trainingService.addWorkoutPlan(workout);
        }
        
        state = state.copyWith(
          workoutPlans: mockWorkouts,
          trainingEntries: entries,
          sleepEntries: sleepEntries,
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          workoutPlans: workouts,
          trainingEntries: entries,
          sleepEntries: sleepEntries,
          isLoading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  void toggleExerciseCompletion(String workoutId, String exerciseName) async {
    final updatedWorkouts = state.workoutPlans.map((workout) {
      if (workout.id == workoutId) {
        final updatedExercises = workout.exercises.map((exercise) {
          if (exercise.name == exerciseName) {
            return exercise.copyWith(completed: !exercise.completed);
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
    
    // Update in service
    final updatedWorkout = updatedWorkouts.firstWhere((w) => w.id == workoutId);
    await _trainingService.updateWorkoutPlan(updatedWorkout);
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