// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connected_device_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ConnectedDevice _$ConnectedDeviceFromJson(Map<String, dynamic> json) {
  return _ConnectedDevice.fromJson(json);
}

/// @nodoc
mixin _$ConnectedDevice {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DeviceType get type => throw _privateConstructorUsedError;
  ConnectionStatus get status => throw _privateConstructorUsedError;
  String? get model => throw _privateConstructorUsedError;
  String? get batteryLevel => throw _privateConstructorUsedError;
  DateTime? get lastSync => throw _privateConstructorUsedError;
  bool get healthDataEnabled => throw _privateConstructorUsedError;
  bool get workoutDataEnabled => throw _privateConstructorUsedError;
  bool get sleepDataEnabled => throw _privateConstructorUsedError;
  DateTime? get connectedAt => throw _privateConstructorUsedError;

  /// Serializes this ConnectedDevice to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConnectedDevice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConnectedDeviceCopyWith<ConnectedDevice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectedDeviceCopyWith<$Res> {
  factory $ConnectedDeviceCopyWith(
    ConnectedDevice value,
    $Res Function(ConnectedDevice) then,
  ) = _$ConnectedDeviceCopyWithImpl<$Res, ConnectedDevice>;
  @useResult
  $Res call({
    String id,
    String name,
    DeviceType type,
    ConnectionStatus status,
    String? model,
    String? batteryLevel,
    DateTime? lastSync,
    bool healthDataEnabled,
    bool workoutDataEnabled,
    bool sleepDataEnabled,
    DateTime? connectedAt,
  });
}

/// @nodoc
class _$ConnectedDeviceCopyWithImpl<$Res, $Val extends ConnectedDevice>
    implements $ConnectedDeviceCopyWith<$Res> {
  _$ConnectedDeviceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectedDevice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? status = null,
    Object? model = freezed,
    Object? batteryLevel = freezed,
    Object? lastSync = freezed,
    Object? healthDataEnabled = null,
    Object? workoutDataEnabled = null,
    Object? sleepDataEnabled = null,
    Object? connectedAt = freezed,
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
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as DeviceType,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ConnectionStatus,
            model: freezed == model
                ? _value.model
                : model // ignore: cast_nullable_to_non_nullable
                      as String?,
            batteryLevel: freezed == batteryLevel
                ? _value.batteryLevel
                : batteryLevel // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastSync: freezed == lastSync
                ? _value.lastSync
                : lastSync // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            healthDataEnabled: null == healthDataEnabled
                ? _value.healthDataEnabled
                : healthDataEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            workoutDataEnabled: null == workoutDataEnabled
                ? _value.workoutDataEnabled
                : workoutDataEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            sleepDataEnabled: null == sleepDataEnabled
                ? _value.sleepDataEnabled
                : sleepDataEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            connectedAt: freezed == connectedAt
                ? _value.connectedAt
                : connectedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConnectedDeviceImplCopyWith<$Res>
    implements $ConnectedDeviceCopyWith<$Res> {
  factory _$$ConnectedDeviceImplCopyWith(
    _$ConnectedDeviceImpl value,
    $Res Function(_$ConnectedDeviceImpl) then,
  ) = __$$ConnectedDeviceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    DeviceType type,
    ConnectionStatus status,
    String? model,
    String? batteryLevel,
    DateTime? lastSync,
    bool healthDataEnabled,
    bool workoutDataEnabled,
    bool sleepDataEnabled,
    DateTime? connectedAt,
  });
}

