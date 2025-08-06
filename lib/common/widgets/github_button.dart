import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class GithubButton extends StatelessWidget {
  const GithubButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const FaIcon(FontAwesomeIcons.github),
      tooltip: 'GitHub',
      onPressed:
          () => launchUrl(Uri.parse('https://github.com/Jordan24/portfolio')),
    );
  }
}