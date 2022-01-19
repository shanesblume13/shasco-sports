import 'package:flutter/material.dart';

class Sport {
  int id;
  String name;
  IconData iconData;
  Color iconColor;

  Sport({
    required this.id,
    required this.name,
    required this.iconData,
    required this.iconColor,
  });

  static List<Sport> sports = [
    Sport(
      id: 0,
      name: 'Football',
      iconData: Icons.sports_football,
      iconColor: Colors.brown,
    ),
    Sport(
      id: 1,
      name: 'Basketball',
      iconData: Icons.sports_basketball,
      iconColor: Colors.orange,
    ),
  ];
}
