import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/providers/auth_provider.dart';
import '../../theme/app_colors.dart';
import 'register_view.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.background : Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 60),
              _buildHeader(isDark),
              const SizedBox(height: 40),
              _buildLoginForm(isDark),
              const SizedBox(height: 24),
              _buildLoginButton(authState),
              const SizedBox(height: 16),
              _buildDivider(isDark),
              const SizedBox(height: 16),
              _buildGoogleButton(authState),
              const SizedBox(height: 24),
              _buildForgotPassword(isDark),
              const SizedBox(height: 16),
              _buildRegisterLink(isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.person,
            size: 60,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Bienvenido',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.textPrimary : Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Inicia sesión en tu cuenta',
          style: TextStyle(
            fontSize: 16,
            color: isDark ? AppColors.textSecondary : Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm(bool isDark) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
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
        ],
      ),
    );
  }

  Widget _buildLoginButton(AsyncValue<void> authState) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: authState.isLoading ? null : _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: authState.isLoading
            ? const CircularProgressIndicator(color: AppColors.textPrimary)
            : const Text(
                'Iniciar Sesión',
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

  Widget _buildForgotPassword(bool isDark) {
    return TextButton(
      onPressed: _showForgotPasswordDialog,
      child: Text(
        '¿Olvidaste tu contraseña?',
        style: TextStyle(color: AppColors.primary),
      ),
    );
  }

  Widget _buildRegisterLink(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¿No tienes cuenta? ',
          style: TextStyle(color: isDark ? AppColors.textSecondary : Colors.black54),
        ),
        TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegisterView()),
          ),
          child: const Text('Regístrate', style: TextStyle(color: AppColors.primary)),
        ),
      ],
    );
  }

  void _handleLogin() async {
    if (_formKey.currentState?.validate() == true) {
      final notifier = ref.read(authNotifierProvider.notifier);
      await notifier.signInWithEmail(
        _emailController.text.trim(),
        _passwordController.text,
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

  void _showForgotPasswordDialog() {
    final emailController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restablecer Contraseña'),
        content: TextField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              if (emailController.text.isNotEmpty) {
                await ref.read(authNotifierProvider.notifier)
                    .resetPassword(emailController.text.trim());
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Email de restablecimiento enviado'),
                    backgroundColor: AppColors.success,
                  ),
                );
              }
            },
            child: const Text('Enviar'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}