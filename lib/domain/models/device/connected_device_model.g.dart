// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connected_device_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConnectedDeviceImpl _$$ConnectedDeviceImplFromJson(
  Map<String, dynamic> json,
) => _$ConnectedDeviceImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  type: $enumDecode(_$DeviceTypeEnumMap, json['type']),
  status: $enumDecode(_$ConnectionStatusEnumMap, json['status']),
  model: json['model'] as String?,
  batteryLevel: json['batteryLevel'] as String?,
  lastSync: json['lastSync'] == null
      ? null
      : DateTime.parse(json['lastSync'] as String),
  healthDataEnabled: json['healthDataEnabled'] as bool? ?? true,
  workoutDataEnabled: json['workoutDataEnabled'] as bool? ?? true,
  sleepDataEnabled: json['sleepDataEnabled'] as bool? ?? false,
  connectedAt: json['connectedAt'] == null
      ? null
      : DateTime.parse(json['connectedAt'] as String),
);

Map<String, dynamic> _$$ConnectedDeviceImplToJson(
  _$ConnectedDeviceImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'type': _$DeviceTypeEnumMap[instance.type]!,
  'status': _$ConnectionStatusEnumMap[instance.status]!,
  'model': instance.model,
  'batteryLevel': instance.batteryLevel,
  'lastSync': instance.lastSync?.toIso8601String(),
  'healthDataEnabled': instance.healthDataEnabled,
  'workoutDataEnabled': instance.workoutDataEnabled,
  'sleepDataEnabled': instance.sleepDataEnabled,
  'connectedAt': instance.connectedAt?.toIso8601String(),
};

const _$DeviceTypeEnumMap = {
  DeviceType.appleWatch: 'appleWatch',
  DeviceType.wearOS: 'wearOS',
  DeviceType.fitbit: 'fitbit',
  DeviceType.garmin: 'garmin',
  DeviceType.samsung: 'samsung',
  DeviceType.other: 'other',
};

const _$ConnectionStatusEnumMap = {
  ConnectionStatus.connected: 'connected',
  ConnectionStatus.disconnected: 'disconnected',
  ConnectionStatus.syncing: 'syncing',
  ConnectionStatus.error: 'error',
};
