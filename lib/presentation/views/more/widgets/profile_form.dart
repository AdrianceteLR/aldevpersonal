import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/models/user/user_model.dart';
import '../../../../domain/providers/user_provider.dart';
import '../../../theme/app_colors.dart';

class ProfileForm extends ConsumerStatefulWidget {
  final UserModel user;

  const ProfileForm({super.key, required this.user});

  @override
  ConsumerState<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends ConsumerState<ProfileForm> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phone ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      color: isDark ? AppColors.surface : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Información Personal',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimary : Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _nameController,
                label: 'Nombre',
                icon: Icons.person,
                validator: (value) => value?.isEmpty == true ? 'Nombre requerido' : null,
                isDark: isDark,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _emailController,
                label: 'Email',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value?.isEmpty == true) return 'Email requerido';
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
                    return 'Email inválido';
                  }
                  return null;
                },
                isDark: isDark,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _phoneController,
                label: 'Teléfono',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                isDark: isDark,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Guardar Cambios',
                    style: TextStyle(color: AppColors.textPrimary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    required bool isDark,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(color: isDark ? AppColors.textPrimary : Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: isDark ? AppColors.textSecondary : Colors.black54),
        prefixIcon: Icon(icon, color: isDark ? AppColors.textSecondary : Colors.black54),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: isDark ? AppColors.textSecondary : Colors.black54),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }

  void _saveProfile() {
    if (_formKey.currentState?.validate() == true) {
      final updatedUser = widget.user.copyWith(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text.isEmpty ? null : _phoneController.text,
      );
      
      ref.read(userProvider.notifier).updateUser(updatedUser);
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Perfil actualizado correctamente'),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}