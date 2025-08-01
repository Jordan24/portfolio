import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/common/providers/repository_providers.dart';
import 'package:portfolio/user/models/user.dart';
import 'package:portfolio/user/providers/auth_provider.dart';

final userProvider = StreamProvider<User?>((ref) {
  final authState = ref.watch(authStateProvider).value;
  if (authState == null) {
    return Stream.value(null);
  }
  final userRepository = ref.watch(userRepositoryProvider);
  return userRepository.getUserStream(authState.id);
});
