import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:portfolio/common/providers/theme_mode_provider.dart';

class LeftDrawer extends ConsumerWidget {
  const LeftDrawer({super.key, required this.onColorPickerTapped});
  final VoidCallback onColorPickerTapped;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeModeProvider);
    final systemIsDark =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final isDarkMode =
        themeMode == ThemeMode.system
            ? systemIsDark
            : themeMode == ThemeMode.dark;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: theme.colorScheme.primary),
            child: Text(
              'Preferences',
              style: TextStyle(
                color: theme.colorScheme.onPrimary,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            title: Text(isDarkMode ? 'Light Mode' : 'Dark Mode'),
            onTap: () {
              final themeModeNotifier = ref.read(themeModeProvider.notifier);
              if (isDarkMode) {
                themeModeNotifier.setThemeMode(ThemeMode.light);
              } else {
                themeModeNotifier.setThemeMode(ThemeMode.dark);
              }
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('Theme Color'),
            onTap: () {
              Navigator.pop(context);
              onColorPickerTapped();
            },
          ),
        ],
      ),
    );
  }
}
