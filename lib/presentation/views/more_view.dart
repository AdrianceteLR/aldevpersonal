import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/profile_header.dart';
import '../../widgets/settings_tile.dart';
import '../theme/app_colors.dart';
import '../../domain/providers/theme_provider.dart';

class MoreView extends ConsumerWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);
    
    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.background : Colors.grey[50],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(isDarkMode),
            const SizedBox(height: 20),
            ProfileHeader(
              name: 'Usuario',
              email: 'usuario@ejemplo.com',
              onEditTap: () => _showEditProfile(context),
            ),
            const SizedBox(height: 20),
            _buildSettingsSection('Configuración', [
              SettingsTile(
                icon: isDarkMode ? Icons.light_mode : Icons.dark_mode,
                title: 'Tema',
                subtitle: isDarkMode ? 'Modo oscuro' : 'Modo claro',
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (value) => ref.read(themeProvider.notifier).toggleTheme(),
                  activeColor: AppColors.primary,
                ),
                onTap: () => ref.read(themeProvider.notifier).toggleTheme(),
              ),
              SettingsTile(
                icon: Icons.notifications,
                title: 'Notificaciones',
                subtitle: 'Gestionar alertas',
                onTap: () => _showNotificationSettings(context),
              ),
              SettingsTile(
                icon: Icons.language,
                title: 'Idioma',
                subtitle: 'Español',
                onTap: () => _showLanguageSettings(context),
              ),
              SettingsTile(
                icon: Icons.backup,
                title: 'Copia de seguridad',
                subtitle: 'Sincronizar datos',
                onTap: () => _showBackupSettings(context),
              ),
            ], isDarkMode),
            const SizedBox(height: 20),
            _buildSettingsSection('Cuenta', [
              SettingsTile(
                icon: Icons.security,
                title: 'Privacidad y seguridad',
                onTap: () => _showPrivacySettings(context),
              ),
              SettingsTile(
                icon: Icons.help,
                title: 'Ayuda y soporte',
                onTap: () => _showHelpCenter(context),
              ),
              SettingsTile(
                icon: Icons.info,
                title: 'Acerca de',
                subtitle: 'Versión 1.0.0',
                onTap: () => _showAbout(context),
              ),
            ], isDarkMode),
            const SizedBox(height: 20),
            _buildSettingsSection('Sesión', [
              SettingsTile(
                icon: Icons.logout,
                title: 'Cerrar sesión',
                iconColor: AppColors.danger,
                onTap: () => _showLogoutDialog(context),
              ),
            ], isDarkMode),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Más',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? AppColors.textPrimary : Colors.black87,
          ),
        ),
        Text(
          'Configuración y perfil',
          style: TextStyle(
            fontSize: 16,
            color: isDarkMode ? AppColors.textSecondary : Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsSection(String title, List<SettingsTile> tiles, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? AppColors.textPrimary : Colors.black87,
            ),
          ),
        ),
        ...tiles,
      ],
    );
  }

  void _showEditProfile(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Perfil'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'Email'),
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
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  void _showNotificationSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notificaciones'),
        content: const Text('Configuración de notificaciones próximamente.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showLanguageSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Idioma'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Español'),
              leading: Radio(value: 'es', groupValue: 'es', onChanged: (value) {}),
            ),
            ListTile(
              title: const Text('English'),
              leading: Radio(value: 'en', groupValue: 'es', onChanged: (value) {}),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showBackupSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Copia de seguridad'),
        content: const Text('Funcionalidad de backup próximamente.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showPrivacySettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacidad y seguridad'),
        content: const Text('Configuración de privacidad próximamente.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showHelpCenter(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ayuda y soporte'),
        content: const Text('Centro de ayuda próximamente.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showAbout(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Tu App Personal',
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2024 Tu App Personal',
      children: [
        const Text('Una aplicación para gestionar tus finanzas y entrenamientos.'),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Estás seguro de que quieres cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Aquí iría la lógica de logout
            },
            child: Text('Cerrar sesión', style: TextStyle(color: AppColors.danger)),
          ),
        ],
      ),
    );
  }
}
