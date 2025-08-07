import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../widgets/profile_header.dart';
import '../../../widgets/settings_tile.dart';
import '../../theme/app_colors.dart';
import '../../../domain/providers/theme_provider.dart';
import 'components_more/more_header.dart';
import 'components_more/settings_section.dart';
import 'components_more/more_dialogs.dart';

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
            MoreHeader(isDarkMode: isDarkMode),
            const SizedBox(height: 20),
            ProfileHeader(
              name: 'Usuario',
              email: 'usuario@ejemplo.com',
              onEditTap: () => MoreDialogs.showEditProfile(context),
            ),
            const SizedBox(height: 20),
            SettingsSection(
              title: 'Configuración',
              isDarkMode: isDarkMode,
              tiles: [
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
                  onTap: () => MoreDialogs.showNotificationSettings(context),
                ),
                SettingsTile(
                  icon: Icons.language,
                  title: 'Idioma',
                  subtitle: 'Español',
                  onTap: () => MoreDialogs.showLanguageSettings(context),
                ),
                SettingsTile(
                  icon: Icons.backup,
                  title: 'Copia de seguridad',
                  subtitle: 'Sincronizar datos',
                  onTap: () => MoreDialogs.showBackupSettings(context),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SettingsSection(
              title: 'Cuenta',
              isDarkMode: isDarkMode,
              tiles: [
                SettingsTile(
                  icon: Icons.security,
                  title: 'Privacidad y seguridad',
                  onTap: () => MoreDialogs.showPrivacySettings(context),
                ),
                SettingsTile(
                  icon: Icons.help,
                  title: 'Ayuda y soporte',
                  onTap: () => MoreDialogs.showHelpCenter(context),
                ),
                SettingsTile(
                  icon: Icons.info,
                  title: 'Acerca de',
                  subtitle: 'Versión 1.0.0',
                  onTap: () => MoreDialogs.showAbout(context),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SettingsSection(
              title: 'Sesión',
              isDarkMode: isDarkMode,
              tiles: [
                SettingsTile(
                  icon: Icons.logout,
                  title: 'Cerrar sesión',
                  iconColor: AppColors.danger,
                  onTap: () => MoreDialogs.showLogoutDialog(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


}
