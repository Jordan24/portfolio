import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/pages/portfolio_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({
    super.key,
    required this.onThemeColorChange,
    required this.currentThemeColor,
  });

  final void Function(Color) onThemeColorChange;
  final Color currentThemeColor;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  final List<String> animatedWords = ['Flutter', 'Dart', 'Firebase'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onPrimary = theme.colorScheme.onPrimary;
    final inversePrimary = theme.colorScheme.inversePrimary;

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
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.work),
                    label: const Text('See Portfolio'),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) => PortfolioScreen(
                                title: "Jordan's Portfolio",
                                onThemeColorChanged: widget.onThemeColorChange,
                                currentThemeColor: widget.currentThemeColor,
                              ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.download),
                    label: const Text('Download Resume'),
                    onPressed: () {
                      // TODO: Implement resume download functionality
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
