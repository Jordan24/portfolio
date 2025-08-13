
class MatchCard {
  final int id;
  final String emoji;
  bool isFlipped;
  bool isMatched;

  MatchCard({
    required this.id,
    required this.emoji,
    this.isFlipped = false,
    this.isMatched = false,
  });
}
