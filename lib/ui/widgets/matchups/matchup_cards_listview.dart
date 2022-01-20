import 'package:flutter/material.dart';
import 'package:pick/core/models/matchup_model.dart';
import 'package:pick/ui/widgets/matchups/matchup_card.dart';

class MatchupCardsListview extends StatelessWidget {
  MatchupCardsListview({
    Key? key,
    required this.matchups,
  }) : super(key: key);

  final List<Matchup> matchups;
  final List<Widget> matchupCards = [];

  @override
  Widget build(BuildContext context) {
    for (var matchup in matchups) {
      matchupCards.add(
        MatchupCard(matchup: matchup),
      );
    }
    return ListView(children: matchupCards);
  }
}
