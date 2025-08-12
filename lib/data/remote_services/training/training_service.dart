import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/models/training_entry_model.dart';

class TrainingService {
  static final TrainingService _instance = TrainingService._internal();
  factory TrainingService() => _instance;
  TrainingService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Collections
  CollectionReference get _workoutPlans => _firestore.collection('workout_plans');
  CollectionReference get _trainingEntries => _firestore.collection('training_entries');
  CollectionReference get _sleepEntries => _firestore.collection('sleep_entries');

  // Workout Plans
  Future<List<WorkoutPlan>> getWorkoutPlans() async {
    final snapshot = await _workoutPlans.get();
    return snapshot.docs.map((doc) => 
      WorkoutPlanFirestore.fromFirestore(doc.data() as Map<String, dynamic>, doc.id)
    ).toList();
  }

  Future<void> addWorkoutPlan(WorkoutPlan workout) async {
    await _workoutPlans.doc(workout.id).set(workout.toFirestore());
  }

  Future<void> updateWorkoutPlan(WorkoutPlan workout) async {
    await _workoutPlans.doc(workout.id).update(workout.toFirestore());
  }

  Future<void> deleteWorkoutPlan(String workoutId) async {
    await _workoutPlans.doc(workoutId).delete();
  }

  // Training Entries
  Future<List<TrainingEntry>> getTrainingEntries() async {
    final snapshot = await _trainingEntries.get();
    return snapshot.docs.map((doc) => 
      TrainingEntryFirestore.fromFirestore(doc.data() as Map<String, dynamic>, doc.id)
    ).toList();
  }

  Future<void> addTrainingEntry(TrainingEntry entry) async {
    await _trainingEntries.doc(entry.id).set(entry.toFirestore());
  }

  // Sleep Entries
  Future<List<SleepEntry>> getSleepEntries() async {
    final snapshot = await _sleepEntries.get();
    return snapshot.docs.map((doc) => 
      SleepEntryFirestore.fromFirestore(doc.data() as Map<String, dynamic>, doc.id)
    ).toList();
  }

  Future<void> addSleepEntry(SleepEntry entry) async {
    await _sleepEntries.doc(entry.id).set(entry.toFirestore());
  }

  // Statistics
  Future<Map<String, dynamic>> getTrainingStats() async {
    final workouts = await getWorkoutPlans();
    final entries = await getTrainingEntries();
    final sleepData = await getSleepEntries();
    
    final completedWorkouts = workouts.where((w) => w.completed).length;
    final totalExercises = entries.length;
    final averageSleepQuality = sleepData.isNotEmpty 
        ? sleepData.map((s) => s.quality).reduce((a, b) => a + b) / sleepData.length
        : 0.0;

    return {
      'completedWorkouts': completedWorkouts,
      'totalExercises': totalExercises,
      'averageSleepQuality': averageSleepQuality,
      'totalWorkouts': workouts.length,
    };
  }
}