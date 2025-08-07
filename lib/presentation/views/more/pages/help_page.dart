import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.background : Colors.grey[50],
      appBar: AppBar(
        title: const Text('Ayuda y Soporte'),
        backgroundColor: isDark ? AppColors.surface : Colors.white,
        foregroundColor: isDark ? AppColors.textPrimary : Colors.black87,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSection(
              'Preguntas Frecuentes',
              [
                _buildFAQItem(
                  '¿Cómo agregar un nuevo gasto?',
                  'Ve a la sección Finanzas y toca el botón "+" para agregar un nuevo movimiento.',
                  isDark,
                ),
                _buildFAQItem(
                  '¿Cómo crear una rutina de entrenamiento?',
                  'En la sección Entrenamiento, toca "Nuevo" y selecciona "Personalizado" o "Plantilla".',
                  isDark,
                ),
                _buildFAQItem(
                  '¿Cómo cambiar el tema de la app?',
                  'Ve a Más > Configuración > Tema y activa/desactiva el modo oscuro.',
                  isDark,
                ),
              ],
              isDark,
            ),
            const SizedBox(height: 16),
            _buildSection(
              'Contacto',
              [
                ListTile(
                  leading: const Icon(Icons.email, color: AppColors.primary),
                  title: Text(
                    'Email de soporte',
                    style: TextStyle(color: isDark ? AppColors.textPrimary : Colors.black87),
                  ),
                  subtitle: const Text('soporte@tuapp.com'),
                  onTap: () => _launchEmail(),
                ),
                ListTile(
                  leading: const Icon(Icons.chat, color: AppColors.primary),
                  title: Text(
                    'Chat en vivo',
                    style: TextStyle(color: isDark ? AppColors.textPrimary : Colors.black87),
                  ),
                  subtitle: const Text('Disponible 9:00 - 18:00'),
                  onTap: () => _openLiveChat(context),
                ),
                ListTile(
                  leading: const Icon(Icons.phone, color: AppColors.primary),
                  title: Text(
                    'Teléfono',
                    style: TextStyle(color: isDark ? AppColors.textPrimary : Colors.black87),
                  ),
                  subtitle: const Text('+34 900 123 456'),
                  onTap: () => _makePhoneCall(),
                ),
              ],
              isDark,
            ),
            const SizedBox(height: 16),
            _buildSection(
              'Recursos',
              [
                ListTile(
                  leading: const Icon(Icons.book, color: AppColors.primary),
                  title: Text(
                    'Guía de usuario',
                    style: TextStyle(color: isDark ? AppColors.textPrimary : Colors.black87),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => _openUserGuide(context),
                ),
                ListTile(
                  leading: const Icon(Icons.video_library, color: AppColors.primary),
                  title: Text(
                    'Tutoriales en video',
                    style: TextStyle(color: isDark ? AppColors.textPrimary : Colors.black87),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => _openVideoTutorials(),
                ),
                ListTile(
                  leading: const Icon(Icons.bug_report, color: AppColors.primary),
                  title: Text(
                    'Reportar un problema',
                    style: TextStyle(color: isDark ? AppColors.textPrimary : Colors.black87),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => _reportBug(context),
                ),
              ],
              isDark,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children, bool isDark) {
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
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer, bool isDark) {
    return ExpansionTile(
      title: Text(
        question,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: isDark ? AppColors.textPrimary : Colors.black87,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            answer,
            style: TextStyle(
              color: isDark ? AppColors.textSecondary : Colors.black54,
            ),
          ),
        ),
      ],
    );
  }

  void _launchEmail() {
    // Implementar launch email
  }

  void _openLiveChat(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Chat en Vivo'),
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

  void _makePhoneCall() {
    // Implementar phone call
  }

  void _openUserGuide(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserGuidePage()),
    );
  }

  void _openVideoTutorials() {
    // Implementar abrir videos
  }

  void _reportBug(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reportar Problema'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Describe el problema',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
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
            child: const Text('Enviar'),
          ),
        ],
      ),
    );
  }
}

class UserGuidePage extends StatelessWidget {
  const UserGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Guía de Usuario'),
        backgroundColor: isDark ? AppColors.surface : Colors.white,
        foregroundColor: isDark ? AppColors.textPrimary : Colors.black87,
      ),
      body: const Center(
        child: Text('Guía de usuario próximamente'),
      ),
    );
  }
}