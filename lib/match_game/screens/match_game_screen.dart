
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/match_game/providers/game_provider.dart';
import 'package:portfolio/match_game/widgets/card_widget.dart';

class MatchGameScreen extends ConsumerWidget {
  const MatchGameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameProvider);
    final gameNotifier = ref.read(gameProvider.notifier);

    if (gameState.isGameWon) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Congratulations!'),
            content: const Text('You won the game!'),
            actions: [
              TextButton(
                onPressed: () {
                  gameNotifier.initGame();
                  Navigator.of(context).pop();
                },
                child: const Text('Play Again'),
              ),
            ],
          ),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Match Game'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text('This simple match game was vibe coded in a couple minutes using Gemini CLI.'),
              ),
              Text(
                'Score: ${gameState.matchedPairs}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: gameState.cards.length,
                  itemBuilder: (context, index) {
                    final card = gameState.cards[index];
                    return CardWidget(
                      card: card,
                      onTap: () => gameNotifier.selectCard(card.id),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
