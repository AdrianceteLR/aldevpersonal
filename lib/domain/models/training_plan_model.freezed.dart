// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_plan_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TrainingPlan _$TrainingPlanFromJson(Map<String, dynamic> json) {
  return _TrainingPlan.fromJson(json);
}

/// @nodoc
mixin _$TrainingPlan {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<WeeklyWorkout> get weeklyWorkouts => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  int get weeksToRepeat => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrainingPlanCopyWith<TrainingPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainingPlanCopyWith<$Res> {
  factory $TrainingPlanCopyWith(
          TrainingPlan value, $Res Function(TrainingPlan) then) =
      _$TrainingPlanCopyWithImpl<$Res, TrainingPlan>;
  @useResult
  $Res call(
      {String id,
      String name,
      List<WeeklyWorkout> weeklyWorkouts,
      DateTime startDate,
      int weeksToRepeat,
      bool isActive});
}

/// @nodoc
class _$TrainingPlanCopyWithImpl<$Res, $Val extends TrainingPlan>
    implements $TrainingPlanCopyWith<$Res> {
  _$TrainingPlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? weeklyWorkouts = null,
    Object? startDate = null,
    Object? weeksToRepeat = null,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      weeklyWorkouts: null == weeklyWorkouts
          ? _value.weeklyWorkouts
          : weeklyWorkouts // ignore: cast_nullable_to_non_nullable
              as List<WeeklyWorkout>,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      weeksToRepeat: null == weeksToRepeat
          ? _value.weeksToRepeat
          : weeksToRepeat // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrainingPlanImplCopyWith<$Res>
    implements $TrainingPlanCopyWith<$Res> {
  factory _$$TrainingPlanImplCopyWith(
          _$TrainingPlanImpl value, $Res Function(_$TrainingPlanImpl) then) =
      __$$TrainingPlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      List<WeeklyWorkout> weeklyWorkouts,
      DateTime startDate,
      int weeksToRepeat,
      bool isActive});
}

/// @nodoc
class __$$TrainingPlanImplCopyWithImpl<$Res>
    extends _$TrainingPlanCopyWithImpl<$Res, _$TrainingPlanImpl>
    implements _$$TrainingPlanImplCopyWith<$Res> {
  __$$TrainingPlanImplCopyWithImpl(
      _$TrainingPlanImpl _value, $Res Function(_$TrainingPlanImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? weeklyWorkouts = null,
    Object? startDate = null,
    Object? weeksToRepeat = null,
    Object? isActive = null,
  }) {
    return _then(_$TrainingPlanImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      weeklyWorkouts: null == weeklyWorkouts
          ? _value._weeklyWorkouts
          : weeklyWorkouts // ignore: cast_nullable_to_non_nullable
              as List<WeeklyWorkout>,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      weeksToRepeat: null == weeksToRepeat
          ? _value.weeksToRepeat
          : weeksToRepeat // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrainingPlanImpl implements _TrainingPlan {
  const _$TrainingPlanImpl(
      {required this.id,
      required this.name,
      required final List<WeeklyWorkout> weeklyWorkouts,
      required this.startDate,
      required this.weeksToRepeat,
      required this.isActive})
      : _weeklyWorkouts = weeklyWorkouts;

  factory _$TrainingPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrainingPlanImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  final List<WeeklyWorkout> _weeklyWorkouts;
  @override
  List<WeeklyWorkout> get weeklyWorkouts {
    if (_weeklyWorkouts is EqualUnmodifiableListView) return _weeklyWorkouts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weeklyWorkouts);
  }

  @override
  final DateTime startDate;
  @override
  final int weeksToRepeat;
  @override
  final bool isActive;

  @override
  String toString() {
    return 'TrainingPlan(id: $id, name: $name, weeklyWorkouts: $weeklyWorkouts, startDate: $startDate, weeksToRepeat: $weeksToRepeat, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrainingPlanImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._weeklyWorkouts, _weeklyWorkouts) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.weeksToRepeat, weeksToRepeat) ||
                other.weeksToRepeat == weeksToRepeat) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(_weeklyWorkouts),
      startDate,
      weeksToRepeat,
      isActive);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrainingPlanImplCopyWith<_$TrainingPlanImpl> get copyWith =>
      __$$TrainingPlanImplCopyWithImpl<_$TrainingPlanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrainingPlanImplToJson(this);
  }
}

abstract class _TrainingPlan implements TrainingPlan {
  const factory _TrainingPlan(
      {required final String id,
      required final String name,
      required final List<WeeklyWorkout> weeklyWorkouts,
      required final DateTime startDate,
      required final int weeksToRepeat,
      required final bool isActive}) = _$TrainingPlanImpl;