/// @nodoc
class __$$ConnectedDeviceImplCopyWithImpl<$Res>
    extends _$ConnectedDeviceCopyWithImpl<$Res, _$ConnectedDeviceImpl>
    implements _$$ConnectedDeviceImplCopyWith<$Res> {
  __$$ConnectedDeviceImplCopyWithImpl(
    _$ConnectedDeviceImpl _value,
    $Res Function(_$ConnectedDeviceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectedDevice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? status = null,
    Object? model = freezed,
    Object? batteryLevel = freezed,
    Object? lastSync = freezed,
    Object? healthDataEnabled = null,
    Object? workoutDataEnabled = null,
    Object? sleepDataEnabled = null,
    Object? connectedAt = freezed,
  }) {
    return _then(
      _$ConnectedDeviceImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as DeviceType,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ConnectionStatus,
        model: freezed == model
            ? _value.model
            : model // ignore: cast_nullable_to_non_nullable
                  as String?,
        batteryLevel: freezed == batteryLevel
            ? _value.batteryLevel
            : batteryLevel // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastSync: freezed == lastSync
            ? _value.lastSync
            : lastSync // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        healthDataEnabled: null == healthDataEnabled
            ? _value.healthDataEnabled
            : healthDataEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        workoutDataEnabled: null == workoutDataEnabled
            ? _value.workoutDataEnabled
            : workoutDataEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        sleepDataEnabled: null == sleepDataEnabled
            ? _value.sleepDataEnabled
            : sleepDataEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        connectedAt: freezed == connectedAt
            ? _value.connectedAt
            : connectedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConnectedDeviceImpl implements _ConnectedDevice {
  const _$ConnectedDeviceImpl({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    this.model,
    this.batteryLevel,
    this.lastSync,
    this.healthDataEnabled = true,
    this.workoutDataEnabled = true,
    this.sleepDataEnabled = false,
    this.connectedAt,
  });

  factory _$ConnectedDeviceImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectedDeviceImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final DeviceType type;
  @override
  final ConnectionStatus status;
  @override
  final String? model;
  @override
  final String? batteryLevel;
  @override
  final DateTime? lastSync;
  @override
  @JsonKey()
  final bool healthDataEnabled;
  @override
  @JsonKey()
  final bool workoutDataEnabled;
  @override
  @JsonKey()
  final bool sleepDataEnabled;
  @override
  final DateTime? connectedAt;

  @override
  String toString() {
    return 'ConnectedDevice(id: $id, name: $name, type: $type, status: $status, model: $model, batteryLevel: $batteryLevel, lastSync: $lastSync, healthDataEnabled: $healthDataEnabled, workoutDataEnabled: $workoutDataEnabled, sleepDataEnabled: $sleepDataEnabled, connectedAt: $connectedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectedDeviceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.batteryLevel, batteryLevel) ||
                other.batteryLevel == batteryLevel) &&
            (identical(other.lastSync, lastSync) ||
                other.lastSync == lastSync) &&
            (identical(other.healthDataEnabled, healthDataEnabled) ||
                other.healthDataEnabled == healthDataEnabled) &&
            (identical(other.workoutDataEnabled, workoutDataEnabled) ||
                other.workoutDataEnabled == workoutDataEnabled) &&
            (identical(other.sleepDataEnabled, sleepDataEnabled) ||
                other.sleepDataEnabled == sleepDataEnabled) &&
            (identical(other.connectedAt, connectedAt) ||
                other.connectedAt == connectedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    type,
    status,
    model,
    batteryLevel,
    lastSync,
    healthDataEnabled,
    workoutDataEnabled,
    sleepDataEnabled,
    connectedAt,
  );

  /// Create a copy of ConnectedDevice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectedDeviceImplCopyWith<_$ConnectedDeviceImpl> get copyWith =>
      __$$ConnectedDeviceImplCopyWithImpl<_$ConnectedDeviceImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectedDeviceImplToJson(this);
  }
}

abstract class _ConnectedDevice implements ConnectedDevice {
  const factory _ConnectedDevice({
    required final String id,
    required final String name,
    required final DeviceType type,
    required final ConnectionStatus status,
    final String? model,
    final String? batteryLevel,
    final DateTime? lastSync,
    final bool healthDataEnabled,
    final bool workoutDataEnabled,
    final bool sleepDataEnabled,
    final DateTime? connectedAt,
  }) = _$ConnectedDeviceImpl;

  factory _ConnectedDevice.fromJson(Map<String, dynamic> json) =
      _$ConnectedDeviceImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  DeviceType get type;
  @override
  ConnectionStatus get status;
  @override
  String? get model;
  @override
  String? get batteryLevel;
  @override
  DateTime? get lastSync;
  @override
  bool get healthDataEnabled;
  @override
  bool get workoutDataEnabled;
  @override
  bool get sleepDataEnabled;
  @override
  DateTime? get connectedAt;

  /// Create a copy of ConnectedDevice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectedDeviceImplCopyWith<_$ConnectedDeviceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
