import 'package:flutter/material.dart';
import 'package:pick/core/models/game.dart';

class GameCrudModel {
  List<Game> games = [
    Game(
      id: 0,
      name: 'Pick\'em',
      iconData: Icons.sports_football,
    ),
    Game(
      id: 1,
      name: 'Squares',
      iconData: Icons.sports_basketball,
    ),
  ];

  List<Game> fetchGames() {
    return games;
  }

  Game getGameById(int id) {
    return games.firstWhere((game) => game.id == id);
  }

  Game getGameByName(String name) {
    return games
        .firstWhere((game) => game.name.toLowerCase() == name.toLowerCase());
  }
}
