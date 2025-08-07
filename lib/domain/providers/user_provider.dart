import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user/user_model.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserModel?>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<UserModel?> {
  UserNotifier() : super(null) {
    _loadUser();
  }

  void _loadUser() {
    // Simulando datos del usuario
    state = const UserModel(
      id: '1',
      name: 'Usuario Demo',
      email: 'usuario@ejemplo.com',
      phone: '+34 123 456 789',
      language: 'es',
      notificationsEnabled: true,
      darkMode: false,
    );
  }

  void updateUser(UserModel user) {
    state = user;
  }

  void updateName(String name) {
    if (state != null) {
      state = state!.copyWith(name: name);
    }
  }

  void updateEmail(String email) {
    if (state != null) {
      state = state!.copyWith(email: email);
    }
  }

  void updatePhone(String phone) {
    if (state != null) {
      state = state!.copyWith(phone: phone);
    }
  }

  void updateLanguage(String language) {
    if (state != null) {
      state = state!.copyWith(language: language);
    }
  }

  void toggleNotifications() {
    if (state != null) {
      state = state!.copyWith(notificationsEnabled: !state!.notificationsEnabled);
    }
  }
}