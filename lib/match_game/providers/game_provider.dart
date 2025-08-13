
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/match_game/models/match_card.dart';

class GameState {
  final List<MatchCard> cards;
  final List<int> flippedCardIndices;
  final int matchedPairs;
  final bool isGameWon;

  GameState({
    required this.cards,
    this.flippedCardIndices = const [],
    this.matchedPairs = 0,
    this.isGameWon = false,
  });

  GameState copyWith({
    List<MatchCard>? cards,
    List<int>? flippedCardIndices,
    int? matchedPairs,
    bool? isGameWon,
  }) {
    return GameState(
      cards: cards ?? this.cards,
      flippedCardIndices: flippedCardIndices ?? this.flippedCardIndices,
      matchedPairs: matchedPairs ?? this.matchedPairs,
      isGameWon: isGameWon ?? this.isGameWon,
    );
  }
}

class GameNotifier extends StateNotifier<GameState> {
  GameNotifier() : super(GameState(cards: [])) {
    initGame();
  }

  final List<String> _emojis = [
        '🍎', '🍓', '🍊', '🍉', '🍒', '🍍', '🍑', '🍋',
  ];

  void initGame() {
    final List<String> gameEmojis = [..._emojis, ..._emojis];
    gameEmojis.shuffle();

    state = GameState(
      cards: List.generate(
        gameEmojis.length,
        (index) => MatchCard(id: index, emoji: gameEmojis[index]),
      ),
    );
  }

  void selectCard(int cardId) {
    if (state.flippedCardIndices.length >= 2) {
      return; // Prevent flipping more than 2 cards
    }

    final newCards = List<MatchCard>.from(state.cards);
    final cardIndex = newCards.indexWhere((card) => card.id == cardId);
    if (cardIndex == -1 || newCards[cardIndex].isFlipped) {
      return; // Card already flipped or not found
    }

    newCards[cardIndex].isFlipped = true;
    final newFlippedCardIndices = [...state.flippedCardIndices, cardIndex];

    state = state.copyWith(cards: newCards, flippedCardIndices: newFlippedCardIndices);

    if (state.flippedCardIndices.length == 2) {
      _checkForMatch();
    }
  }

  void _checkForMatch() {
    final card1Index = state.flippedCardIndices[0];
    final card2Index = state.flippedCardIndices[1];
    final card1 = state.cards[card1Index];
    final card2 = state.cards[card2Index];

    if (card1.emoji == card2.emoji) {
      final newCards = List<MatchCard>.from(state.cards);
      newCards[card1Index].isMatched = true;
      newCards[card2Index].isMatched = true;
      final newMatchedPairs = state.matchedPairs + 1;

      state = state.copyWith(
        cards: newCards,
        flippedCardIndices: [],
        matchedPairs: newMatchedPairs,
        isGameWon: newMatchedPairs == _emojis.length,
      );
    } else {
      Timer(const Duration(seconds: 1), () {
        final newCards = List<MatchCard>.from(state.cards);
        newCards[card1Index].isFlipped = false;
        newCards[card2Index].isFlipped = false;
        state = state.copyWith(cards: newCards, flippedCardIndices: []);
      });
    }
  }
}

final gameProvider = StateNotifierProvider<GameNotifier, GameState>((ref) {
  return GameNotifier();
});
