import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/user/providers/auth_provider.dart';
import 'package:portfolio/user/screens/profile_screen.dart';

class UserProfileAvatar extends ConsumerWidget {
  const UserProfileAvatar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
      },
      child: CircleAvatar(
        radius: 20,
        backgroundImage: user?.imageUrl != null && user!.imageUrl!.isNotEmpty
            ? NetworkImage(user.imageUrl!)
            : null,
        child: user?.imageUrl == null || user!.imageUrl!.isEmpty
            ? const Icon(Icons.person)
            : null,
      ),
    );
  }
}
