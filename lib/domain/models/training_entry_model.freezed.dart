// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_entry_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TrainingEntry _$TrainingEntryFromJson(Map<String, dynamic> json) {
  return _TrainingEntry.fromJson(json);
}

/// @nodoc
mixin _$TrainingEntry {
  String get id => throw _privateConstructorUsedError;
  String get exerciseName => throw _privateConstructorUsedError;
  int get sets => throw _privateConstructorUsedError;
  int get reps => throw _privateConstructorUsedError;
  double get weight => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  bool get completed => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this TrainingEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TrainingEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrainingEntryCopyWith<TrainingEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainingEntryCopyWith<$Res> {
  factory $TrainingEntryCopyWith(
    TrainingEntry value,
    $Res Function(TrainingEntry) then,
  ) = _$TrainingEntryCopyWithImpl<$Res, TrainingEntry>;
  @useResult
  $Res call({
    String id,
    String exerciseName,
    int sets,
    int reps,
    double weight,
    DateTime date,
    bool completed,
    String? notes,
  });
}

/// @nodoc
class _$TrainingEntryCopyWithImpl<$Res, $Val extends TrainingEntry>
    implements $TrainingEntryCopyWith<$Res> {
  _$TrainingEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrainingEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? exerciseName = null,
    Object? sets = null,
    Object? reps = null,
    Object? weight = null,
    Object? date = null,
    Object? completed = null,
    Object? notes = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            exerciseName: null == exerciseName
                ? _value.exerciseName
                : exerciseName // ignore: cast_nullable_to_non_nullable
                      as String,
            sets: null == sets
                ? _value.sets
                : sets // ignore: cast_nullable_to_non_nullable
                      as int,
            reps: null == reps
                ? _value.reps
                : reps // ignore: cast_nullable_to_non_nullable
                      as int,
            weight: null == weight
                ? _value.weight
                : weight // ignore: cast_nullable_to_non_nullable
                      as double,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            completed: null == completed
                ? _value.completed
                : completed // ignore: cast_nullable_to_non_nullable
                      as bool,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TrainingEntryImplCopyWith<$Res>
    implements $TrainingEntryCopyWith<$Res> {
  factory _$$TrainingEntryImplCopyWith(
    _$TrainingEntryImpl value,
    $Res Function(_$TrainingEntryImpl) then,
  ) = __$$TrainingEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String exerciseName,
    int sets,
    int reps,
    double weight,
    DateTime date,
    bool completed,
    String? notes,
  });
}

