import 'package:flutter/material.dart';
import 'package:pick/core/models/matchup_model.dart';
import 'package:pick/core/models/pick_model.dart';
import 'package:pick/ui/widgets/matchups/matchup_card.dart';
import 'package:collection/collection.dart';

class MatchupCardsListview extends StatelessWidget {
  MatchupCardsListview({
    Key? key,
    required this.matchups,
    this.picks,
  }) : super(key: key);

  final List<Matchup> matchups;
  final List<Pick>? picks;
  final List<Widget> matchupCards = [];

  @override
  Widget build(BuildContext context) {
    for (var matchup in matchups) {
      Pick? pick = picks?.firstWhereOrNull(
        (pick) => pick.matchupReference == matchup.reference,
      );
      matchupCards.add(
        MatchupCard(matchup: matchup, pick: pick),
      );
    }
    return ListView(children: matchupCards);
  }
}
