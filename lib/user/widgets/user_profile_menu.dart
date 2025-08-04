import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/user/providers/auth_provider.dart';
import 'package:portfolio/user/screens/profile_screen.dart';
import 'package:portfolio/user/widgets/user_profile_avatar.dart';

class UserProfileMenu extends ConsumerWidget {
  const UserProfileMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    return PopupMenuButton(
      child: UserProfileAvatar(),
      itemBuilder:
          (BuildContext context) => [
            PopupMenuItem(
              value: 'edit_profile',
              child: Row(
                spacing: 8,
                children: [
                  Icon(Icons.edit, color: theme.colorScheme.primary),
                  Text(
                    'Edit Profile',
                    style: TextStyle(color: theme.colorScheme.primary),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'logout',
              child: Row(
                spacing: 8,
                children: [
                  Icon(Icons.logout, color: theme.colorScheme.primary),
                  Text(
                    'Logout',
                    style: TextStyle(color: theme.colorScheme.primary),
                  ),
                ],
              ),
            ),
          ],
      onSelected: (String value) {
        if (value == 'edit_profile') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
        } else if (value == 'logout') {
          ref.read(authControllerProvider).signOut();

          Navigator.of(context).pop();
        }
      },
    );
  }
}
