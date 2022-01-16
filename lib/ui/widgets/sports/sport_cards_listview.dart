import 'package:flutter/material.dart';
import 'package:pick/core/models/sport_model.dart';
import 'package:pick/ui/widgets/sports/sport_card.dart';

class SportCardsListview extends StatelessWidget {
  SportCardsListview({
    Key? key,
    required this.sports,
  }) : super(key: key);

  final List<Sport> sports;
  final List<Widget> sportCards = [];

  @override
  Widget build(BuildContext context) {
    for (var sport in sports) {
      sportCards.add(
        SportCard(sport: sport),
      );
    }
    return ListView(children: sportCards);
  }
}
