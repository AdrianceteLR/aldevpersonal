// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrainingPlanImpl _$$TrainingPlanImplFromJson(Map<String, dynamic> json) =>
    _$TrainingPlanImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      weeklyWorkouts: (json['weeklyWorkouts'] as List<dynamic>)
          .map((e) => WeeklyWorkout.fromJson(e as Map<String, dynamic>))
          .toList(),
      startDate: DateTime.parse(json['startDate'] as String),
      weeksToRepeat: json['weeksToRepeat'] as int,
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$$TrainingPlanImplToJson(_$TrainingPlanImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'weeklyWorkouts': instance.weeklyWorkouts,
      'startDate': instance.startDate.toIso8601String(),
      'weeksToRepeat': instance.weeksToRepeat,
      'isActive': instance.isActive,
    };

_$WeeklyWorkoutImpl _$$WeeklyWorkoutImplFromJson(Map<String, dynamic> json) =>
    _$WeeklyWorkoutImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      dayOfWeek: json['dayOfWeek'] as int,
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => PlannedExercise.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$WeeklyWorkoutImplToJson(_$WeeklyWorkoutImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'dayOfWeek': instance.dayOfWeek,
      'exercises': instance.exercises,
    };