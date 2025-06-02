import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/providers/theme_provider.dart';

class PortfolioScreen extends ConsumerStatefulWidget {
  const PortfolioScreen({
    super.key,
    required this.title,
  });
  final String title;

  @override
  ConsumerState<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends ConsumerState<PortfolioScreen> {
  int _counter = 0;
  late Color _tempColor; // Temporary color for the dialog

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _showColorPickerDialog() {
    final currentThemeColor = ref.read(themeColorProvider);
    _tempColor = currentThemeColor; // Initialize temp color
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: _tempColor,
              onColorChanged: (color) {
                // Update temp color, not the provider directly
                _tempColor = color;
              },
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
    final currentThemeColor = ref.watch(themeColorProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: currentThemeColor),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            widget.title,
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.color_lens,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              iconSize: 30.0,
              onPressed: _showColorPickerDialog,
              tooltip: 'Change Theme Color',
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.surface,
                Theme.of(context).colorScheme.surface,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _incrementCounter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: const Text(
                    'Coming Soon',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'You have pushed the button this many times:',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  '$_counter',
                  style: TextStyle(
                    fontSize: 40,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
