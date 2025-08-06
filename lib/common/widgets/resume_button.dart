import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ResumeButton extends StatelessWidget {
  const ResumeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'resume_button',
      child: IconButton(
        icon: const FaIcon(FontAwesomeIcons.download),
        tooltip: 'Download Resume',
        onPressed: () {
          final url = Uri.parse(resumeUrl);
          launchUrl(url, mode: LaunchMode.externalApplication);
        },
      ),
    );
  }
}
