import 'package:flutter/material.dart';
import 'package:pick/core/models/game_model.dart';
import 'package:pick/ui/widgets/games/game_card.dart';

class GameCardsListview extends StatelessWidget {
  GameCardsListview({
    Key? key,
    required this.games,
  }) : super(key: key);

  final List<Game> games;
  final List<Widget> gameCards = [];

  @override
  Widget build(BuildContext context) {
    for (var game in games) {
      gameCards.add(
        GameCard(game: game),
      );
    }
    return ListView(children: gameCards);
  }
}
