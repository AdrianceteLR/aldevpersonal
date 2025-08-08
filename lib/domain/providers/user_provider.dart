// ignore_for_file: unused_result

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user/user_model.dart';
import 'auth_provider.dart';

final userProvider = FutureProvider<UserModel?>((ref) async {
  final authUser = ref.watch(currentUserProvider);
  
  if (authUser == null) return null;
  
  try {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(authUser.uid)
        .get();
    
    if (doc.exists) {
      final data = doc.data()!;
      return UserModel(
        id: data['id'] ?? authUser.uid,
        name: data['name'] ?? authUser.displayName ?? 'Usuario',
        email: data['email'] ?? authUser.email ?? '',
        avatar: data['avatar'] ?? authUser.photoURL,
        phone: data['phone'],
        language: data['language'] ?? 'es',
        notificationsEnabled: data['notificationsEnabled'] ?? true,
        darkMode: data['darkMode'] ?? false,
        createdAt: data['createdAt']?.toDate(),
        updatedAt: data['updatedAt']?.toDate(),
      );
    } else {
      return UserModel(
        id: authUser.uid,
        name: authUser.displayName ?? 'Usuario',
        email: authUser.email ?? '',
        avatar: authUser.photoURL,
      );
    }
  } catch (e) {
    return UserModel(
      id: authUser.uid,
      name: authUser.displayName ?? 'Usuario',
      email: authUser.email ?? '',
      avatar: authUser.photoURL,
    );
  }
});

final userUpdateProvider = Provider<UserUpdateService>((ref) {
  return UserUpdateService(ref);
});

class UserUpdateService {
  final Ref _ref;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserUpdateService(this._ref);

  Future<void> updateUser(UserModel user) async {
    final authUser = _ref.read(currentUserProvider);
    if (authUser == null) return;
    
    try {
      await _firestore.collection('users').doc(authUser.uid).update({
        'name': user.name,
        'email': user.email,
        'phone': user.phone,
        'language': user.language,
        'notificationsEnabled': user.notificationsEnabled,
        'darkMode': user.darkMode,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      
      // Refresh user provider
      _ref.refresh(userProvider);
    } catch (e) {
      throw Exception('Error updating user: $e');
    }
  }
}