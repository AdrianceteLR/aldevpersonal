import 'package:aldevpersonal/presentation/views/more/components_more/more_dialogs.dart';
import 'package:aldevpersonal/presentation/views/more/components_more/more_header.dart';
import 'package:aldevpersonal/presentation/views/more/components_more/settings_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../widgets/profile_header.dart';
import '../../../widgets/settings_tile.dart';
import '../../theme/app_colors.dart';
import '../../../domain/providers/theme_provider.dart';
import '../../../domain/providers/user_provider.dart';
import 'pages/profile_page.dart';
import 'pages/settings_page.dart';
import 'pages/help_page.dart';
import 'pages/security_page.dart';
import 'widgets/user_stats_card.dart';

class MoreView extends ConsumerWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);
    final user = ref.watch(userProvider);
    
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
              name: user?.name ?? 'Usuario',
              email: user?.email ?? 'usuario@ejemplo.com',
              onEditTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              ),
            ),
            const SizedBox(height: 20),
            const UserStatsCard(),
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
                  icon: Icons.settings,
                  title: 'Configuración avanzada',
                  subtitle: 'Notificaciones, idioma, backup',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsPage()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SettingsSection(
              title: 'Seguridad',
              isDarkMode: isDarkMode,
              tiles: [
                SettingsTile(
                  icon: Icons.security,
                  title: 'Privacidad y seguridad',
                  subtitle: 'Contraseña, biometría, sesiones',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SecurityPage()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SettingsSection(
              title: 'Soporte',
              isDarkMode: isDarkMode,
              tiles: [
                SettingsTile(
                  icon: Icons.help,
                  title: 'Ayuda y soporte',
                  subtitle: 'FAQ, contacto, guías',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HelpPage()),
                  ),
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
              title: 'Cuenta',
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
