import 'package:flutter/material.dart';
import 'package:pick/core/models/sport_model.dart';

class SportCrudModel {
  List<Sport> sports = [
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

  List<Sport> fetchSports() {
    return sports;
  }

  Sport getSportById(int id) {
    return sports.firstWhere((sport) => sport.id == id);
  }
}
