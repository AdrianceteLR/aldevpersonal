import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/models/device/connected_device_model.dart';
import '../../../../domain/providers/devices_provider.dart';
import '../../../theme/app_colors.dart';

class DevicesPage extends ConsumerStatefulWidget {
  const DevicesPage({super.key});

  @override
  ConsumerState<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends ConsumerState<DevicesPage> {
  bool _isScanning = false;

  @override
  Widget build(BuildContext context) {
    final devices = ref.watch(devicesProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.background : Colors.grey[50],
      appBar: AppBar(
        title: const Text('Dispositivos Conectados'),
        backgroundColor: isDark ? AppColors.surface : Colors.white,
        foregroundColor: isDark ? AppColors.textPrimary : Colors.black87,
        elevation: 1,
        actions: [
          IconButton(
            onPressed: _isScanning ? null : _scanForDevices,
            icon: _isScanning 
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(isDark),
            const SizedBox(height: 16),
            if (devices.isEmpty) 
              _buildEmptyState(isDark)
            else
              ...devices.map((device) => _buildDeviceCard(device, isDark)),
            const SizedBox(height: 16),
            _buildAddDeviceButton(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(bool isDark) {
    return Card(
      color: isDark ? AppColors.surface : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  'Sincronización de Datos',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.textPrimary : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Conecta tu smartwatch para sincronizar automáticamente datos de salud, entrenamientos y sueño.',
              style: TextStyle(
                color: isDark ? AppColors.textSecondary : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Card(
      color: isDark ? AppColors.surface : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(
              Icons.watch,
              size: 64,
              color: isDark ? AppColors.textSecondary : Colors.black54,
            ),
            const SizedBox(height: 16),
            Text(
              'No hay dispositivos conectados',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textPrimary : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Conecta tu smartwatch para comenzar a sincronizar datos',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDark ? AppColors.textSecondary : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceCard(ConnectedDevice device, bool isDark) {
    return Card(
      color: isDark ? AppColors.surface : Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _getDeviceIcon(device.type),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        device.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.textPrimary : Colors.black87,
                        ),
                      ),
                      if (device.model != null)
                        Text(
                          device.model!,
                          style: TextStyle(
                            color: isDark ? AppColors.textSecondary : Colors.black54,
                          ),
                        ),
                    ],
                  ),
                ),
                _buildStatusChip(device.status),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                if (device.batteryLevel != null) ...[
                  Icon(Icons.battery_std, size: 16, color: AppColors.success),
                  const SizedBox(width: 4),
                  Text(device.batteryLevel!, style: TextStyle(fontSize: 12)),
                  const SizedBox(width: 16),
                ],
                Icon(Icons.sync, size: 16, color: AppColors.primary),
                const SizedBox(width: 4),
                Text(
                  device.lastSync != null 
                      ? 'Última sync: ${_formatTime(device.lastSync!)}'
                      : 'Nunca sincronizado',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showDeviceSettings(device),
                    icon: const Icon(Icons.settings, size: 16),
                    label: const Text('Configurar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: device.status == ConnectionStatus.syncing 
                      ? null 
                      : () => ref.read(devicesProvider.notifier).syncDevice(device.id),
                  icon: device.status == ConnectionStatus.syncing
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.sync, size: 16),
                  label: const Text('Sync'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getDeviceIcon(DeviceType type) {
    IconData icon;
    Color color;
    
    switch (type) {
      case DeviceType.appleWatch:
        icon = Icons.watch;
        color = AppColors.primary;
        break;
      case DeviceType.wearOS:
        icon = Icons.watch;
        color = AppColors.success;
        break;
      case DeviceType.fitbit:
        icon = Icons.fitness_center;
        color = AppColors.accent;
        break;
      case DeviceType.garmin:
        icon = Icons.gps_fixed;
        color = AppColors.danger;
        break;
      default:
        icon = Icons.watch;
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }

  Widget _buildStatusChip(ConnectionStatus status) {
    Color color;
    String text;
    
    switch (status) {
      case ConnectionStatus.connected:
        color = AppColors.success;
        text = 'Conectado';
        break;
      case ConnectionStatus.syncing:
        color = AppColors.accent;
        text = 'Sincronizando';
        break;
      case ConnectionStatus.error:
        color = AppColors.danger;
        text = 'Error';
        break;
      default:
        color = Colors.grey;
        text = 'Desconectado';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildAddDeviceButton(bool isDark) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: _showAddDeviceDialog,
        icon: const Icon(Icons.add),
        label: const Text('Agregar Dispositivo'),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: BorderSide(color: AppColors.primary),
          foregroundColor: AppColors.primary,
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);
    
    if (diff.inMinutes < 60) {
      return 'Hace ${diff.inMinutes}min';
    } else if (diff.inHours < 24) {
      return 'Hace ${diff.inHours}h';
    } else {
      return 'Hace ${diff.inDays}d';
    }
  }

  Future<void> _scanForDevices() async {
    setState(() => _isScanning = true);
    await ref.read(devicesProvider.notifier).scanForDevices();
    setState(() => _isScanning = false);
  }

  void _showAddDeviceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Agregar Dispositivo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.watch),
              title: const Text('Apple Watch'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.watch),
              title: const Text('Wear OS'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.fitness_center),
              title: const Text('Fitbit'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeviceSettings(ConnectedDevice device) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Configuración de ${device.name}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Datos de salud'),
              value: device.healthDataEnabled,
              onChanged: (value) => ref.read(devicesProvider.notifier)
                  .toggleDataSync(device.id, 'health', value),
            ),
            SwitchListTile(
              title: const Text('Datos de entrenamiento'),
              value: device.workoutDataEnabled,
              onChanged: (value) => ref.read(devicesProvider.notifier)
                  .toggleDataSync(device.id, 'workout', value),
            ),
            SwitchListTile(
              title: const Text('Datos de sueño'),
              value: device.sleepDataEnabled,
              onChanged: (value) => ref.read(devicesProvider.notifier)
                  .toggleDataSync(device.id, 'sleep', value),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(devicesProvider.notifier).removeDevice(device.id);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.danger),
              child: const Text('Desconectar Dispositivo'),
            ),
          ],
        ),
      ),
    );
  }
}