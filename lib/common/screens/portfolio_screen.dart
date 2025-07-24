import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/user/providers/auth_provider.dart';
import 'package:portfolio/common/providers/theme_mode_provider.dart';
import 'package:portfolio/common/providers/theme_color_provider.dart';
import 'package:portfolio/user/screens/auth_screen.dart';
import 'package:portfolio/user/screens/profile_screen.dart';

class PortfolioScreen extends ConsumerStatefulWidget {
  const PortfolioScreen({super.key});

  @override
  ConsumerState<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends ConsumerState<PortfolioScreen> {
  late Color _tempColor;

  void _showColorPickerDialog() {
    final currentThemeColor = ref.watch(themeColorProvider);
    _tempColor = currentThemeColor;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: MaterialColorPicker(
              colors: Colors.primaries,
              allowShades: false,
              selectedColor: currentThemeColor,
              onMainColorChange:
                  (color) => setState(() => _tempColor = color as Color),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                ref.read(themeColorProvider.notifier).setColor(_tempColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ref = this.ref;
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeModeProvider);
    final themeModeNotifier = ref.read(themeModeProvider.notifier);
    final systemIsDark =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final isDarkMode =
        themeMode == ThemeMode.system
            ? systemIsDark
            : themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Jordan's Portfolio",
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            iconSize: 30.0,
            color: theme.colorScheme.onPrimary,
            onPressed: () {
              if (isDarkMode) {
                themeModeNotifier.setThemeMode(ThemeMode.light);
              } else {
                themeModeNotifier.setThemeMode(ThemeMode.dark);
              }
            },
            tooltip: isDarkMode ? 'Light Mode' : 'Dark Mode',
          ),
          IconButton(
            icon: Icon(Icons.color_lens),
            color: theme.colorScheme.onPrimary,
            iconSize: 30.0,
            onPressed: _showColorPickerDialog,
            tooltip: 'Change Theme Color',
          ),
          Consumer(
            builder: (context, ref, child) {
              final isLoggedIn = ref.watch(authProvider) != null;
              return TextButton(
                onPressed:
                    isLoggedIn
                        ? () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ProfileScreen(),
                            ),
                          );
                        }
                        : () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AuthScreen(),
                            ),
                          );
                        },
                child: Text(
                  isLoggedIn ? 'Profile' : 'Login',
                  style: TextStyle(color: theme.colorScheme.onPrimary),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Consumer(
          builder: (context, ref, _) {
            final isLoggedIn = ref.watch(authProvider) != null;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to my portfolio!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'This is a work in progress and will be updated regularly.\n\nFeel free to explore!\n\nSome features require login.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  isLoggedIn
                      ? 'You are logged in!'
                      : 'Please log in at top right',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
