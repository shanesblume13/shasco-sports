import 'package:flutter/material.dart';
import 'package:pick/core/models/game.dart';
import 'package:pick/core/viewmodels/game_crud_model.dart';
import 'package:pick/ui/widgets/games/game_cards_listview.dart';
import 'package:provider/provider.dart';

class GamesView extends StatelessWidget {
  const GamesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameCrudModel>(context);
    final List<Game> games = gameProvider.fetchGames();

    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Games List'),
          ),
        ),
        body: GameCardsListview(games: games));
  }
}
