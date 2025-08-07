import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../../widgets/settings_tile.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  bool _biometricEnabled = false;
  bool _twoFactorEnabled = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.background : Colors.grey[50],
      appBar: AppBar(
        title: const Text('Privacidad y Seguridad'),
        backgroundColor: isDark ? AppColors.surface : Colors.white,
        foregroundColor: isDark ? AppColors.textPrimary : Colors.black87,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSection(
              'Autenticación',
              [
                SettingsTile(
                  icon: Icons.fingerprint,
                  title: 'Autenticación biométrica',
                  subtitle: _biometricEnabled ? 'Activada' : 'Desactivada',
                  trailing: Switch(
                    value: _biometricEnabled,
                    onChanged: (value) => setState(() => _biometricEnabled = value),
                    activeColor: AppColors.primary,
                  ),
                  onTap: () => setState(() => _biometricEnabled = !_biometricEnabled),
                ),
                SettingsTile(
                  icon: Icons.security,
                  title: 'Autenticación de dos factores',
                  subtitle: _twoFactorEnabled ? 'Activada' : 'Desactivada',
                  trailing: Switch(
                    value: _twoFactorEnabled,
                    onChanged: (value) => setState(() => _twoFactorEnabled = value),
                    activeColor: AppColors.primary,
                  ),
                  onTap: () => setState(() => _twoFactorEnabled = !_twoFactorEnabled),
                ),
                SettingsTile(
                  icon: Icons.lock,
                  title: 'Cambiar contraseña',
                  onTap: () => _showChangePasswordDialog(context),
                ),
              ],
              isDark,
            ),
            const SizedBox(height: 16),
            _buildSection(
              'Privacidad',
              [
                SettingsTile(
                  icon: Icons.visibility,
                  title: 'Datos visibles',
                  subtitle: 'Gestionar qué datos son visibles',
                  onTap: () => _showDataVisibilitySettings(context),
                ),
                SettingsTile(
                  icon: Icons.history,
                  title: 'Historial de actividad',
                  onTap: () => _showActivityHistory(context),
                ),
                SettingsTile(
                  icon: Icons.block,
                  title: 'Dispositivos bloqueados',
                  onTap: () => _showBlockedDevices(context),
                ),
              ],
              isDark,
            ),
            const SizedBox(height: 16),
            _buildSection(
              'Sesiones',
              [
                SettingsTile(
                  icon: Icons.devices,
                  title: 'Dispositivos activos',
                  subtitle: '3 dispositivos conectados',
                  onTap: () => _showActiveDevices(context),
                ),
                SettingsTile(
                  icon: Icons.logout,
                  title: 'Cerrar todas las sesiones',
                  iconColor: AppColors.danger,
                  onTap: () => _showLogoutAllDialog(context),
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

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cambiar Contraseña'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Contraseña actual',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Nueva contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Confirmar nueva contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cambiar'),
          ),
        ],
      ),
    );
  }

  void _showDataVisibilitySettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Datos Visibles'),
        content: const Text('Configuración de visibilidad próximamente'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showActivityHistory(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Historial de Actividad'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Inicio de sesión'),
              subtitle: const Text('Hoy, 09:30'),
              leading: const Icon(Icons.login),
            ),
            ListTile(
              title: const Text('Cambio de configuración'),
              subtitle: const Text('Ayer, 15:45'),
              leading: const Icon(Icons.settings),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  void _showBlockedDevices(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Dispositivos Bloqueados'),
        content: const Text('No hay dispositivos bloqueados'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showActiveDevices(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Dispositivos Activos'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('iPhone 14'),
              subtitle: const Text('Último acceso: Ahora'),
              leading: const Icon(Icons.phone_iphone),
              trailing: const Text('Actual', style: TextStyle(color: AppColors.success)),
            ),
            ListTile(
              title: const Text('MacBook Pro'),
              subtitle: const Text('Último acceso: Hace 2 horas'),
              leading: const Icon(Icons.laptop_mac),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  void _showLogoutAllDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar Todas las Sesiones'),
        content: const Text(
          '¿Estás seguro? Esto cerrará la sesión en todos los dispositivos.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cerrar Sesiones',
              style: TextStyle(color: AppColors.danger),
            ),
          ),
        ],
      ),
    );
  }
}