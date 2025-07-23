import 'firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:portfolio/common/screens/welcome_screen.dart';
import 'package:portfolio/common/providers/theme_mode_provider.dart';
import 'package:portfolio/common/providers/theme_color_provider.dart';
import 'package:portfolio/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: PortfolioApp()));
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
