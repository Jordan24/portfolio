import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/user/models/user.dart' as model;

class AuthNotifier extends StateNotifier<model.User?> {
  AuthNotifier() : super(null) {
    _loadUser();
  }

  Future<void> _loadUser() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get();
      if (userDoc.exists) {
        state = model.User.fromJson(firebaseUser.uid, userDoc.data()!);
      } else {
        // This case might happen if the user was created in auth but the document wasn't created in firestore
        final newUser = model.User(
          id: firebaseUser.uid,
          email: firebaseUser.email!,
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(newUser.id)
            .set(newUser.toJson());
        state = newUser;
      }
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      if (userDoc.exists) {
        state = model.User.fromJson(userCredential.user!.uid, userDoc.data()!);
      } else {
        final newUser = model.User(
          id: userCredential.user!.uid,
          email: email,
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(newUser.id)
            .set(newUser.toJson());
        state = newUser;
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> signUp(String email, String password, String? username) async {
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final newUser = model.User(
        id: userCredential.user!.uid,
        username: username,
        email: email,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(newUser.id)
          .set(newUser.toJson());
      state = newUser;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    state = null;
  }

  Future<void> updateUserData(model.User user) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .update(user.toJson());
      state = user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, model.User?>((ref) {
  return AuthNotifier();
});
