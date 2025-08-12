import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/providers/auth_provider.dart';
import '../theme/app_colors.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;

  @override
  void build() {}

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    ref.notifyListeners();
  }

  Future<void> handleLogin(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      final notifier = ref.read(authNotifierProvider.notifier);
      await notifier.signInWithEmail(
        emailController.text.trim(),
        passwordController.text,
      );
      
      if (context.mounted) {
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

  Future<void> handleGoogleSignIn(BuildContext context) async {
    final notifier = ref.read(authNotifierProvider.notifier);
    await notifier.signInWithGoogle();
    
    if (context.mounted) {
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

  void showForgotPasswordDialog(BuildContext context) {
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

  String? validateEmail(String? value) {
    if (value?.isEmpty == true) return 'Email requerido';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
      return 'Email inválido';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value?.isEmpty == true) return 'Contraseña requerida';
    if (value!.length < 6) return 'Mínimo 6 caracteres';
    return null;
  }


}