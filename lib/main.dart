import 'package:flutter/material.dart';
import 'package:portfolio/pages/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

num add(num a, num b) {
  return a + b;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color currentColor = const Color.fromARGB(255, 0, 32, 58);


  void _updateThemeColor(Color newColor) {
    setState(() {
      currentColor = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jordan Szymczyk - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: currentColor,
          brightness: Brightness.dark,
        ),
      ),
      home: WelcomeScreen(
        onThemeColorChange: _updateThemeColor,
        currentThemeColor: currentColor,
      ),
    );
  }
}
