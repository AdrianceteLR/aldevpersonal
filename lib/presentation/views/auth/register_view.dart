import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/providers/auth_provider.dart';
import '../../theme/app_colors.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.background : Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: isDark ? AppColors.textPrimary : Colors.black87,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(isDark),
              const SizedBox(height: 32),
              _buildRegisterForm(isDark),
              const SizedBox(height: 24),
              _buildRegisterButton(authState),
              const SizedBox(height: 16),
              _buildDivider(isDark),
              const SizedBox(height: 16),
              _buildGoogleButton(authState),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Column(
      children: [
        Text(
          'Crear Cuenta',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.textPrimary : Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Regístrate para comenzar',
          style: TextStyle(
            fontSize: 16,
            color: isDark ? AppColors.textSecondary : Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterForm(bool isDark) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            style: TextStyle(color: isDark ? AppColors.textPrimary : Colors.black87),
            decoration: InputDecoration(
              labelText: 'Nombre completo',
              prefixIcon: const Icon(Icons.person_outlined),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: isDark ? AppColors.surface : Colors.white,
            ),
            validator: (value) {
              if (value?.isEmpty == true) return 'Nombre requerido';
              if (value!.length < 2) return 'Mínimo 2 caracteres';
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: isDark ? AppColors.textPrimary : Colors.black87),
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: const Icon(Icons.email_outlined),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: isDark ? AppColors.surface : Colors.white,
            ),
            validator: (value) {
              if (value?.isEmpty == true) return 'Email requerido';
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
                return 'Email inválido';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            style: TextStyle(color: isDark ? AppColors.textPrimary : Colors.black87),
            decoration: InputDecoration(
              labelText: 'Contraseña',
              prefixIcon: const Icon(Icons.lock_outlined),
              suffixIcon: IconButton(
                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
              ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: isDark ? AppColors.surface : Colors.white,
            ),
            validator: (value) {
              if (value?.isEmpty == true) return 'Contraseña requerida';
              if (value!.length < 6) return 'Mínimo 6 caracteres';
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: _obscureConfirmPassword,
            style: TextStyle(color: isDark ? AppColors.textPrimary : Colors.black87),
            decoration: InputDecoration(
              labelText: 'Confirmar contraseña',
              prefixIcon: const Icon(Icons.lock_outlined),
              suffixIcon: IconButton(
                onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                icon: Icon(_obscureConfirmPassword ? Icons.visibility : Icons.visibility_off),
              ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: isDark ? AppColors.surface : Colors.white,
            ),
            validator: (value) {
              if (value?.isEmpty == true) return 'Confirma tu contraseña';
              if (value != _passwordController.text) return 'Las contraseñas no coinciden';
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton(AsyncValue<void> authState) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: authState.isLoading ? null : _handleRegister,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: authState.isLoading
            ? const CircularProgressIndicator(color: AppColors.textPrimary)
            : const Text(
                'Crear Cuenta',
                style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
              ),
      ),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Row(
      children: [
        Expanded(child: Divider(color: isDark ? AppColors.textSecondary : Colors.black26)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'O',
            style: TextStyle(color: isDark ? AppColors.textSecondary : Colors.black54),
          ),
        ),
        Expanded(child: Divider(color: isDark ? AppColors.textSecondary : Colors.black26)),
      ],
    );
  }

  Widget _buildGoogleButton(AsyncValue<void> authState) {
    return SizedBox(
      height: 50,
      child: OutlinedButton.icon(
        onPressed: authState.isLoading ? null : _handleGoogleSignIn,
        icon: const Icon(Icons.g_mobiledata, size: 24),
        label: const Text('Continuar con Google'),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          side: const BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }

  void _handleRegister() async {
    if (_formKey.currentState?.validate() == true) {
      final notifier = ref.read(authNotifierProvider.notifier);
      await notifier.signUpWithEmail(
        _emailController.text.trim(),
        _passwordController.text,
        _nameController.text.trim(),
      );
      
      if (mounted) {
        final authState = ref.read(authNotifierProvider);
        if (authState.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(authState.error.toString()),
              backgroundColor: AppColors.danger,
            ),
          );
        }
      }
    }
  }

  void _handleGoogleSignIn() async {
    final notifier = ref.read(authNotifierProvider.notifier);
    await notifier.signInWithGoogle();
    
    if (mounted) {
      final authState = ref.read(authNotifierProvider);
      if (authState.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authState.error.toString()),
            backgroundColor: AppColors.danger,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}