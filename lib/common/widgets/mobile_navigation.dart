import 'package:flutter/material.dart';
import 'package:portfolio/common/screens/portfolio_screen.dart';
import 'package:portfolio/common/widgets/github_button.dart';
import 'package:portfolio/common/widgets/linkedin_button.dart';
import 'package:portfolio/common/widgets/resume_button.dart';

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
          IconButton(
            icon: const Icon(Icons.home, size: 28),
            tooltip: 'Home',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PortfolioScreen(),
                ),
              );
            },
          ),
          LinkedinButton(),
          GithubButton(),
          ResumeButton(),
        ],
      ),
    );
  }
}
