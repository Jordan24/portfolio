
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:portfolio/common/data/auth_repository.dart';
import 'package:portfolio/user/models/user.dart';

class FirebaseAuthRepository implements AuthRepository {
  final firebase.FirebaseAuth _firebaseAuth;

  FirebaseAuthRepository(this._firebaseAuth);

  @override
  Stream<User?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null ? null : User.fromFirebase(firebaseUser);
    });
  }

  @override
  Future<void> signInWithEmail(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signUpWithEmail(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
