import 'package:flutter/material.dart';

class Sport {
  int id;
  String name;
  IconData iconData;

  Sport({
    required this.id,
    required this.name,
    required this.iconData,
  });

  static List<Sport> sports = [
    Sport(
      id: 0,
      name: 'Football',
      iconData: Icons.sports_football,
    ),
    Sport(
      id: 1,
      name: 'Basketball',
      iconData: Icons.sports_basketball,
    ),
  ];
}
