import '../../../domain/models/training_entry_model.dart';

class TrainingService {
  static final TrainingService _instance = TrainingService._internal();
  factory TrainingService() => _instance;
  TrainingService._internal();

  final List<WorkoutPlan> _workoutPlans = [];
  final List<TrainingEntry> _trainingEntries = [];
  final List<SleepEntry> _sleepEntries = [];

  // Workout Plans
  Future<List<WorkoutPlan>> getWorkoutPlans() async {
    await Future.delayed(const Duration(milliseconds: 100)); // Simulate network delay
    return List.from(_workoutPlans);
  }

  Future<void> addWorkoutPlan(WorkoutPlan workout) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _workoutPlans.add(workout);
  }

  Future<void> updateWorkoutPlan(WorkoutPlan workout) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final index = _workoutPlans.indexWhere((w) => w.id == workout.id);
    if (index != -1) {
      _workoutPlans[index] = workout;
    }
  }

  Future<void> deleteWorkoutPlan(String workoutId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _workoutPlans.removeWhere((w) => w.id == workoutId);
  }

  // Training Entries
  Future<List<TrainingEntry>> getTrainingEntries() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(_trainingEntries);
  }

  Future<void> addTrainingEntry(TrainingEntry entry) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _trainingEntries.add(entry);
  }

  // Sleep Entries
  Future<List<SleepEntry>> getSleepEntries() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(_sleepEntries);
  }

  Future<void> addSleepEntry(SleepEntry entry) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _sleepEntries.add(entry);
  }

  // Statistics
  Future<Map<String, dynamic>> getTrainingStats() async {
    await Future.delayed(const Duration(milliseconds: 100));
    
    final completedWorkouts = _workoutPlans.where((w) => w.completed).length;
    final totalExercises = _trainingEntries.length;
    final averageSleepQuality = _sleepEntries.isNotEmpty 
        ? _sleepEntries.map((s) => s.quality).reduce((a, b) => a + b) / _sleepEntries.length
        : 0.0;

    return {
      'completedWorkouts': completedWorkouts,
      'totalExercises': totalExercises,
      'averageSleepQuality': averageSleepQuality,
      'totalWorkouts': _workoutPlans.length,
    };
  }
}