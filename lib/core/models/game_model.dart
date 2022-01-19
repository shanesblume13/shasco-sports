import 'package:flutter/material.dart';

class Game {
  int id;
  String name;
  IconData iconData;

  Game({
    required this.id,
    required this.name,
    required this.iconData,
  });

  static List<Game> games = [
    Game(
      id: 0,
      name: 'Pick\'em',
      iconData: Icons.list,
    ),
    Game(
      id: 1,
      name: 'Squares',
      iconData: Icons.apps,
    ),
  ];
}
