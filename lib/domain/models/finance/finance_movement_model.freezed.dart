// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'finance_movement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FinanceMovement _$FinanceMovementFromJson(Map<String, dynamic> json) {
  return _FinanceMovement.fromJson(json);
}

/// @nodoc
mixin _$FinanceMovement {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  MovementType get type => throw _privateConstructorUsedError;
  MovementCategory get category => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this FinanceMovement to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FinanceMovement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FinanceMovementCopyWith<FinanceMovement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FinanceMovementCopyWith<$Res> {
  factory $FinanceMovementCopyWith(
    FinanceMovement value,
    $Res Function(FinanceMovement) then,
  ) = _$FinanceMovementCopyWithImpl<$Res, FinanceMovement>;
  @useResult
  $Res call({
    String id,
    String userId,
    String title,
    double amount,
    MovementType type,
    MovementCategory category,
    String? description,
    DateTime date,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$FinanceMovementCopyWithImpl<$Res, $Val extends FinanceMovement>
    implements $FinanceMovementCopyWith<$Res> {
  _$FinanceMovementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FinanceMovement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? amount = null,
    Object? type = null,
    Object? category = null,
    Object? description = freezed,
    Object? date = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as MovementType,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as MovementCategory,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FinanceMovementImplCopyWith<$Res>
    implements $FinanceMovementCopyWith<$Res> {
  factory _$$FinanceMovementImplCopyWith(
    _$FinanceMovementImpl value,
    $Res Function(_$FinanceMovementImpl) then,
  ) = __$$FinanceMovementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String title,
    double amount,
    MovementType type,
    MovementCategory category,
    String? description,
    DateTime date,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$FinanceMovementImplCopyWithImpl<$Res>
    extends _$FinanceMovementCopyWithImpl<$Res, _$FinanceMovementImpl>
    implements _$$FinanceMovementImplCopyWith<$Res> {
  __$$FinanceMovementImplCopyWithImpl(
    _$FinanceMovementImpl _value,
    $Res Function(_$FinanceMovementImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FinanceMovement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? amount = null,
    Object? type = null,
    Object? category = null,
    Object? description = freezed,
    Object? date = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$FinanceMovementImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as MovementType,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as MovementCategory,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FinanceMovementImpl implements _FinanceMovement {
  const _$FinanceMovementImpl({
    required this.id,
    required this.userId,
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    this.description,
    required this.date,
    this.createdAt,
    this.updatedAt,
  });

  factory _$FinanceMovementImpl.fromJson(Map<String, dynamic> json) =>
      _$$FinanceMovementImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String title;
  @override
  final double amount;
  @override
  final MovementType type;
  @override
  final MovementCategory category;
  @override
  final String? description;
  @override
  final DateTime date;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'FinanceMovement(id: $id, userId: $userId, title: $title, amount: $amount, type: $type, category: $category, description: $description, date: $date, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FinanceMovementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    title,
    amount,
    type,
    category,
    description,
    date,
    createdAt,
    updatedAt,
  );

  /// Create a copy of FinanceMovement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FinanceMovementImplCopyWith<_$FinanceMovementImpl> get copyWith =>
      __$$FinanceMovementImplCopyWithImpl<_$FinanceMovementImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FinanceMovementImplToJson(this);
  }
}

abstract class _FinanceMovement implements FinanceMovement {
  const factory _FinanceMovement({
    required final String id,
    required final String userId,
    required final String title,
    required final double amount,
    required final MovementType type,
    required final MovementCategory category,
    final String? description,
    required final DateTime date,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$FinanceMovementImpl;

  factory _FinanceMovement.fromJson(Map<String, dynamic> json) =
      _$FinanceMovementImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get title;
  @override
  double get amount;
  @override
  MovementType get type;
  @override
  MovementCategory get category;
  @override
  String? get description;
  @override
  DateTime get date;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of FinanceMovement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FinanceMovementImplCopyWith<_$FinanceMovementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
