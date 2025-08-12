import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/providers/auth_provider.dart';
import '../../domain/providers/theme_provider.dart';

part 'more_controller.g.dart';

@riverpod
class MoreController extends _$MoreController {
  @override
  bool build() {
    return ref.watch(themeProvider);
  }

  bool get isDarkMode => state;

  void toggleTheme() {
    ref.read(themeProvider.notifier).toggleTheme();
  }

  Future<void> signOut() async {
    await ref.read(authNotifierProvider.notifier).signOut();
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar Sesión'),
        content: const Text('¿Estás seguro de que quieres cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              signOut();
            },
            child: const Text('Cerrar Sesión'),
          ),
        ],
      ),
    );
  }
}