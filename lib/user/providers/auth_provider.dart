import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/common/data/auth_repository.dart';
import 'package:portfolio/common/providers/repository_providers.dart';
import 'package:portfolio/user/models/user.dart';

final authStateProvider = StreamProvider((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});

final authControllerProvider = Provider((ref) {
  return AuthController(ref.watch(authRepositoryProvider), ref);
});

class AuthController {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController(this._authRepository, this._ref);

  Future<void> signIn(String email, String password) async {
    try {
      await _authRepository.signInWithEmail(email, password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      await _authRepository.signUpWithEmail(email, password);
      final newUserCredentials = await _ref.read(authStateProvider.future);
      final newUser = User(
        id: newUserCredentials!.id,
        email: email,
        username: null,
        profileImageUrl: '',
      );
      await _ref.read(userRepositoryProvider).updateUser(newUser);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _authRepository.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
