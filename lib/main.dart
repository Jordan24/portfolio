import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/pages/welcome_screen.dart';
import 'package:portfolio/providers/theme_mode_provider.dart';
import 'package:portfolio/providers/theme_color_provider.dart';
import 'package:portfolio/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: PortfolioApp()));
}

num add(num a, num b) {
  return a + b;
}

class PortfolioApp extends ConsumerWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeColor = ref.watch(themeColorProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: 'Jordan Szymczyk - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(themeColor),
      darkTheme: AppTheme.dark(themeColor),
      themeMode: themeMode,
      home: const WelcomeScreen(),
    );
  }
}
