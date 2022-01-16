import 'package:flutter/material.dart';
import 'package:pick/core/models/league_model.dart';
import 'package:pick/ui/widgets/leagues/league_card.dart';

class LeagueCardsListview extends StatelessWidget {
  LeagueCardsListview({
    Key? key,
    required this.leagues,
  }) : super(key: key);

  final List<League> leagues;
  final List<Widget> leagueCards = [];

  @override
  Widget build(BuildContext context) {
    for (var league in leagues) {
      leagueCards.add(
        LeagueCard(league: league),
      );
    }
    return ListView(children: leagueCards);
  }
}
