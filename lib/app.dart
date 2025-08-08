import 'package:aldevpersonal/presentation/theme/app_theme.dart';
import 'package:aldevpersonal/presentation/views/auth/auth_wrapper.dart';
import 'package:aldevpersonal/domain/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);
    
    return MaterialApp(
      title: 'Tu App Personal',
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      home: const AuthWrapper(),
    );
  }
}