  factory _TrainingPlan.fromJson(Map<String, dynamic> json) =
      _$TrainingPlanImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  List<WeeklyWorkout> get weeklyWorkouts;
  @override
  DateTime get startDate;
  @override
  int get weeksToRepeat;
  @override
  bool get isActive;
  @override
  @JsonKey(ignore: true)
  _$$TrainingPlanImplCopyWith<_$TrainingPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WeeklyWorkout _$WeeklyWorkoutFromJson(Map<String, dynamic> json) {
  return _WeeklyWorkout.fromJson(json);
}

/// @nodoc
mixin _$WeeklyWorkout {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get dayOfWeek => throw _privateConstructorUsedError; // 1-7 (Monday-Sunday)
  List<PlannedExercise> get exercises => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeeklyWorkoutCopyWith<WeeklyWorkout> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeeklyWorkoutCopyWith<$Res> {
  factory $WeeklyWorkoutCopyWith(
          WeeklyWorkout value, $Res Function(WeeklyWorkout) then) =
      _$WeeklyWorkoutCopyWithImpl<$Res, WeeklyWorkout>;
  @useResult
  $Res call(
      {String id, String name, int dayOfWeek, List<PlannedExercise> exercises});
}

/// @nodoc
class _$WeeklyWorkoutCopyWithImpl<$Res, $Val extends WeeklyWorkout>
    implements $WeeklyWorkoutCopyWith<$Res> {
  _$WeeklyWorkoutCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? dayOfWeek = null,
    Object? exercises = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      dayOfWeek: null == dayOfWeek
          ? _value.dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as int,
      exercises: null == exercises
          ? _value.exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<PlannedExercise>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeeklyWorkoutImplCopyWith<$Res>
    implements $WeeklyWorkoutCopyWith<$Res> {
  factory _$$WeeklyWorkoutImplCopyWith(
          _$WeeklyWorkoutImpl value, $Res Function(_$WeeklyWorkoutImpl) then) =
      __$$WeeklyWorkoutImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String name, int dayOfWeek, List<PlannedExercise> exercises});
}

/// @nodoc
class __$$WeeklyWorkoutImplCopyWithImpl<$Res>
    extends _$WeeklyWorkoutCopyWithImpl<$Res, _$WeeklyWorkoutImpl>
    implements _$$WeeklyWorkoutImplCopyWith<$Res> {
  __$$WeeklyWorkoutImplCopyWithImpl(
      _$WeeklyWorkoutImpl _value, $Res Function(_$WeeklyWorkoutImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? dayOfWeek = null,
    Object? exercises = null,
  }) {
    return _then(_$WeeklyWorkoutImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      dayOfWeek: null == dayOfWeek
          ? _value.dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as int,
      exercises: null == exercises
          ? _value._exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<PlannedExercise>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeeklyWorkoutImpl implements _WeeklyWorkout {
  const _$WeeklyWorkoutImpl(
      {required this.id,
      required this.name,
      required this.dayOfWeek,
      required final List<PlannedExercise> exercises})
      : _exercises = exercises;

  factory _$WeeklyWorkoutImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeeklyWorkoutImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final int dayOfWeek;
// 1-7 (Monday-Sunday)
  final List<PlannedExercise> _exercises;
  @override
  List<PlannedExercise> get exercises {
    if (_exercises is EqualUnmodifiableListView) return _exercises;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exercises);
  }

  @override
  String toString() {
    return 'WeeklyWorkout(id: $id, name: $name, dayOfWeek: $dayOfWeek, exercises: $exercises)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeeklyWorkoutImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                other.dayOfWeek == dayOfWeek) &&
            const DeepCollectionEquality()
                .equals(other._exercises, _exercises));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, dayOfWeek,
      const DeepCollectionEquality().hash(_exercises));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeeklyWorkoutImplCopyWith<_$WeeklyWorkoutImpl> get copyWith =>
      __$$WeeklyWorkoutImplCopyWithImpl<_$WeeklyWorkoutImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeeklyWorkoutImplToJson(this);
  }
}

abstract class _WeeklyWorkout implements WeeklyWorkout {
  const factory _WeeklyWorkout(
      {required final String id,
      required final String name,
      required final int dayOfWeek,
      required final List<PlannedExercise> exercises}) = _$WeeklyWorkoutImpl;

  factory _WeeklyWorkout.fromJson(Map<String, dynamic> json) =
      _$WeeklyWorkoutImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int get dayOfWeek;
  @override // 1-7 (Monday-Sunday)
  List<PlannedExercise> get exercises;
  @override
  @JsonKey(ignore: true)
  _$$WeeklyWorkoutImplCopyWith<_$WeeklyWorkoutImpl> get copyWith =>
      throw _privateConstructorUsedError;
}