import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/providers/theme_provider.dart';
import '../../../../domain/providers/user_provider.dart';
import '../../../../domain/providers/devices_provider.dart';
import '../../../theme/app_colors.dart';
import '../../../../widgets/settings_tile.dart';
import 'devices_page.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider);
    final user = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: isDark ? AppColors.background : Colors.grey[50],
      appBar: AppBar(
        title: const Text('Configuración'),
        backgroundColor: isDark ? AppColors.surface : Colors.white,
        foregroundColor: isDark ? AppColors.textPrimary : Colors.black87,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSection(
              'Apariencia',
              [
                SettingsTile(
                  icon: isDark ? Icons.light_mode : Icons.dark_mode,
                  title: 'Tema',
                  subtitle: isDark ? 'Modo oscuro' : 'Modo claro',
                  trailing: Switch(
                    value: isDark,
                    onChanged: (value) => ref.read(themeProvider.notifier).toggleTheme(),
                    activeColor: AppColors.primary,
                  ),
                  onTap: () => ref.read(themeProvider.notifier).toggleTheme(),
                ),
              ],
              isDark,
            ),
            const SizedBox(height: 16),
            _buildSection(
              'Notificaciones',
              [
                SettingsTile(
                  icon: Icons.notifications,
                  title: 'Notificaciones push',
                  subtitle: user?.notificationsEnabled == true ? 'Activadas' : 'Desactivadas',
                  trailing: Switch(
                    value: user?.notificationsEnabled ?? false,
                    onChanged: (value) => ref.read(userProvider.notifier).toggleNotifications(),
                    activeColor: AppColors.primary,
                  ),
                  onTap: () => ref.read(userProvider.notifier).toggleNotifications(),
                ),
                SettingsTile(
                  icon: Icons.schedule,
                  title: 'Horario de notificaciones',
                  subtitle: '8:00 AM - 10:00 PM',
                  onTap: () => _showTimeRangePicker(context),
                ),
              ],
              isDark,
            ),
            const SizedBox(height: 16),
            _buildSection(
              'Idioma y Región',
              [
                SettingsTile(
                  icon: Icons.language,
                  title: 'Idioma',
                  subtitle: _getLanguageName(user?.language ?? 'es'),
                  onTap: () => _showLanguageSelector(context, ref),
                ),
                SettingsTile(
                  icon: Icons.location_on,
                  title: 'Región',
                  subtitle: 'España',
                  onTap: () {},
                ),
              ],
              isDark,
            ),
            const SizedBox(height: 16),
            _buildSection(
              'Dispositivos',
              [
                SettingsTile(
                  icon: Icons.watch,
                  title: 'Dispositivos conectados',
                  subtitle: _getDevicesSubtitle(ref),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DevicesPage()),
                  ),
                ),
              ],
              isDark,
            ),
            const SizedBox(height: 16),
            _buildSection(
              'Datos y Privacidad',
              [
                SettingsTile(
                  icon: Icons.backup,
                  title: 'Copia de seguridad',
                  subtitle: 'Última: Hace 2 días',
                  onTap: () => _showBackupOptions(context),
                ),
                SettingsTile(
                  icon: Icons.download,
                  title: 'Exportar datos',
                  onTap: () => _showExportOptions(context),
                ),
                SettingsTile(
                  icon: Icons.delete_forever,
                  title: 'Eliminar todos los datos',
                  iconColor: AppColors.danger,
                  onTap: () => _showDeleteDataDialog(context),
                ),
              ],
              isDark,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<SettingsTile> tiles, bool isDark) {
    return Card(
      color: isDark ? AppColors.surface : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textPrimary : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            ...tiles,
          ],
        ),
      ),
    );
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'es': return 'Español';
      case 'en': return 'English';
      case 'fr': return 'Français';
      default: return 'Español';
    }
  }

  String _getDevicesSubtitle(WidgetRef ref) {
    final devices = ref.watch(devicesProvider);
    final connectedCount = devices.where((d) => d.status.name == 'connected').length;
    
    if (devices.isEmpty) {
      return 'Ningún dispositivo conectado';
    } else {
      return '$connectedCount de ${devices.length} conectados';
    }
  }

  void _showLanguageSelector(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Seleccionar Idioma'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption('es', 'Español', context, ref),
            _buildLanguageOption('en', 'English', context, ref),
            _buildLanguageOption('fr', 'Français', context, ref),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String code, String name, BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return ListTile(
      title: Text(name),
      leading: Radio<String>(
        value: code,
        groupValue: user?.language ?? 'es',
        onChanged: (value) {
          if (value != null) {
            ref.read(userProvider.notifier).updateLanguage(value);
            Navigator.pop(context);
          }
        },
      ),
      onTap: () {
        ref.read(userProvider.notifier).updateLanguage(code);
        Navigator.pop(context);
      },
    );
  }

  void _showTimeRangePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Horario de Notificaciones'),
        content: const Text('Funcionalidad próximamente disponible'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showBackupOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Copia de Seguridad'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.cloud_upload),
              title: const Text('Crear copia ahora'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('Programar copias automáticas'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showExportOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exportar Datos'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.file_download),
              title: const Text('Exportar como JSON'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.table_chart),
              title: const Text('Exportar como CSV'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Todos los Datos'),
        content: const Text(
          '¿Estás seguro? Esta acción no se puede deshacer y eliminará permanentemente todos tus datos.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Eliminar',
              style: TextStyle(color: AppColors.danger),
            ),
          ),
        ],
      ),
    );
  }
}