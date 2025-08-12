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

extension TrainingEntryFirestore on TrainingEntry {
  Map<String, dynamic> toFirestore() {
    return {
      'exerciseName': exerciseName,
      'sets': sets,
      'reps': reps,
      'weight': weight,
      'date': date.toIso8601String(),
      'completed': completed,
      'notes': notes,
    };
  }

  static TrainingEntry fromFirestore(Map<String, dynamic> json, String id) {
    return TrainingEntry(
      id: id,
      exerciseName: json['exerciseName'] as String,
      sets: json['sets'] as int,
      reps: json['reps'] as int,
      weight: (json['weight'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      completed: json['completed'] as bool,
      notes: json['notes'] as String?,
    );
  }
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

extension SleepEntryFirestore on SleepEntry {
  Map<String, dynamic> toFirestore() {
    return {
      'bedTime': bedTime.toIso8601String(),
      'wakeTime': wakeTime.toIso8601String(),
      'quality': quality,
      'date': date.toIso8601String(),
      'notes': notes,
    };
  }

  static SleepEntry fromFirestore(Map<String, dynamic> json, String id) {
    return SleepEntry(
      id: id,
      bedTime: DateTime.parse(json['bedTime'] as String),
      wakeTime: DateTime.parse(json['wakeTime'] as String),
      quality: json['quality'] as int,
      date: DateTime.parse(json['date'] as String),
      notes: json['notes'] as String?,
    );
  }
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

extension WorkoutPlanFirestore on WorkoutPlan {
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'exercises': exercises.map((e) => e.toFirestore()).toList(),
      'scheduledDate': scheduledDate.toIso8601String(),
      'completed': completed,
    };
  }

  static WorkoutPlan fromFirestore(Map<String, dynamic> json, String id) {
    return WorkoutPlan(
      id: id,
      name: json['name'] as String,
      exercises: (json['exercises'] as List)
          .map((e) => PlannedExerciseFirestore.fromFirestore(e as Map<String, dynamic>))
          .toList(),
      scheduledDate: DateTime.parse(json['scheduledDate'] as String),
      completed: json['completed'] as bool,
    );
  }
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

extension PlannedExerciseFirestore on PlannedExercise {
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'targetSets': targetSets,
      'targetReps': targetReps,
      'targetWeight': targetWeight,
      'actualSets': actualSets,
      'actualReps': actualReps,
      'actualWeight': actualWeight,
      'completed': completed,
    };
  }

  static PlannedExercise fromFirestore(Map<String, dynamic> json) {
    return PlannedExercise(
      name: json['name'] as String,
      targetSets: json['targetSets'] as int,
      targetReps: json['targetReps'] as int,
      targetWeight: (json['targetWeight'] as num).toDouble(),
      actualSets: json['actualSets'] as int?,
      actualReps: json['actualReps'] as int?,
      actualWeight: (json['actualWeight'] as num?)?.toDouble(),
      completed: json['completed'] as bool,
    );
  }
}