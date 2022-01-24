import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/league_model.dart';
import 'package:pick/ui/widgets/leagues/league_card.dart';

class LeagueCardsListview extends HookConsumerWidget {
  LeagueCardsListview({
    Key? key,
    required this.leagues,
  }) : super(key: key);

  final List<League> leagues;
  final List<Widget> leagueCards = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    for (var league in leagues) {
      leagueCards.add(
        LeagueCard(league: league),
      );
    }
    return ListView(children: leagueCards);
  }
}
