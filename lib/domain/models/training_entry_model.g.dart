// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrainingEntryImpl _$$TrainingEntryImplFromJson(Map<String, dynamic> json) =>
    _$TrainingEntryImpl(
      id: json['id'] as String,
      exerciseName: json['exerciseName'] as String,
      sets: (json['sets'] as num).toInt(),
      reps: (json['reps'] as num).toInt(),
      weight: (json['weight'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      completed: json['completed'] as bool,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$TrainingEntryImplToJson(_$TrainingEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'exerciseName': instance.exerciseName,
      'sets': instance.sets,
      'reps': instance.reps,
      'weight': instance.weight,
      'date': instance.date.toIso8601String(),
      'completed': instance.completed,
      'notes': instance.notes,
    };

_$SleepEntryImpl _$$SleepEntryImplFromJson(Map<String, dynamic> json) =>
    _$SleepEntryImpl(
      id: json['id'] as String,
      bedTime: DateTime.parse(json['bedTime'] as String),
      wakeTime: DateTime.parse(json['wakeTime'] as String),
      quality: (json['quality'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$SleepEntryImplToJson(_$SleepEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bedTime': instance.bedTime.toIso8601String(),
      'wakeTime': instance.wakeTime.toIso8601String(),
      'quality': instance.quality,
      'date': instance.date.toIso8601String(),
      'notes': instance.notes,
    };

_$WorkoutPlanImpl _$$WorkoutPlanImplFromJson(Map<String, dynamic> json) =>
    _$WorkoutPlanImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => PlannedExercise.fromJson(e as Map<String, dynamic>))
          .toList(),
      scheduledDate: DateTime.parse(json['scheduledDate'] as String),
      completed: json['completed'] as bool,
    );

Map<String, dynamic> _$$WorkoutPlanImplToJson(_$WorkoutPlanImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'exercises': instance.exercises,
      'scheduledDate': instance.scheduledDate.toIso8601String(),
      'completed': instance.completed,
    };

_$PlannedExerciseImpl _$$PlannedExerciseImplFromJson(
  Map<String, dynamic> json,
) => _$PlannedExerciseImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  targetSets: (json['targetSets'] as num).toInt(),
  targetReps: (json['targetReps'] as num).toInt(),
  targetWeight: (json['targetWeight'] as num).toDouble(),
  actualSets: (json['actualSets'] as num?)?.toInt(),
  actualReps: (json['actualReps'] as num?)?.toInt(),
  actualWeight: (json['actualWeight'] as num?)?.toDouble(),
  completed: json['completed'] as bool,
);

Map<String, dynamic> _$$PlannedExerciseImplToJson(
  _$PlannedExerciseImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'targetSets': instance.targetSets,
  'targetReps': instance.targetReps,
  'targetWeight': instance.targetWeight,
  'actualSets': instance.actualSets,
  'actualReps': instance.actualReps,
  'actualWeight': instance.actualWeight,
  'completed': instance.completed,
};
