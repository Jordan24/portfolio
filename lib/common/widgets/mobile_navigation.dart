import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/common/screens/portfolio_screen.dart';
import 'package:portfolio/common/widgets/github_button.dart';
import 'package:portfolio/common/widgets/linkedin_button.dart';
import 'package:url_launcher/url_launcher.dart';

class MobileNavigation extends StatelessWidget {
  const MobileNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BottomAppBar(
      color: theme.colorScheme.primaryContainer,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LinkedinButton(),
          IconButton(
            icon: const Icon(Icons.home, size: 28),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PortfolioScreen(),
                ),
              );
            },
          ),
          GithubButton(),
        ],
      ),
    );
  }
}