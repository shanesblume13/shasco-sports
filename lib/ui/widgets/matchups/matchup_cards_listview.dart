import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/matchup_model.dart';
import 'package:pick/core/models/pick_model.dart';
import 'package:pick/ui/widgets/matchups/matchup_card.dart';

class MatchupCardsListview extends HookConsumerWidget {
  MatchupCardsListview({
    Key? key,
    required this.matchups,
    this.picks,
  }) : super(key: key);

  final List<Matchup> matchups;
  final List<Pick>? picks;
  final List<Widget> matchupCards = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    for (var matchup in matchups) {
      matchupCards.add(
        MatchupCard(matchup: matchup),
      );
    }
    return ListView(children: matchupCards);
  }
}
