import 'package:freezed_annotation/freezed_annotation.dart';
import 'training_entry_model.dart';

part 'training_plan_model.freezed.dart';
part 'training_plan_model.g.dart';

@freezed
class TrainingPlan with _$TrainingPlan {
  const factory TrainingPlan({
    required String id,
    required String name,
    required List<WeeklyWorkout> weeklyWorkouts,
    required DateTime startDate,
    required int weeksToRepeat,
    required bool isActive,
  }) = _TrainingPlan;

  factory TrainingPlan.fromJson(Map<String, dynamic> json) =>
      _$TrainingPlanFromJson(json);
}

@freezed
class WeeklyWorkout with _$WeeklyWorkout {
  const factory WeeklyWorkout({
    required String id,
    required String name,
    required int dayOfWeek, // 1-7 (Monday-Sunday)
    required List<PlannedExercise> exercises,
  }) = _WeeklyWorkout;

  factory WeeklyWorkout.fromJson(Map<String, dynamic> json) =>
      _$WeeklyWorkoutFromJson(json);
}