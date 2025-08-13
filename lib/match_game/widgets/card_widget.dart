
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
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return RotationYTransition(
            turns: animation,
            child: child,
          );
        },
        child: card.isFlipped
            ? _buildCardFace()
            : _buildCardBack(),
      ),
    );
  }

  Widget _buildCardBack() {
    return Container(
      key: const ValueKey('back'),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildCardFace() {
    return Container(
      key: const ValueKey('front'),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue),
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

class RotationYTransition extends AnimatedWidget {
  final Animation<double> turns;
  final Widget child;

  const RotationYTransition({
    super.key,
    required this.turns,
    required this.child,
  }) : super(listenable: turns);

  @override
  Widget build(BuildContext context) {
    final isFront = turns.value < 0.5;
    final matrix = Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..rotateY(3.14 * turns.value);
    return Transform(
      transform: matrix,
      alignment: Alignment.center,
      child: isFront ? child : Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(3.14),
        child: child,
      ),
    );
  }
}
