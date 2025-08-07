import 'package:freezed_annotation/freezed_annotation.dart';

part 'connected_device_model.freezed.dart';
part 'connected_device_model.g.dart';

enum DeviceType { appleWatch, wearOS, fitbit, garmin, samsung, other }

enum ConnectionStatus { connected, disconnected, syncing, error }

@freezed
class ConnectedDevice with _$ConnectedDevice {
  const factory ConnectedDevice({
    required String id,
    required String name,
    required DeviceType type,
    required ConnectionStatus status,
    String? model,
    String? batteryLevel,
    DateTime? lastSync,
    @Default(true) bool healthDataEnabled,
    @Default(true) bool workoutDataEnabled,
    @Default(false) bool sleepDataEnabled,
    DateTime? connectedAt,
  }) = _ConnectedDevice;

  factory ConnectedDevice.fromJson(Map<String, dynamic> json) => _$ConnectedDeviceFromJson(json);
}