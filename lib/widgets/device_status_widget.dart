import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/device/connected_device_model.dart';
import '../domain/providers/devices_provider.dart';
import '../presentation/theme/app_colors.dart';

class DeviceStatusWidget extends ConsumerWidget {
  const DeviceStatusWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devices = ref.watch(devicesProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    if (devices.isEmpty) return const SizedBox.shrink();

    final connectedDevices = devices.where((d) => d.status == ConnectionStatus.connected).toList();
    
    return Card(
      color: isDark ? AppColors.surface : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.watch,
                color: AppColors.success,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    connectedDevices.isEmpty 
                        ? 'Sin dispositivos' 
                        : '${connectedDevices.length} dispositivo(s)',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: isDark ? AppColors.textPrimary : Colors.black87,
                    ),
                  ),
                  Text(
                    connectedDevices.isEmpty 
                        ? 'Conecta tu smartwatch' 
                        : 'Sincronizando datos',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppColors.textSecondary : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            if (connectedDevices.isNotEmpty)
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}