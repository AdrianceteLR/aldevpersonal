import 'package:freezed_annotation/freezed_annotation.dart';

part 'training_entry_model.freezed.dart';
part 'training_entry_model.g.dart';

@freezed
class TrainingEntry with _$TrainingEntry {
  const factory TrainingEntry({
    required String id,
    required String exerciseName,
    required int sets,
    required int reps,
    required double weight,
    required DateTime date,
    required bool completed,
    String? notes,
  }) = _TrainingEntry;

  factory TrainingEntry.fromJson(Map<String, dynamic> json) =>
      _$TrainingEntryFromJson(json);
}

@freezed
class SleepEntry with _$SleepEntry {
  const factory SleepEntry({
    required String id,
    required DateTime bedTime,
    required DateTime wakeTime,
    required int quality, // 1-5 scale
    required DateTime date,
    String? notes,
  }) = _SleepEntry;

  factory SleepEntry.fromJson(Map<String, dynamic> json) =>
      _$SleepEntryFromJson(json);
}

@freezed
class WorkoutPlan with _$WorkoutPlan {
  const factory WorkoutPlan({
    required String id,
    required String name,
    required List<PlannedExercise> exercises,
    required DateTime scheduledDate,
    required bool completed,
  }) = _WorkoutPlan;

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) =>
      _$WorkoutPlanFromJson(json);
}

@freezed
class PlannedExercise with _$PlannedExercise {
  const factory PlannedExercise({
    required String name,
    required int targetSets,
    required int targetReps,
    required double targetWeight,
    int? actualSets,
    int? actualReps,
    double? actualWeight,
    required bool completed,
  }) = _PlannedExercise;

  factory PlannedExercise.fromJson(Map<String, dynamic> json) =>
      _$PlannedExerciseFromJson(json);
}