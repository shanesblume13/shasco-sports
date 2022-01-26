import 'package:flutter/material.dart';
import 'package:pick/core/models/league_model.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/ui/widgets/legs/leg_card.dart';

class LegCardsListview extends StatelessWidget {
  LegCardsListview({
    Key? key,
    required this.league,
    required this.legs,
  }) : super(key: key);

  final League league;
  final List<Leg> legs;
  final List<Widget> legCards = [];

  @override
  Widget build(BuildContext context) {
    for (var leg in legs) {
      legCards.add(
        LegCard(league: league, leg: leg),
      );
    }
    return ListView(children: legCards);
  }
}
