import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/constants.dart';
import 'package:portfolio/common/screens/portfolio_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  final List<String> animatedWords = const ['Flutter', 'Dart', 'Firebase'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final onPrimary = theme.colorScheme.onPrimary;
    final inversePrimary = theme.colorScheme.inversePrimary;

    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 600;
    final double textSize = isWide ? 48 : 28;
    final double spacingSize = isWide ? 48 : 28;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [onPrimary, inversePrimary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Built with ',
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontSize: textSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 50,
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    ...animatedWords.map((word) {
                      return TypewriterAnimatedText(
                        word,
                        speed: const Duration(milliseconds: 100),
                        textStyle: theme.textTheme.headlineMedium?.copyWith(
                          color: theme.colorScheme.tertiary,
                          fontSize: textSize,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
                  ],
                ),
              ),
              SizedBox(height: spacingSize),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.work),
                    label: const Text('See Portfolio'),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const PortfolioScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.download),
                    label: const Text('Download Resume'),
                    onPressed: () {
                      final url = Uri.parse(resumeUrl);
                      launchUrl(url, mode: LaunchMode.externalApplication);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
