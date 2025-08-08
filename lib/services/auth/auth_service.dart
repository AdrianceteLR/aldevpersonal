import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Registro con email y contraseña
  Future<UserCredential?> signUpWithEmail(String email, String password, String name) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Actualizar perfil con nombre
      await credential.user?.updateDisplayName(name);
      
      // Crear documento en Firestore
      await _createUserDocument(credential.user!, name);
      
      return credential;
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Inicio de sesión con email y contraseña
  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Inicio de sesión con Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      
      // Crear documento en Firestore si es nuevo usuario
      if (userCredential.additionalUserInfo?.isNewUser == true) {
        await _createUserDocument(
          userCredential.user!,
          userCredential.user!.displayName ?? 'Usuario',
        );
      }
      
      return userCredential;
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Cerrar sesión
  Future<void> signOut() async {
    await Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  // Restablecer contraseña
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Crear documento de usuario en Firestore
  Future<void> _createUserDocument(User user, String name) async {
    await _firestore.collection('users').doc(user.uid).set({
      'id': user.uid,
      'name': name,
      'email': user.email,
      'avatar': user.photoURL,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'language': 'es',
      'notificationsEnabled': true,
      'darkMode': false,
    });
  }

  // Manejo de excepciones
  String _handleAuthException(dynamic e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          return 'No se encontró una cuenta con este email';
        case 'wrong-password':
          return 'Contraseña incorrecta';
        case 'email-already-in-use':
          return 'Ya existe una cuenta con este email';
        case 'weak-password':
          return 'La contraseña es muy débil';
        case 'invalid-email':
          return 'Email inválido';
        case 'user-disabled':
          return 'Esta cuenta ha sido deshabilitada';
        case 'too-many-requests':
          return 'Demasiados intentos. Intenta más tarde';
        default:
          return 'Error de autenticación: ${e.message}';
      }
    }
    return 'Error inesperado: $e';
  }
}