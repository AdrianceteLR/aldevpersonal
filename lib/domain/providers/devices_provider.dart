import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/device/connected_device_model.dart';

final devicesProvider = StateNotifierProvider<DevicesNotifier, List<ConnectedDevice>>((ref) {
  return DevicesNotifier();
});

class DevicesNotifier extends StateNotifier<List<ConnectedDevice>> {
  DevicesNotifier() : super([]);

  void addDevice(ConnectedDevice device) {
    state = [...state, device];
  }

  void removeDevice(String deviceId) {
    state = state.where((device) => device.id != deviceId).toList();
  }

  void updateDeviceStatus(String deviceId, ConnectionStatus status) {
    state = state.map((device) {
      if (device.id == deviceId) {
        return device.copyWith(status: status, lastSync: DateTime.now());
      }
      return device;
    }).toList();
  }

  void toggleDataSync(String deviceId, String dataType, bool enabled) {
    state = state.map((device) {
      if (device.id == deviceId) {
        switch (dataType) {
          case 'health':
            return device.copyWith(healthDataEnabled: enabled);
          case 'workout':
            return device.copyWith(workoutDataEnabled: enabled);
          case 'sleep':
            return device.copyWith(sleepDataEnabled: enabled);
        }
      }
      return device;
    }).toList();
  }

  Future<void> syncDevice(String deviceId) async {
    updateDeviceStatus(deviceId, ConnectionStatus.syncing);
    
    // Simular sincronización
    await Future.delayed(const Duration(seconds: 3));
    
    updateDeviceStatus(deviceId, ConnectionStatus.connected);
  }

  Future<void> scanForDevices() async {
    // Simular búsqueda de dispositivos
    await Future.delayed(const Duration(seconds: 2));
    
    // Agregar dispositivos de ejemplo si no hay ninguno
    if (state.isEmpty) {
      addDevice(const ConnectedDevice(
        id: 'apple_watch_1',
        name: 'Apple Watch Series 9',
        type: DeviceType.appleWatch,
        status: ConnectionStatus.connected,
        model: 'Series 9 45mm',
        batteryLevel: '85%',
        connectedAt: null,
      ));
    }
  }
}