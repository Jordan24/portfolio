import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/common/data/auth_repository.dart';
import 'package:portfolio/common/data/user_repository.dart';
import 'package:portfolio/common/providers/repository_providers.dart';
import 'package:portfolio/user/models/user.dart';

final authProvider = StateNotifierProvider<AuthNotifier, User?>(
  (ref) => AuthNotifier(
    ref.watch(authRepositoryProvider),
    ref.watch(userRepositoryProvider),
  ),
);

class AuthNotifier extends StateNotifier<User?> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  AuthNotifier(this._authRepository, this._userRepository) : super(null) {
    _authRepository.authStateChanges.listen((user) async {
      if (user != null) {
        state = await _userRepository.getUser(user.id);
      } else {
        state = null;
      }
    });
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _authRepository.signInWithEmail(email, password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signUp(String email, String password) async { // Removed username
    try {
      await _authRepository.signUpWithEmail(email, password);
      final currentUser = await _authRepository.authStateChanges.first;
      if (currentUser != null) {
        final newUser = User(
          id: currentUser.id,
          email: email,
          username: null, // Set username to null
          profileImageUrl: '',
        );
        await _userRepository.updateUser(newUser);
      }
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
