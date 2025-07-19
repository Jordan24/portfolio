import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<bool> {
  AuthNotifier() : super(FirebaseAuth.instance.currentUser != null) {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      state = user != null;
    });
  }

  Future<void> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      throw FirebaseAuthException(
        code: error.code,
        message: error.message ?? 'Authentication failed.',
      );
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      throw FirebaseAuthException(
        code: error.code,
        message: error.message ?? 'Authentication failed.',
      );
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  return AuthNotifier();
});
