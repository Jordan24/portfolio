import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/user/providers/auth_provider.dart';
import 'package:portfolio/common/providers/theme_color_provider.dart';
import 'package:portfolio/user/screens/auth_screen.dart';
import 'package:portfolio/user/widgets/left_drawer.dart';
import 'package:portfolio/user/widgets/user_profile_menu.dart';

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
          actions: [
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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        actionsPadding: const EdgeInsets.symmetric(horizontal: 8),
        title: Text(
          "Jordan's Demo App",
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final isLoggedIn = ref.watch(authStateProvider).value != null;
              if (isLoggedIn) {
                return const UserProfileMenu();
              }
              return TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AuthScreen()),
                  );
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: theme.colorScheme.onPrimary),
                ),
              );
            },
          ),
        ],
      ),
      drawer: LeftDrawer(onColorPickerTapped: _showColorPickerDialog),
      body: Center(
        child: Consumer(
          builder: (context, ref, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                    'images/Headshot-cropped-Jordan.png',
                  ),
                  radius: 120,
                ),
                SizedBox(height: 20),
                Text(
                  'Welcome to my demo app!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'This is a work in progress and will be updated regularly with commonly requested features.\nAll functionality has been hand coded as a demonstration.\nFeel free to explore!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 64),
                    AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        ...[
                          'Authentication',
                          'File Upload',
                          'Database Manipulation',
                          'Theming',
                          'Light/Dark Mode',
                        ].map((word) {
                          return RotateAnimatedText(
                            word,
                            duration: Duration(seconds: 2),
                            textStyle: theme.textTheme.headlineMedium?.copyWith(
                              color: theme.colorScheme.tertiary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
