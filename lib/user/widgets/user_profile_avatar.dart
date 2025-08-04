import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/user/providers/user_provider.dart';

class UserProfileAvatar extends ConsumerWidget {
  const UserProfileAvatar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider).value;

    return GestureDetector(
      child: CircleAvatar(
        radius: 20,
        backgroundImage: user?.profileImageUrl != null && user!.profileImageUrl!.isNotEmpty
            ? NetworkImage(user.profileImageUrl!)
            : null,
        child: user?.profileImageUrl == null || user!.profileImageUrl!.isEmpty
            ? const Icon(Icons.person)
            : null,
      ),
    );
  }
}
