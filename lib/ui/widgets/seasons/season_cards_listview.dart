import 'package:flutter/material.dart';
import 'package:pick/core/models/season_model.dart';
import 'package:pick/ui/widgets/seasons/season_card.dart';

class SeasonCardsListview extends StatelessWidget {
  SeasonCardsListview({
    Key? key,
    required this.seasons,
  }) : super(key: key);

  final List<Season> seasons;
  final List<Widget> seasonCards = [];

  @override
  Widget build(BuildContext context) {
    for (var season in seasons) {
      seasonCards.add(
        SeasonCard(season: season),
      );
    }
    return ListView(children: seasonCards);
  }
}
