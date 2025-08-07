import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/providers/user_provider.dart';
import '../../../theme/app_colors.dart';
import '../widgets/profile_form.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.background : Colors.grey[50],
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        backgroundColor: isDark ? AppColors.surface : Colors.white,
        foregroundColor: isDark ? AppColors.textPrimary : Colors.black87,
        elevation: 1,
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildAvatarSection(context, user.name, isDark),
                  const SizedBox(height: 24),
                  ProfileForm(user: user),
                ],
              ),
            ),
    );
  }

  Widget _buildAvatarSection(BuildContext context, String name, bool isDark) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: AppColors.primary.withOpacity(0.2),
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : 'U',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDark ? AppColors.background : Colors.white,
                    width: 2,
                  ),
                ),
                child: IconButton(
                  onPressed: () => _showImagePicker(context),
                  icon: const Icon(
                    Icons.camera_alt,
                    color: AppColors.textPrimary,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          name,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.textPrimary : Colors.black87,
          ),
        ),
      ],
    );
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Tomar foto'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Elegir de galería'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}