import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/pages/welcome_screen.dart';
import 'package:portfolio/providers/theme_mode_provider.dart';
import 'package:portfolio/providers/theme_provider.dart';
import 'package:portfolio/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

num add(num a, num b) {
  return a + b;
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeColor = ref.watch(themeColorProvider);
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp(
      title: 'Jordan Szymczyk - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightMode.copyWith(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: themeColor,
        ),
      ),
      darkTheme: AppTheme.darkMode.copyWith(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: themeColor,
        ),
      ),
      themeMode: themeMode,
      home: const WelcomeScreen(),
    );
  }
}
