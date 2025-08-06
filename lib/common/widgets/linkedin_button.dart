import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkedinButton extends StatelessWidget {
  const LinkedinButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
            icon: const FaIcon(FontAwesomeIcons.linkedin),
            tooltip: 'LinkedIn',
            onPressed: () => launchUrl(Uri.parse('https://www.linkedin.com/in/jordanszymczyk/')),
          );
  }
}