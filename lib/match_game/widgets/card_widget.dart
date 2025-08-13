import 'package:flutter/material.dart';
import 'package:portfolio/match_game/models/match_card.dart';

class CardWidget extends StatelessWidget {
  final MatchCard card;
  final VoidCallback onTap;

  const CardWidget({super.key, required this.card, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: card.isFlipped ? 1 : 0),
        duration: const Duration(milliseconds: 500),
        builder: (context, value, child) {
          final angle = value * 3.1415926535897932; // pi
          final isFront = value >= 0.5;

          return Transform(
            alignment: Alignment.center,
            transform:
                Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(angle),
            child:
                isFront
                    ? Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(3.1415926535897932),
                      child: _buildCardFace(context),
                    )
                    : _buildCardBack(context),
          );
        },
      ),
    );
  }

  Widget _buildCardBack(BuildContext context) {
    return Container(
      key: const ValueKey('back'),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildCardFace(BuildContext context) {
    return Container(
      key: const ValueKey('front'),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          card.emoji,
          style: const TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