/// @nodoc
class __$$TrainingEntryImplCopyWithImpl<$Res>
    extends _$TrainingEntryCopyWithImpl<$Res, _$TrainingEntryImpl>
    implements _$$TrainingEntryImplCopyWith<$Res> {
  __$$TrainingEntryImplCopyWithImpl(
    _$TrainingEntryImpl _value,
    $Res Function(_$TrainingEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TrainingEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? exerciseName = null,
    Object? sets = null,
    Object? reps = null,
    Object? weight = null,
    Object? date = null,
    Object? completed = null,
    Object? notes = freezed,
  }) {
    return _then(
      _$TrainingEntryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        exerciseName: null == exerciseName
            ? _value.exerciseName
            : exerciseName // ignore: cast_nullable_to_non_nullable
                  as String,
        sets: null == sets
            ? _value.sets
            : sets // ignore: cast_nullable_to_non_nullable
                  as int,
        reps: null == reps
            ? _value.reps
            : reps // ignore: cast_nullable_to_non_nullable
                  as int,
        weight: null == weight
            ? _value.weight
            : weight // ignore: cast_nullable_to_non_nullable
                  as double,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        completed: null == completed
            ? _value.completed
            : completed // ignore: cast_nullable_to_non_nullable
                  as bool,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TrainingEntryImpl implements _TrainingEntry {
  const _$TrainingEntryImpl({
    required this.id,
    required this.exerciseName,
    required this.sets,
    required this.reps,
    required this.weight,
    required this.date,
    required this.completed,
    this.notes,
  });

  factory _$TrainingEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrainingEntryImplFromJson(json);

  @override
  final String id;
  @override
  final String exerciseName;
  @override
  final int sets;
  @override
  final int reps;
  @override
  final double weight;
  @override
  final DateTime date;
  @override
  final bool completed;
  @override
  final String? notes;

  @override
  String toString() {
    return 'TrainingEntry(id: $id, exerciseName: $exerciseName, sets: $sets, reps: $reps, weight: $weight, date: $date, completed: $completed, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrainingEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.exerciseName, exerciseName) ||
                other.exerciseName == exerciseName) &&
            (identical(other.sets, sets) || other.sets == sets) &&
            (identical(other.reps, reps) || other.reps == reps) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    exerciseName,
    sets,
    reps,
    weight,
    date,
    completed,
    notes,
  );

  /// Create a copy of TrainingEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrainingEntryImplCopyWith<_$TrainingEntryImpl> get copyWith =>
      __$$TrainingEntryImplCopyWithImpl<_$TrainingEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrainingEntryImplToJson(this);
  }
}

abstract class _TrainingEntry implements TrainingEntry {
  const factory _TrainingEntry({
    required final String id,
    required final String exerciseName,
    required final int sets,
    required final int reps,
    required final double weight,
    required final DateTime date,
    required final bool completed,
    final String? notes,
  }) = _$TrainingEntryImpl;

  factory _TrainingEntry.fromJson(Map<String, dynamic> json) =
      _$TrainingEntryImpl.fromJson;

  @override
  String get id;
  @override
  String get exerciseName;
  @override
  int get sets;
  @override
  int get reps;
  @override
  double get weight;
  @override
  DateTime get date;
  @override
  bool get completed;
  @override
  String? get notes;

  /// Create a copy of TrainingEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrainingEntryImplCopyWith<_$TrainingEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SleepEntry _$SleepEntryFromJson(Map<String, dynamic> json) {
  return _SleepEntry.fromJson(json);
}

/// @nodoc
mixin _$SleepEntry {
  String get id => throw _privateConstructorUsedError;
  DateTime get bedTime => throw _privateConstructorUsedError;
  DateTime get wakeTime => throw _privateConstructorUsedError;
  int get quality => throw _privateConstructorUsedError; // 1-5 scale
  DateTime get date => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this SleepEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SleepEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SleepEntryCopyWith<SleepEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SleepEntryCopyWith<$Res> {
  factory $SleepEntryCopyWith(
    SleepEntry value,
    $Res Function(SleepEntry) then,
  ) = _$SleepEntryCopyWithImpl<$Res, SleepEntry>;
  @useResult
  $Res call({
    String id,
    DateTime bedTime,
    DateTime wakeTime,
    int quality,
    DateTime date,
    String? notes,
  });
}

/// @nodoc
class _$SleepEntryCopyWithImpl<$Res, $Val extends SleepEntry>
    implements $SleepEntryCopyWith<$Res> {
  _$SleepEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SleepEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bedTime = null,
    Object? wakeTime = null,
    Object? quality = null,
    Object? date = null,
    Object? notes = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            bedTime: null == bedTime
                ? _value.bedTime
                : bedTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            wakeTime: null == wakeTime
                ? _value.wakeTime
                : wakeTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            quality: null == quality
                ? _value.quality
                : quality // ignore: cast_nullable_to_non_nullable
                      as int,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SleepEntryImplCopyWith<$Res>
    implements $SleepEntryCopyWith<$Res> {
  factory _$$SleepEntryImplCopyWith(
    _$SleepEntryImpl value,
    $Res Function(_$SleepEntryImpl) then,
  ) = __$$SleepEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    DateTime bedTime,
    DateTime wakeTime,
    int quality,
    DateTime date,
    String? notes,
  });
}

/// @nodoc
class __$$SleepEntryImplCopyWithImpl<$Res>
    extends _$SleepEntryCopyWithImpl<$Res, _$SleepEntryImpl>
    implements _$$SleepEntryImplCopyWith<$Res> {
  __$$SleepEntryImplCopyWithImpl(
    _$SleepEntryImpl _value,
    $Res Function(_$SleepEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SleepEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bedTime = null,
    Object? wakeTime = null,
    Object? quality = null,
    Object? date = null,
    Object? notes = freezed,
  }) {
    return _then(
      _$SleepEntryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        bedTime: null == bedTime
            ? _value.bedTime
            : bedTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        wakeTime: null == wakeTime
            ? _value.wakeTime
            : wakeTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        quality: null == quality
            ? _value.quality
            : quality // ignore: cast_nullable_to_non_nullable
                  as int,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SleepEntryImpl implements _SleepEntry {
  const _$SleepEntryImpl({
    required this.id,
    required this.bedTime,
    required this.wakeTime,
    required this.quality,
    required this.date,
    this.notes,
  });

  factory _$SleepEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$SleepEntryImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime bedTime;
  @override
  final DateTime wakeTime;
  @override
  final int quality;
  // 1-5 scale
  @override
  final DateTime date;
  @override
  final String? notes;

  @override
  String toString() {
    return 'SleepEntry(id: $id, bedTime: $bedTime, wakeTime: $wakeTime, quality: $quality, date: $date, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SleepEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.bedTime, bedTime) || other.bedTime == bedTime) &&
            (identical(other.wakeTime, wakeTime) ||
                other.wakeTime == wakeTime) &&
            (identical(other.quality, quality) || other.quality == quality) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, bedTime, wakeTime, quality, date, notes);

  /// Create a copy of SleepEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SleepEntryImplCopyWith<_$SleepEntryImpl> get copyWith =>
      __$$SleepEntryImplCopyWithImpl<_$SleepEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SleepEntryImplToJson(this);
  }
}

abstract class _SleepEntry implements SleepEntry {
  const factory _SleepEntry({
    required final String id,
    required final DateTime bedTime,
    required final DateTime wakeTime,
    required final int quality,
    required final DateTime date,
    final String? notes,
  }) = _$SleepEntryImpl;

  factory _SleepEntry.fromJson(Map<String, dynamic> json) =
      _$SleepEntryImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get bedTime;
  @override
  DateTime get wakeTime;
  @override
  int get quality; // 1-5 scale
  @override
  DateTime get date;
  @override
  String? get notes;

  /// Create a copy of SleepEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SleepEntryImplCopyWith<_$SleepEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WorkoutPlan _$WorkoutPlanFromJson(Map<String, dynamic> json) {
  return _WorkoutPlan.fromJson(json);
}

/// @nodoc
mixin _$WorkoutPlan {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<PlannedExercise> get exercises => throw _privateConstructorUsedError;
  DateTime get scheduledDate => throw _privateConstructorUsedError;
  bool get completed => throw _privateConstructorUsedError;

  /// Serializes this WorkoutPlan to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutPlanCopyWith<WorkoutPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutPlanCopyWith<$Res> {
  factory $WorkoutPlanCopyWith(
    WorkoutPlan value,
    $Res Function(WorkoutPlan) then,
  ) = _$WorkoutPlanCopyWithImpl<$Res, WorkoutPlan>;
  @useResult
  $Res call({
    String id,
    String name,
    List<PlannedExercise> exercises,
    DateTime scheduledDate,
    bool completed,
  });
}

/// @nodoc
class _$WorkoutPlanCopyWithImpl<$Res, $Val extends WorkoutPlan>
    implements $WorkoutPlanCopyWith<$Res> {
  _$WorkoutPlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? exercises = null,
    Object? scheduledDate = null,
    Object? completed = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            exercises: null == exercises
                ? _value.exercises
                : exercises // ignore: cast_nullable_to_non_nullable
                      as List<PlannedExercise>,
            scheduledDate: null == scheduledDate
                ? _value.scheduledDate
                : scheduledDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            completed: null == completed
                ? _value.completed
                : completed // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WorkoutPlanImplCopyWith<$Res>
    implements $WorkoutPlanCopyWith<$Res> {
  factory _$$WorkoutPlanImplCopyWith(
    _$WorkoutPlanImpl value,
    $Res Function(_$WorkoutPlanImpl) then,
  ) = __$$WorkoutPlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    List<PlannedExercise> exercises,
    DateTime scheduledDate,
    bool completed,
  });
}

/// @nodoc
class __$$WorkoutPlanImplCopyWithImpl<$Res>
    extends _$WorkoutPlanCopyWithImpl<$Res, _$WorkoutPlanImpl>
    implements _$$WorkoutPlanImplCopyWith<$Res> {
  __$$WorkoutPlanImplCopyWithImpl(
    _$WorkoutPlanImpl _value,
    $Res Function(_$WorkoutPlanImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? exercises = null,
    Object? scheduledDate = null,
    Object? completed = null,
  }) {
    return _then(
      _$WorkoutPlanImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        exercises: null == exercises
            ? _value._exercises
            : exercises // ignore: cast_nullable_to_non_nullable
                  as List<PlannedExercise>,
        scheduledDate: null == scheduledDate
            ? _value.scheduledDate
            : scheduledDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        completed: null == completed
            ? _value.completed
            : completed // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkoutPlanImpl implements _WorkoutPlan {
  const _$WorkoutPlanImpl({
    required this.id,
    required this.name,
    required final List<PlannedExercise> exercises,
    required this.scheduledDate,
    required this.completed,
  }) : _exercises = exercises;

  factory _$WorkoutPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkoutPlanImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  final List<PlannedExercise> _exercises;
  @override
  List<PlannedExercise> get exercises {
    if (_exercises is EqualUnmodifiableListView) return _exercises;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exercises);
  }

  @override
  final DateTime scheduledDate;
  @override
  final bool completed;

  @override
  String toString() {
    return 'WorkoutPlan(id: $id, name: $name, exercises: $exercises, scheduledDate: $scheduledDate, completed: $completed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutPlanImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(
              other._exercises,
              _exercises,
            ) &&
            (identical(other.scheduledDate, scheduledDate) ||
                other.scheduledDate == scheduledDate) &&
            (identical(other.completed, completed) ||
                other.completed == completed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    const DeepCollectionEquality().hash(_exercises),
    scheduledDate,
    completed,
  );

  /// Create a copy of WorkoutPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutPlanImplCopyWith<_$WorkoutPlanImpl> get copyWith =>
      __$$WorkoutPlanImplCopyWithImpl<_$WorkoutPlanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkoutPlanImplToJson(this);
  }
}

abstract class _WorkoutPlan implements WorkoutPlan {
  const factory _WorkoutPlan({
    required final String id,
    required final String name,
    required final List<PlannedExercise> exercises,
    required final DateTime scheduledDate,
    required final bool completed,
  }) = _$WorkoutPlanImpl;

  factory _WorkoutPlan.fromJson(Map<String, dynamic> json) =
      _$WorkoutPlanImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  List<PlannedExercise> get exercises;
  @override
  DateTime get scheduledDate;
  @override
  bool get completed;

  /// Create a copy of WorkoutPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutPlanImplCopyWith<_$WorkoutPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlannedExercise _$PlannedExerciseFromJson(Map<String, dynamic> json) {
  return _PlannedExercise.fromJson(json);
}

/// @nodoc
mixin _$PlannedExercise {
  String get name => throw _privateConstructorUsedError;
  int get targetSets => throw _privateConstructorUsedError;
  int get targetReps => throw _privateConstructorUsedError;
  double get targetWeight => throw _privateConstructorUsedError;
  int? get actualSets => throw _privateConstructorUsedError;
  int? get actualReps => throw _privateConstructorUsedError;
  double? get actualWeight => throw _privateConstructorUsedError;
  bool get completed => throw _privateConstructorUsedError;

  /// Serializes this PlannedExercise to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlannedExercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlannedExerciseCopyWith<PlannedExercise> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlannedExerciseCopyWith<$Res> {
  factory $PlannedExerciseCopyWith(
    PlannedExercise value,
    $Res Function(PlannedExercise) then,
  ) = _$PlannedExerciseCopyWithImpl<$Res, PlannedExercise>;
  @useResult
  $Res call({
    String name,
    int targetSets,
    int targetReps,
    double targetWeight,
    int? actualSets,
    int? actualReps,
    double? actualWeight,
    bool completed,
  });
}

/// @nodoc
class _$PlannedExerciseCopyWithImpl<$Res, $Val extends PlannedExercise>
    implements $PlannedExerciseCopyWith<$Res> {
  _$PlannedExerciseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlannedExercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? targetSets = null,
    Object? targetReps = null,
    Object? targetWeight = null,
    Object? actualSets = freezed,
    Object? actualReps = freezed,
    Object? actualWeight = freezed,
    Object? completed = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            targetSets: null == targetSets
                ? _value.targetSets
                : targetSets // ignore: cast_nullable_to_non_nullable
                      as int,
            targetReps: null == targetReps
                ? _value.targetReps
                : targetReps // ignore: cast_nullable_to_non_nullable
                      as int,
            targetWeight: null == targetWeight
                ? _value.targetWeight
                : targetWeight // ignore: cast_nullable_to_non_nullable
                      as double,
            actualSets: freezed == actualSets
                ? _value.actualSets
                : actualSets // ignore: cast_nullable_to_non_nullable
                      as int?,
            actualReps: freezed == actualReps
                ? _value.actualReps
                : actualReps // ignore: cast_nullable_to_non_nullable
                      as int?,
            actualWeight: freezed == actualWeight
                ? _value.actualWeight
                : actualWeight // ignore: cast_nullable_to_non_nullable
                      as double?,
            completed: null == completed
                ? _value.completed
                : completed // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlannedExerciseImplCopyWith<$Res>
    implements $PlannedExerciseCopyWith<$Res> {
  factory _$$PlannedExerciseImplCopyWith(
    _$PlannedExerciseImpl value,
    $Res Function(_$PlannedExerciseImpl) then,
  ) = __$$PlannedExerciseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    int targetSets,
    int targetReps,
    double targetWeight,
    int? actualSets,
    int? actualReps,
    double? actualWeight,
    bool completed,
  });
}

/// @nodoc
class __$$PlannedExerciseImplCopyWithImpl<$Res>
    extends _$PlannedExerciseCopyWithImpl<$Res, _$PlannedExerciseImpl>
    implements _$$PlannedExerciseImplCopyWith<$Res> {
  __$$PlannedExerciseImplCopyWithImpl(
    _$PlannedExerciseImpl _value,
    $Res Function(_$PlannedExerciseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlannedExercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? targetSets = null,
    Object? targetReps = null,
    Object? targetWeight = null,
    Object? actualSets = freezed,
    Object? actualReps = freezed,
    Object? actualWeight = freezed,
    Object? completed = null,
  }) {
    return _then(
      _$PlannedExerciseImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        targetSets: null == targetSets
            ? _value.targetSets
            : targetSets // ignore: cast_nullable_to_non_nullable
                  as int,
        targetReps: null == targetReps
            ? _value.targetReps
            : targetReps // ignore: cast_nullable_to_non_nullable
                  as int,
        targetWeight: null == targetWeight
            ? _value.targetWeight
            : targetWeight // ignore: cast_nullable_to_non_nullable
                  as double,
        actualSets: freezed == actualSets
            ? _value.actualSets
            : actualSets // ignore: cast_nullable_to_non_nullable
                  as int?,
        actualReps: freezed == actualReps
            ? _value.actualReps
            : actualReps // ignore: cast_nullable_to_non_nullable
                  as int?,
        actualWeight: freezed == actualWeight
            ? _value.actualWeight
            : actualWeight // ignore: cast_nullable_to_non_nullable
                  as double?,
        completed: null == completed
            ? _value.completed
            : completed // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlannedExerciseImpl implements _PlannedExercise {
  const _$PlannedExerciseImpl({
    required this.name,
    required this.targetSets,
    required this.targetReps,
    required this.targetWeight,
    this.actualSets,
    this.actualReps,
    this.actualWeight,
    required this.completed,
  });

  factory _$PlannedExerciseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlannedExerciseImplFromJson(json);

  @override
  final String name;
  @override
  final int targetSets;
  @override
  final int targetReps;
  @override
  final double targetWeight;
  @override
  final int? actualSets;
  @override
  final int? actualReps;
  @override
  final double? actualWeight;
  @override
  final bool completed;

  @override
  String toString() {
    return 'PlannedExercise(name: $name, targetSets: $targetSets, targetReps: $targetReps, targetWeight: $targetWeight, actualSets: $actualSets, actualReps: $actualReps, actualWeight: $actualWeight, completed: $completed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlannedExerciseImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.targetSets, targetSets) ||
                other.targetSets == targetSets) &&
            (identical(other.targetReps, targetReps) ||
                other.targetReps == targetReps) &&
            (identical(other.targetWeight, targetWeight) ||
                other.targetWeight == targetWeight) &&
            (identical(other.actualSets, actualSets) ||
                other.actualSets == actualSets) &&
            (identical(other.actualReps, actualReps) ||
                other.actualReps == actualReps) &&
            (identical(other.actualWeight, actualWeight) ||
                other.actualWeight == actualWeight) &&
            (identical(other.completed, completed) ||
                other.completed == completed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    targetSets,
    targetReps,
    targetWeight,
    actualSets,
    actualReps,
    actualWeight,
    completed,
  );

  /// Create a copy of PlannedExercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlannedExerciseImplCopyWith<_$PlannedExerciseImpl> get copyWith =>
      __$$PlannedExerciseImplCopyWithImpl<_$PlannedExerciseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PlannedExerciseImplToJson(this);
  }
}

abstract class _PlannedExercise implements PlannedExercise {
  const factory _PlannedExercise({
    required final String name,
    required final int targetSets,
    required final int targetReps,
    required final double targetWeight,
    final int? actualSets,
    final int? actualReps,
    final double? actualWeight,
    required final bool completed,
  }) = _$PlannedExerciseImpl;

  factory _PlannedExercise.fromJson(Map<String, dynamic> json) =
      _$PlannedExerciseImpl.fromJson;

  @override
  String get name;
  @override
  int get targetSets;
  @override
  int get targetReps;
  @override
  double get targetWeight;
  @override
  int? get actualSets;
  @override
  int? get actualReps;
  @override
  double? get actualWeight;
  @override
  bool get completed;

  /// Create a copy of PlannedExercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlannedExerciseImplCopyWith<_$PlannedExerciseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
